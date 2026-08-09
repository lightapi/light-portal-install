\connect configserver

-- S1/S2 immutable embedding-space contract and required-expectation delivery.
-- This is a coordinated clean break for embedding conformance evidence and
-- projection roots, but it deliberately preserves model registrations,
-- provider deployments, aliases, routes, credentials, and pricing.
BEGIN;

DO $embedding_archive_precondition$
BEGIN
    IF to_regclass('llm_provider_deployment_embedding_conformance_archive_20260808') IS NOT NULL
       OR to_regclass('llm_projection_resource_archive_20260808') IS NOT NULL
       OR to_regclass('llm_gateway_publication_archive_20260808') IS NOT NULL
       OR to_regclass('llm_gateway_instance_publication_archive_20260808') IS NOT NULL
       OR to_regclass('llm_gateway_instance_property_ownership_archive_20260808') IS NOT NULL THEN
        RAISE EXCEPTION USING MESSAGE =
            'S1 embedding-space patch is single-shot and its rollback archive already exists; use the paired rollback procedure before retrying';
    END IF;
END
$embedding_archive_precondition$;

ALTER TABLE llm_public_alias_t
    ADD COLUMN IF NOT EXISTS require_expected_embedding_space BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE llm_public_alias_t
    ADD COLUMN IF NOT EXISTS embedding_workload_lane VARCHAR(16) NOT NULL DEFAULT 'standard';
ALTER TABLE llm_public_alias_t
    ADD COLUMN IF NOT EXISTS bound_workload_principal VARCHAR(255);

DO $embedding_alias_precondition$
BEGIN
    IF EXISTS (
        SELECT 1
          FROM llm_public_alias_t
         WHERE operations ? 'embed'
           AND NOT (
               jsonb_typeof(required_capabilities->'embeddingSpace') = 'object'
               AND length(required_capabilities->'embeddingSpace'->>'spaceId') BETWEEN 1 AND 255
               AND (required_capabilities->'embeddingSpace'->>'revision') ~ '^[1-9][0-9]*$'
               AND (required_capabilities->'embeddingSpace'->>'dimension') ~ '^[1-9][0-9]*$'
               AND required_capabilities->'embeddingSpace'->>'normalization' IN ('none','l2')
               AND required_capabilities->'embeddingSpace'->>'distanceMetric' IN ('cosine','inner_product','l2')
               AND length(required_capabilities->'embeddingSpace'->>'documentInputTransformVersion') BETWEEN 1 AND 255
           )
    ) THEN
        RAISE EXCEPTION USING MESSAGE =
            'embedding aliases require an operator-approved requiredCapabilities.embeddingSpace before the S1 cutover';
    END IF;
END
$embedding_alias_precondition$;

ALTER TABLE llm_public_alias_t
    DROP CONSTRAINT IF EXISTS llm_public_alias_embedding_space_ck,
    DROP CONSTRAINT IF EXISTS llm_public_alias_expected_space_required_ck,
    DROP CONSTRAINT IF EXISTS llm_public_alias_embedding_workload_lane_ck,
    DROP CONSTRAINT IF EXISTS llm_public_alias_embedding_lane_shape_ck,
    ADD CONSTRAINT llm_public_alias_embedding_space_ck CHECK (
        (operations ? 'embed' AND (
            jsonb_typeof(required_capabilities->'embeddingSpace') = 'object'
            AND length(required_capabilities->'embeddingSpace'->>'spaceId') BETWEEN 1 AND 255
            AND (required_capabilities->'embeddingSpace'->>'revision') ~ '^[1-9][0-9]*$'
            AND (required_capabilities->'embeddingSpace'->>'dimension') ~ '^[1-9][0-9]*$'
            AND required_capabilities->'embeddingSpace'->>'normalization' IN ('none','l2')
            AND required_capabilities->'embeddingSpace'->>'distanceMetric' IN ('cosine','inner_product','l2')
            AND length(required_capabilities->'embeddingSpace'->>'documentInputTransformVersion') BETWEEN 1 AND 255
            AND ((required_capabilities->'embeddingSpace') - ARRAY[
                'spaceId','revision','dimension','normalization','distanceMetric',
                'documentInputTransformVersion']::text[]) = '{}'::jsonb
        )) OR (NOT (operations ? 'embed') AND NOT (required_capabilities ? 'embeddingSpace'))
    ),
    ADD CONSTRAINT llm_public_alias_expected_space_required_ck CHECK (
        NOT require_expected_embedding_space OR operations ? 'embed'
    ),
    ADD CONSTRAINT llm_public_alias_embedding_workload_lane_ck CHECK (
        embedding_workload_lane IN ('standard','kb_query','kb_index')
    ),
    ADD CONSTRAINT llm_public_alias_embedding_lane_shape_ck CHECK (
        embedding_workload_lane = 'standard' OR (
            operations = '["embed"]'::jsonb
            AND require_expected_embedding_space
            AND alias_visibility = 'INTERNAL_WORKLOAD'
        )
    );

ALTER TABLE llm_public_alias_t DROP CONSTRAINT IF EXISTS llm_public_alias_visibility_ck;
ALTER TABLE llm_public_alias_t ADD CONSTRAINT llm_public_alias_visibility_ck CHECK (
    (alias_visibility = 'PUBLIC' AND bound_agent_def_id IS NULL AND bound_workload_principal IS NULL)
    OR (alias_visibility = 'INTERNAL_LEGACY' AND bound_agent_def_id IS NOT NULL AND bound_workload_principal IS NULL)
    OR (alias_visibility = 'INTERNAL_WORKLOAD' AND bound_agent_def_id IS NULL
        AND length(bound_workload_principal) BETWEEN 1 AND 255)
);

CREATE OR REPLACE FUNCTION enforce_llm_public_alias_embedding_space_immutable()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.operations IS DISTINCT FROM OLD.operations
     OR NEW.required_capabilities->'embeddingSpace'
        IS DISTINCT FROM OLD.required_capabilities->'embeddingSpace'
     OR NEW.require_expected_embedding_space IS DISTINCT FROM OLD.require_expected_embedding_space
     OR NEW.embedding_workload_lane IS DISTINCT FROM OLD.embedding_workload_lane THEN
    RAISE EXCEPTION 'Alias operation and embedding-space identity are immutable; create a new Alias revision';
  END IF;
  RETURN NEW;
END $$;
DROP TRIGGER IF EXISTS llm_public_alias_embedding_space_immutable_trg ON llm_public_alias_t;
CREATE TRIGGER llm_public_alias_embedding_space_immutable_trg
BEFORE UPDATE ON llm_public_alias_t FOR EACH ROW
EXECUTE FUNCTION enforce_llm_public_alias_embedding_space_immutable();

-- Retain a transactionally consistent rollback set before invalidating the
-- digest-bound conformance and publication artifacts.
CREATE TABLE llm_provider_deployment_embedding_conformance_archive_20260808 AS
SELECT host_id,provider_deployment_id,conformance_state,conformance_digest,
       conformance_valid_until,conformance_result
  FROM llm_provider_deployment_t WHERE provider_protocol='openai_embeddings';
CREATE TABLE llm_projection_resource_archive_20260808 AS TABLE llm_projection_resource_t WITH DATA;
CREATE TABLE llm_gateway_publication_archive_20260808 AS TABLE llm_gateway_publication_t WITH DATA;
CREATE TABLE llm_gateway_instance_publication_archive_20260808 AS TABLE llm_gateway_instance_publication_t WITH DATA;
CREATE TABLE llm_gateway_instance_property_ownership_archive_20260808
AS TABLE llm_gateway_instance_property_ownership_t WITH DATA;

-- Old embedding evidence cannot prove the newly digest-bound space contract.
UPDATE llm_provider_deployment_t
   SET conformance_state='UNKNOWN',
       conformance_digest=NULL,
       conformance_valid_until=NULL,
       conformance_result=NULL
 WHERE provider_protocol='openai_embeddings';

ALTER TABLE llm_provider_deployment_t
    DROP CONSTRAINT IF EXISTS llm_provider_deployment_embedding_space_evidence_ck,
    ADD CONSTRAINT llm_provider_deployment_embedding_space_evidence_ck CHECK(
        provider_protocol <> 'openai_embeddings' OR conformance_state <> 'PASS' OR (
            jsonb_typeof(conformance_result->'capabilities'->'embedding'->'space') = 'object'
            AND length(conformance_result->'capabilities'->'embedding'->'space'->>'spaceId') BETWEEN 1 AND 255
            AND (conformance_result->'capabilities'->'embedding'->'space'->>'revision') ~ '^[1-9][0-9]*$'
            AND (conformance_result->'capabilities'->'embedding'->'space'->>'dimension') ~ '^[1-9][0-9]*$'
            AND conformance_result->'capabilities'->'embedding'->'space'->>'normalization' IN ('none','l2')
            AND conformance_result->'capabilities'->'embedding'->'space'->>'distanceMetric' IN ('cosine','inner_product','l2')
            AND length(conformance_result->'capabilities'->'embedding'->'space'->>'documentInputTransformVersion') BETWEEN 1 AND 255
            AND ((conformance_result->'capabilities'->'embedding'->'space') - ARRAY[
                'spaceId','revision','dimension','normalization','distanceMetric',
                'documentInputTransformVersion']::text[]) = '{}'::jsonb
        )
    );

-- Active projection roots are rebuilt only after new evidence exists. The
-- archive tables above retain every host's exact pre-cutover artifacts for the
-- paired rollback script.
DELETE FROM llm_gateway_instance_property_ownership_t;
DELETE FROM llm_gateway_instance_publication_t;
DELETE FROM llm_gateway_publication_t;
DELETE FROM llm_projection_resource_t;

COMMIT;
