# Optional Local Key Material

The evaluation installer does not generate or mount operational database URL
files. Fixed local URLs are defined in `docker-compose.yml`; non-root services
materialize private compatibility files inside their own containers.

The `a2a-signing/` subdirectory remains available only for optional manual A2A
signing-key experiments. It is not required for normal installation or startup.
