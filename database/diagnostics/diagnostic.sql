-- ZENTRIKA-RP Database Health Check (read-only).
-- Selecciona primero zentirka_rp. Este script no modifica tablas ni datos.
SELECT DATABASE() AS selected_database, VERSION() AS mariadb_version, NOW() AS checked_at;

-- Required baseline tables for the ESX core schema currently tracked in this repo.
SELECT required_table.table_name,
       CASE WHEN actual.table_name IS NULL THEN 'MISSING' ELSE 'OK' END AS status
FROM (
  SELECT 'users' AS table_name UNION ALL
  SELECT 'jobs' UNION ALL SELECT 'job_grades' UNION ALL SELECT 'items'
) AS required_table
LEFT JOIN information_schema.tables AS actual
  ON actual.table_schema = DATABASE()
 AND actual.table_name = required_table.table_name
ORDER BY required_table.table_name;

-- Tables currently installed, with approximate row counts (InnoDB statistics may be estimates).
SELECT table_name, table_rows, engine
FROM information_schema.tables
WHERE table_schema = DATABASE()
ORDER BY table_name;

-- Migration ledger status.
SELECT COUNT(*) AS recorded_migrations
FROM information_schema.tables
WHERE table_schema = DATABASE()
  AND table_name = 'zentirka_rp_migrations';
