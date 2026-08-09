\connect configserver

-- S3/S4 Knowledge Base embedding authority and immutable generation binding.
BEGIN;

CREATE TABLE IF NOT EXISTS knowledge_embedding_profile_t (
    profile_id UUID NOT NULL,
    profile_revision BIGINT NOT NULL CHECK(profile_revision > 0),
    host_id UUID,
    alias_owner_host_id UUID NOT NULL,
    public_alias_id UUID NOT NULL,
    expected_space_id VARCHAR(255) NOT NULL CHECK(length(expected_space_id) > 0),
    expected_space_revision BIGINT NOT NULL CHECK(expected_space_revision > 0),
    dimension INTEGER NOT NULL CHECK(dimension > 0),
    normalization VARCHAR(16) NOT NULL CHECK(normalization IN ('none','l2')),
    distance_metric VARCHAR(24) NOT NULL CHECK(distance_metric IN ('cosine','inner_product','l2')),
    document_input_transform_version VARCHAR(255) NOT NULL CHECK(length(document_input_transform_version) > 0),
    query_input_transform_version VARCHAR(255) NOT NULL CHECK(length(query_input_transform_version) > 0),
    qualification_digest VARCHAR(128) NOT NULL CHECK(length(qualification_digest) >= 64),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(profile_id, profile_revision),
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    FOREIGN KEY(alias_owner_host_id, public_alias_id)
        REFERENCES llm_public_alias_t(host_id, public_alias_id) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX IF NOT EXISTS knowledge_embedding_profile_global_space_uq
    ON knowledge_embedding_profile_t(expected_space_id, expected_space_revision,
                                     query_input_transform_version)
    WHERE host_id IS NULL AND active IS TRUE;
CREATE UNIQUE INDEX IF NOT EXISTS knowledge_embedding_profile_tenant_space_uq
    ON knowledge_embedding_profile_t(host_id, expected_space_id, expected_space_revision,
                                     query_input_transform_version)
    WHERE host_id IS NOT NULL AND active IS TRUE;

CREATE OR REPLACE VIEW knowledge_qualified_embedding_alias_v AS
SELECT a.host_id, a.host_id AS alias_owner_host_id, a.public_alias_id, a.alias_name,
       a.required_capabilities->'embeddingSpace' AS embedding_space,
       TRUE AS active, a.update_ts,
       count(*) AS eligible_route_count
  FROM llm_public_alias_t a
  JOIN llm_alias_route_t r ON r.host_id=a.host_id AND r.public_alias_id=a.public_alias_id
                          AND r.active IS TRUE
  JOIN llm_provider_deployment_t d ON d.host_id=r.host_id
                                  AND d.provider_deployment_id=r.provider_deployment_id
                                  AND d.active IS TRUE AND d.lifecycle_status='ACTIVE'
 WHERE a.active IS TRUE AND a.lifecycle_status='ACTIVE' AND a.operations ? 'embed'
   AND a.require_expected_embedding_space IS TRUE
   AND d.provider_protocol='openai_embeddings' AND d.conformance_state='PASS'
   AND d.conformance_valid_until > CURRENT_TIMESTAMP
   AND d.conformance_result->'capabilities'->'embedding'->'space' =
       a.required_capabilities->'embeddingSpace'
GROUP BY a.host_id,a.public_alias_id,a.alias_name,a.required_capabilities->'embeddingSpace',a.update_ts
HAVING bool_and(
    jsonb_array_length(d.conformance_result->'capabilities'->'embedding'->'supportedDimensions')=1
    AND d.conformance_result->'capabilities'->'embedding'->'supportedDimensions'
        @> jsonb_build_array((a.required_capabilities->'embeddingSpace'->>'dimension')::integer)
);

CREATE OR REPLACE FUNCTION qualify_knowledge_embedding_profile()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM knowledge_qualified_embedding_alias_v q
         WHERE q.alias_owner_host_id=NEW.alias_owner_host_id
           AND q.public_alias_id=NEW.public_alias_id
           AND q.embedding_space->>'spaceId'=NEW.expected_space_id
           AND (q.embedding_space->>'revision')::bigint=NEW.expected_space_revision
           AND (q.embedding_space->>'dimension')::integer=NEW.dimension
           AND q.embedding_space->>'normalization'=NEW.normalization
           AND q.embedding_space->>'distanceMetric'=NEW.distance_metric
           AND q.embedding_space->>'documentInputTransformVersion'=NEW.document_input_transform_version
    ) THEN
        RAISE EXCEPTION 'embedding profile must reference a currently qualified immutable Alias space';
    END IF;
    RETURN NEW;
END; $$;
DROP TRIGGER IF EXISTS knowledge_embedding_profile_qualification_trg ON knowledge_embedding_profile_t;
CREATE TRIGGER knowledge_embedding_profile_qualification_trg
BEFORE INSERT ON knowledge_embedding_profile_t
FOR EACH ROW EXECUTE FUNCTION qualify_knowledge_embedding_profile();

CREATE TABLE IF NOT EXISTS knowledge_retrieval_profile_t (
    profile_id UUID PRIMARY KEY,
    host_id UUID,
    strategy VARCHAR(16) NOT NULL DEFAULT 'HYBRID' CHECK(strategy IN ('LEXICAL','VECTOR','HYBRID')),
    lexical_candidates INTEGER NOT NULL CHECK(lexical_candidates > 0),
    vector_candidates INTEGER NOT NULL CHECK(vector_candidates > 0),
    top_k INTEGER NOT NULL CHECK(top_k > 0 AND top_k <= lexical_candidates + vector_candidates),
    token_budget INTEGER NOT NULL CHECK(token_budget > 0),
    fusion_method VARCHAR(16) NOT NULL DEFAULT 'RRF' CHECK(fusion_method='RRF'),
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS knowledge_base_t (
    knowledge_base_id UUID PRIMARY KEY,
    host_id UUID,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    environment VARCHAR(32) NOT NULL,
    status VARCHAR(24) NOT NULL DEFAULT 'DRAFT'
        CHECK(status IN ('DRAFT','ACTIVE','DISABLED','RETIRED')),
    acl_mode VARCHAR(24) NOT NULL DEFAULT 'UNIFORM_SCOPE'
        CHECK(acl_mode IN ('UNIFORM_SCOPE','MIRROR_SOURCE_ACL')),
    embedding_profile_id UUID NOT NULL,
    embedding_profile_revision BIGINT NOT NULL,
    version BIGINT NOT NULL DEFAULT 1 CHECK(version > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    FOREIGN KEY(host_id) REFERENCES host_t(host_id) ON DELETE RESTRICT,
    FOREIGN KEY(embedding_profile_id, embedding_profile_revision)
        REFERENCES knowledge_embedding_profile_t(profile_id, profile_revision) ON DELETE RESTRICT
);
CREATE UNIQUE INDEX IF NOT EXISTS knowledge_base_global_name_uq
    ON knowledge_base_t(environment, name) WHERE host_id IS NULL AND active IS TRUE;
CREATE UNIQUE INDEX IF NOT EXISTS knowledge_base_tenant_name_uq
    ON knowledge_base_t(host_id, environment, name) WHERE host_id IS NOT NULL AND active IS TRUE;

CREATE TABLE IF NOT EXISTS knowledge_index_generation_t (
    index_generation_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    embedding_profile_id UUID NOT NULL,
    embedding_profile_revision BIGINT NOT NULL,
    space_id VARCHAR(255) NOT NULL,
    space_revision BIGINT NOT NULL CHECK(space_revision > 0),
    dimension INTEGER NOT NULL CHECK(dimension > 0),
    parser_version VARCHAR(255) NOT NULL,
    chunker_version VARCHAR(255) NOT NULL,
    query_input_transform_version VARCHAR(255) NOT NULL,
    state VARCHAR(16) NOT NULL
        CHECK(state IN ('BUILDING','VALIDATING','PROMOTED','FAILED','SUPERSEDED','PURGED')),
    evidence JSONB NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(evidence)='object'),
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    promoted_ts TIMESTAMPTZ,
    FOREIGN KEY(knowledge_base_id) REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE RESTRICT,
    FOREIGN KEY(embedding_profile_id, embedding_profile_revision)
        REFERENCES knowledge_embedding_profile_t(profile_id, profile_revision) ON DELETE RESTRICT
);

CREATE OR REPLACE FUNCTION validate_knowledge_index_generation_profile()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM knowledge_embedding_profile_t p
         WHERE p.profile_id=NEW.embedding_profile_id
           AND p.profile_revision=NEW.embedding_profile_revision
           AND p.expected_space_id=NEW.space_id
           AND p.expected_space_revision=NEW.space_revision
           AND p.dimension=NEW.dimension
           AND p.query_input_transform_version=NEW.query_input_transform_version
    ) THEN
        RAISE EXCEPTION 'index generation must preserve its immutable embedding profile contract';
    END IF;
    RETURN NEW;
END; $$;
DROP TRIGGER IF EXISTS knowledge_index_generation_profile_trg ON knowledge_index_generation_t;
CREATE TRIGGER knowledge_index_generation_profile_trg
BEFORE INSERT OR UPDATE ON knowledge_index_generation_t
FOR EACH ROW EXECUTE FUNCTION validate_knowledge_index_generation_profile();

CREATE TABLE IF NOT EXISTS knowledge_index_pointer_t (
    knowledge_base_id UUID NOT NULL,
    embedding_profile_id UUID NOT NULL,
    embedding_profile_revision BIGINT NOT NULL,
    index_generation_id UUID NOT NULL,
    pointer_version BIGINT NOT NULL CHECK(pointer_version > 0),
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_user VARCHAR(126) NOT NULL DEFAULT SESSION_USER,
    PRIMARY KEY(knowledge_base_id, embedding_profile_id, embedding_profile_revision),
    FOREIGN KEY(knowledge_base_id) REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE CASCADE,
    FOREIGN KEY(index_generation_id) REFERENCES knowledge_index_generation_t(index_generation_id) ON DELETE RESTRICT
);

CREATE OR REPLACE FUNCTION validate_knowledge_index_pointer()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM knowledge_index_generation_t g
         WHERE g.index_generation_id=NEW.index_generation_id
           AND g.knowledge_base_id=NEW.knowledge_base_id
           AND g.embedding_profile_id=NEW.embedding_profile_id
           AND g.embedding_profile_revision=NEW.embedding_profile_revision
           AND g.state='PROMOTED'
    ) THEN
        RAISE EXCEPTION 'index pointer must select one matching promoted generation';
    END IF;
    RETURN NEW;
END; $$;
DROP TRIGGER IF EXISTS knowledge_index_pointer_valid_trg ON knowledge_index_pointer_t;
CREATE TRIGGER knowledge_index_pointer_valid_trg
BEFORE INSERT OR UPDATE ON knowledge_index_pointer_t
FOR EACH ROW EXECUTE FUNCTION validate_knowledge_index_pointer();

CREATE TABLE IF NOT EXISTS knowledge_consumer_quota_t (
    knowledge_base_id UUID NOT NULL,
    consumer_host_id UUID NOT NULL,
    max_concurrency INTEGER NOT NULL CHECK(max_concurrency > 0),
    requests_per_minute INTEGER NOT NULL CHECK(requests_per_minute > 0),
    max_cost_micros_per_day BIGINT NOT NULL CHECK(max_cost_micros_per_day > 0),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    update_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(knowledge_base_id, consumer_host_id),
    FOREIGN KEY(knowledge_base_id) REFERENCES knowledge_base_t(knowledge_base_id) ON DELETE CASCADE,
    FOREIGN KEY(consumer_host_id) REFERENCES host_t(host_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS knowledge_query_usage_t (
    usage_id UUID PRIMARY KEY,
    knowledge_base_id UUID NOT NULL,
    consumer_host_id UUID NOT NULL,
    request_id VARCHAR(255) NOT NULL,
    request_day DATE NOT NULL,
    charged_micros BIGINT NOT NULL CHECK(charged_micros >= 0),
    status VARCHAR(24) NOT NULL,
    created_ts TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(knowledge_base_id, consumer_host_id)
        REFERENCES knowledge_consumer_quota_t(knowledge_base_id, consumer_host_id) ON DELETE RESTRICT,
    UNIQUE(knowledge_base_id, consumer_host_id, request_id)
);

CREATE OR REPLACE FUNCTION enforce_knowledge_embedding_profile_immutable()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF ROW(NEW.host_id, NEW.alias_owner_host_id, NEW.public_alias_id,
           NEW.expected_space_id, NEW.expected_space_revision, NEW.dimension,
           NEW.normalization, NEW.distance_metric, NEW.document_input_transform_version,
           NEW.query_input_transform_version, NEW.qualification_digest)
       IS DISTINCT FROM
       ROW(OLD.host_id, OLD.alias_owner_host_id, OLD.public_alias_id,
           OLD.expected_space_id, OLD.expected_space_revision, OLD.dimension,
           OLD.normalization, OLD.distance_metric, OLD.document_input_transform_version,
           OLD.query_input_transform_version, OLD.qualification_digest) THEN
        RAISE EXCEPTION 'knowledge embedding profiles are immutable; create a new revision';
    END IF;
    RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS knowledge_embedding_profile_immutable_trg ON knowledge_embedding_profile_t;
CREATE TRIGGER knowledge_embedding_profile_immutable_trg
BEFORE UPDATE ON knowledge_embedding_profile_t
FOR EACH ROW EXECUTE FUNCTION enforce_knowledge_embedding_profile_immutable();

COMMIT;
