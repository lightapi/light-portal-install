\set ON_ERROR_STOP on
BEGIN;
SELECT pg_advisory_xact_lock(hashtext('portal-db-operational-store-p7-closure'));

DROP TRIGGER IF EXISTS operational_store_legacy_job_write_guard_trg
    ON operational_store_provisioning_job_t;
DROP TRIGGER IF EXISTS operational_store_legacy_profile_write_guard_trg
    ON operational_store_profile_t;

UPDATE operational_store_profile_t
SET active=false, update_user='p7-compatibility-closure', update_ts=CURRENT_TIMESTAMP
WHERE deployment_profile IN ('DEV_DEDICATED','DEV_POOLED') AND active;

UPDATE operational_store_provisioning_job_t
SET job_state='CANCELLED', lease_owner=NULL, lease_expires_ts=NULL,
    last_error_code=COALESCE(last_error_code,'P7_PROVISIONING_RETIRED'),
    update_ts=CURRENT_TIMESTAMP
WHERE job_state IN ('PENDING','CLAIMED');

CREATE OR REPLACE FUNCTION operational_store_legacy_write_guard()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    RAISE EXCEPTION 'version-1 operational-store provisioning is read-only';
END
$$;

CREATE TRIGGER operational_store_legacy_job_write_guard_trg
BEFORE INSERT OR UPDATE OR DELETE ON operational_store_provisioning_job_t
FOR EACH ROW EXECUTE FUNCTION operational_store_legacy_write_guard();

CREATE TRIGGER operational_store_legacy_profile_write_guard_trg
BEFORE INSERT OR UPDATE OR DELETE ON operational_store_profile_t
FOR EACH ROW EXECUTE FUNCTION operational_store_legacy_write_guard();

COMMIT;
