-- ZENTRIKA-RP: ledger para registrar migraciones aplicadas.
-- Safe to rerun. Ejecutar en la base zentirka_rp.
CREATE TABLE IF NOT EXISTS `zentirka_rp_migrations` (
  `migration` VARCHAR(190) NOT NULL,
  `applied_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `checksum_sha256` CHAR(64) NULL,
  `applied_by` VARCHAR(100) NULL,
  PRIMARY KEY (`migration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
