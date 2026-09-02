\set ON_ERROR_STOP on
BEGIN;
SELECT pg_advisory_xact_lock(hashtext('portal-db-operational-store-registration-v2'));

DROP TRIGGER IF EXISTS operational_store_legacy_profile_write_guard_trg
  ON operational_store_profile_t;

INSERT INTO operational_store_profile_t(
  profile_id,profile_version,deployment_profile,provider,profile_config,
  aggregate_version,active,update_user)
VALUES ('customer-managed-registration-v2',2,'CUSTOMER_MANAGED','CUSTOMER_MANAGED',
  '{"databaseProvisionedExternally":true,"hostScoped":true,"portalDatabaseAccess":false}'::jsonb,
  1,true,'registration-v2-bootstrap')
ON CONFLICT(profile_id,profile_version) DO NOTHING;

ALTER TABLE operational_store_binding_t
  ADD COLUMN IF NOT EXISTS contract_version bigint DEFAULT 1 NOT NULL,
  ADD COLUMN IF NOT EXISTS engine varchar(32),
  ADD COLUMN IF NOT EXISTS server_host varchar(253),
  ADD COLUMN IF NOT EXISTS port integer,
  ADD COLUMN IF NOT EXISTS tls_mode varchar(32),
  ADD COLUMN IF NOT EXISTS runtime_username varchar(63),
  ADD COLUMN IF NOT EXISTS credential_source varchar(32),
  ADD COLUMN IF NOT EXISTS minimum_schema_generation bigint;

ALTER TABLE operational_store_binding_t ALTER COLUMN environment DROP NOT NULL;
ALTER TABLE operational_store_publication_t ALTER COLUMN environment DROP NOT NULL;

ALTER TABLE operational_store_binding_t
  DROP CONSTRAINT IF EXISTS operational_store_binding_contract_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_environment_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_scope_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_state_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_generation_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_secret_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_secret_scope_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_publication_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_no_secret_ck,
  DROP CONSTRAINT IF EXISTS operational_store_binding_registration_fields_ck;

ALTER TABLE operational_store_binding_t
  ADD CONSTRAINT operational_store_binding_contract_ck CHECK(contract_version IN (1,2)),
  ADD CONSTRAINT operational_store_binding_environment_ck CHECK(
    environment IS NULL OR environment~'^[a-z][a-z0-9_-]{0,31}$'),
  ADD CONSTRAINT operational_store_binding_scope_ck CHECK(
    (contract_version=1 AND scope_kind='HOST_ENVIRONMENT' AND scope_id=host_id AND environment IS NOT NULL)
    OR (contract_version=2 AND scope_kind='HOST' AND scope_id=host_id AND environment IS NULL)),
  ADD CONSTRAINT operational_store_binding_state_ck CHECK(
    (contract_version=1 AND lifecycle_state IN ('REQUESTED','PROVISIONING','READY','FAILED','ROTATING',
      'DEACTIVATION_REQUESTED','DEACTIVATED','RETENTION_HOLD','DECOMMISSION_REQUESTED',
      'DECOMMISSIONING','DECOMMISSIONED'))
    OR (contract_version=2 AND lifecycle_state IN ('REGISTERED','DEACTIVATED','UNREGISTERED'))),
  ADD CONSTRAINT operational_store_binding_generation_ck CHECK(
    desired_generation>0 AND observed_generation>=0 AND observed_generation<=desired_generation
    AND credential_generation>0 AND credential_generation<=9007199254740991
    AND (contract_version=1 OR (minimum_schema_generation>0
      AND minimum_schema_generation<=9007199254740991))),
  ADD CONSTRAINT operational_store_binding_secret_ck CHECK(
    (contract_version=1 AND secret_ref~'^operational-store/[0-9a-f-]{36}/[a-z][a-z0-9_-]{0,31}/runtime$')
    OR (contract_version=2 AND length(secret_ref) BETWEEN 1 AND 512)),
  ADD CONSTRAINT operational_store_binding_secret_scope_ck CHECK(
    contract_version=2 OR secret_ref='operational-store/'||host_id::text||'/'||environment||'/runtime'),
  ADD CONSTRAINT operational_store_binding_publication_ck CHECK(
    NOT published OR (contract_version=1 AND lifecycle_state='READY')
      OR (contract_version=2 AND lifecycle_state='REGISTERED')),
  ADD CONSTRAINT operational_store_binding_no_secret_ck CHECK(
    secret_ref!~*'(postgres(ql)?://|password=|pwd=)'),
  ADD CONSTRAINT operational_store_binding_registration_fields_ck CHECK(
    contract_version=1 OR (
      engine='POSTGRESQL'
      AND server_host~'^[A-Za-z0-9](?:[A-Za-z0-9._-]{0,251}[A-Za-z0-9])?$'
      AND port BETWEEN 1 AND 65535
      AND tls_mode IN ('DISABLE','PREFER','REQUIRE','VERIFY_CA','VERIFY_FULL')
      AND credential_source='MOUNTED_FILE'
      AND secret_ref LIKE '/%'
    ));

CREATE UNIQUE INDEX IF NOT EXISTS operational_store_binding_active_host_v2_uk
  ON operational_store_binding_t(host_id)
  WHERE contract_version=2 AND active AND lifecycle_state<>'UNREGISTERED';

CREATE OR REPLACE FUNCTION operational_store_publication_guard()
RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE binding_state varchar(32); binding_published boolean; binding_host uuid;
        binding_environment varchar(32); binding_contract bigint;
BEGIN
 IF NEW.publication_state='ACTIVE' THEN
  SELECT lifecycle_state,published,host_id,environment,contract_version
    INTO binding_state,binding_published,binding_host,binding_environment,binding_contract
    FROM operational_store_binding_t WHERE binding_id=NEW.binding_id;
  IF binding_published IS DISTINCT FROM true OR binding_host IS DISTINCT FROM NEW.host_id
     OR (binding_contract=1 AND (binding_state IS DISTINCT FROM 'READY'
       OR binding_environment IS DISTINCT FROM NEW.environment))
     OR (binding_contract=2 AND (binding_state IS DISTINCT FROM 'REGISTERED'
       OR NEW.environment IS NOT NULL)) THEN
   RAISE EXCEPTION 'only an exact published operational-store binding may publish';
  END IF;
 END IF;
 RETURN NEW;
END
$$;

DO $restore_legacy_profile_guard$
BEGIN
  IF to_regprocedure('operational_store_legacy_write_guard()') IS NOT NULL THEN
    EXECUTE 'CREATE TRIGGER operational_store_legacy_profile_write_guard_trg '
      || 'BEFORE INSERT OR UPDATE OR DELETE ON operational_store_profile_t '
      || 'FOR EACH ROW EXECUTE FUNCTION operational_store_legacy_write_guard()';
  END IF;
END
$restore_legacy_profile_guard$;

COMMIT;
