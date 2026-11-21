#!/usr/bin/env bash
# Apply numbered SQL migrations safely by recording successfully applied filenames.
# Requires bash + mysql/mariadb CLI. Run from repo root.
set -euo pipefail

DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-3306}"
DB_NAME="${DB_NAME:-zentirka_rp}"
DB_USER="${DB_USER:-root}"
MYSQL_BIN="${MYSQL_BIN:-mysql}"

if ! command -v "$MYSQL_BIN" >/dev/null 2>&1; then
  echo "ERROR: mysql/mariadb CLI not found." >&2
  exit 1
fi
if [[ -z "${DB_PASSWORD:-}" ]]; then
  echo "Set DB_PASSWORD in your shell environment (do not put it in Git)." >&2
  exit 1
fi

mysql_args=(--host="$DB_HOST" --port="$DB_PORT" --user="$DB_USER" --database="$DB_NAME" --default-character-set=utf8mb4)
export MYSQL_PWD="$DB_PASSWORD"
"$MYSQL_BIN" "${mysql_args[@]}" < database/central/00_migration_ledger.sql

shopt -s nullglob
migration_files=(database/migrations/[0-9]*.sql)
if ( ${#migration_files[@]} == 0 ); then
  echo "No numbered migrations found. Ledger is ready."
  exit 0
fi

for file in "${migration_files[@]}"; do
  migration="$(basename "$file")"
  applied="$("$MYSQL_BIN" "${mysql_args[@]}" --batch --skip-column-names -e "SELECT COUNT(*) FROM zentirka_rp_migrations WHERE migration='$migration';")"
  if [[ "$applied" == "1" ]]; then
    echo "SKIP already applied: $migration"
    continue
  fi
  echo "Applying: $migration"
  "$MYSQL_BIN" "${mysql_args[@]}" < "$file"
  checksum="$(sha256sum "$file" | awk '{print $1}')"
  "$MYSQL_BIN" "${mysql_args[@]}" --execute="INSERT INTO zentirka_rp_migrations (migration, checksum_sha256, applied_by) VALUES ('$migration', '$checksum', CURRENT_USER());"
  echo "OK: $migration"
done

echo "Migration process complete."
