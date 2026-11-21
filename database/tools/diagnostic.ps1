# Run the read-only SQL diagnostic from Windows PowerShell.
$ErrorActionPreference = "Stop"
$MysqlExe = if ($env:MYSQL_BIN) { $env:MYSQL_BIN } else { "mysql" }
$DbHost = if ($env:DB_HOST) { $env:DB_HOST } else { "127.0.0.1" }
$DbPort = if ($env:DB_PORT) { $env:DB_PORT } else { "3306" }
$DbName = if ($env:DB_NAME) { $env:DB_NAME } else { "zentirka_rp" }
$DbUser = if ($env:DB_USER) { $env:DB_USER } else { "root" }
if (-not $env:DB_PASSWORD) { throw "Set DB_PASSWORD in this PowerShell session; do not save it in Git." }
$env:MYSQL_PWD = $env:DB_PASSWORD
& $MysqlExe --host=$DbHost --port=$DbPort --user=$DbUser --database=$DbName --default-character-set=utf8mb4 < "database/diagnostics/diagnostic.sql"
if ($LASTEXITCODE -ne 0) { throw "Diagnostic command failed." }
