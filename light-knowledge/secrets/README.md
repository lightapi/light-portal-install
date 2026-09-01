# Optional Knowledge Secrets

The evaluation installer does not require files in this directory. Local
database URLs, delegation values, cache keys, signing keys, and service tokens
use fixed development values in `docker-compose.yml`.

Only LLM provider API keys need to be supplied by the user, through `.env`.
Production deployments use their own secret manager and are outside this
installer's scope.
