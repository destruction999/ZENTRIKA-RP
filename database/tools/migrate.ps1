# ZENTRIKA-RP migration runner for Windows PowerShell.
# Usage: set DB_PASSWORD in this PowerShell session, then run from repo root.
$ErrorActionPreference = "Stop"
$MysqlExe = if ($env:MYSQL_BIN) { $env:MYSQL_BIN } else { "mysql" }
$DbHost = if ($env:DB_HOST) { $env:DB_HOST } else { "127.0.0.1" }
$DbPort = if ($env:DB_PORT) { $env:DB_PORT } else { "3306" }
$DbName = if ($env:DB_NAME) { $env:DB_NAME } else { "zentirka_rp" }
$DbUser = if ($env:DB_USER) { $env:DB_USER } else { "root" }
if (-not $env:DB_PASSWORD) { throw "Set DB_PASSWORD in this PowerShell session; do not save it in Git." }
$env:MYSQL_PWD = $env:DB_PASSWORD
$argsMysql = @("--host=$DbHost", "--port=$DbPort", "--user=$DbUser", "--database=$DbName", "--default-character-set=utf8mb4")
& $MysqlExe @argsMysql < "database/central/00_migration_ledger.sql"
if ($LASTEXITCODE -ne 0) { throw "Could not create migration ledger." }
$migrationFiles = Get-ChildItem "database/migrations" -Filter "[0-9]*.sql" | Sort-Object Name
foreach ($file in $migrationFiles) {
  $migration = $file.Name.Replace("'", "''")
  $count = & $MysqlExe @argsMysql --batch --skip-column-names -e "SELECT COUNT(*) FROM zentirka_rp_migrations WHERE migration='$migration';"
  if ($LASTEXITCODE -ne 0) { throw "Could not check migration ledger for $migration" }
  if ($count.Trim() -eq "1") { Write-Host "SKIP already applied: $($file.Name)"; continue }
  Write-Host "Applying: $($file.Name)"
  & $MysqlExe @argsMysql < $file.FullName
  if ($LASTEXITCODE -ne 0) { throw "Migration failed: $($file.Name). Ledger was not updated." }
  $hash = (Get-FileHash $file.FullName -Algorithm SHA256).Hash.ToLower()
  & $MysqlExe @argsMysql -e "INSERT INTO zentirka_rp_migrations (migration, checksum_sha256, applied_by) VALUES ('$migration', '$hash', CURRENT_USER());"
  if ($LASTEXITCODE -ne 0) { throw "Migration ran but ledger recording failed for $migration" }
  Write-Host "OK: $($file.Name)"
}
Write-Host "Migration process complete."
