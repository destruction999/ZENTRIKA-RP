# ZENTRIKA-RP — Administración central SQL

La base activa conservada por el proyecto es `zentirka_rp` (nombre histórico del repositorio; no renombrar sin revisar server.cfg y los recursos).

## Principios
- MariaDB/MySQL + oxmysql + ESX.
- No incluir contraseñas, tokens ni dumps con datos de jugadores en Git.
- No borrar tablas automáticamente ni aplicar cambios destructivos.
- SQL de recursos se importa solo si el recurso se usa, y respetando su versión.
- Las migraciones de este sistema se guardan en `database/migrations/` y se registran en `zentirka_rp_migrations`.
- El diagnóstico compara las tablas base de ESX y muestra las ausentes; no instala automáticamente recursos ni inventa sus schemas.

## Primeros pasos
1. Haz un backup completo de la base existente antes de aplicar cualquier SQL.
2. Usa MariaDB/MySQL CLI o phpMyAdmin para ejecutar `database/central/00_migration_ledger.sql`.
3. Configura variables de conexión en tu entorno, nunca en el repositorio.
4. Ejecuta `database/tools/migrate.sh` desde Bash/WSL/Linux. En Windows, puedes ejecutar las migraciones manualmente en orden con tu cliente SQL.
5. Ejecuta `database/diagnostics/diagnostic.sql` y revisa los resultados.

El primer conjunto de migraciones es intencionalmente mínimo y seguro; el catálogo completo de recursos se añadirá después de verificar el contenido real de cada recurso.
