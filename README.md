## Toolbox container for backups and ops

A minimal Alpine-based container preloaded with common tools that are handy for backups, restores, and simple ops tasks.

### What’s inside
- curl
- sqlite3
- aws-cli v2
- mysql-client (mysqldump)
- postgresql client (pg_dump, psql)
- tar, gzip
- jq
- tzdata (TZ defaults to UTC)
- ca-certificates

The image runs as a non-root user "backup" and uses /backup as the working directory.

### Quick start
- Run an interactive shell:
  - docker run --rm -it ghcr.io/ohheyrj/toolbox:latest sh

- Mount your working directory:
  - docker run --rm -it -v "$PWD:/backup" ghcr.io/ohheyrj/toolbox:latest sh

### Examples
- PostgreSQL dump to local file:
  - pg_dump "postgres://user:pass@host:5432/dbname" -Fc -f db.dump

- MySQL dump to local file:
  - mysqldump -h host -u user -p dbname | gzip > db.sql.gz

- Tar and gzip a directory:
  - tar -czf site-backup.tar.gz /backup/site

- Upload to S3 (expects AWS creds via env or mounted config):
  - aws s3 cp db.dump s3://my-bucket/path/db.dump

Tip: Provide AWS credentials via environment variables or mounted files:
- -e AWS_ACCESS_KEY_ID=... -e AWS_SECRET_ACCESS_KEY=... -e AWS_DEFAULT_REGION=...
- Or mount ~/.aws: -v "$HOME/.aws:/home/backup/.aws:ro"

### Image tags and publishing
- latest: built from the default branch
- vX.Y.Z: built when you push a Git tag like v1.2.3

A GitHub Actions workflow builds and publishes the image to the GitHub Container Registry (GHCR) at:
- ghcr.io/ohheyrj/toolbox

### Releasing with automatic notes
When you push a Git tag (e.g., v1.2.3), the workflow creates a GitHub Release with automatically generated release notes.

### Local build (optional)
- docker build -t toolbox:dev .
- docker run --rm -it toolbox:dev sh

### Security notes
- Runs as non-root user: backup (uid 1000)
- Default timezone: UTC (set TZ if needed)

