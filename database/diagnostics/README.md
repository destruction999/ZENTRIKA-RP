# Diagnóstico de SQL

Ejecuta `diagnostic.sql` con la base `zentirka_rp` seleccionada. Es una revisión de solo lectura.

**Comprobaciones:** selección de base y versión; presencia de tablas ESX base (`users`, `jobs`, `job_grades`, `items`); inventario de tablas y conteos aproximados; existencia del ledger de migraciones.

**Importante:** las tablas de recursos adicionales no se marcan como requeridas hasta confirmar qué scripts se iniciarán en ZENTRIKA-RP. Esto evita falsos errores y no crea tablas por suposición.
