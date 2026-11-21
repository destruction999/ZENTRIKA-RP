# Base de datos nueva — ZENTRIKA RP

Instalación limpia en una única base llamada `zentirka_rp`. No contiene personajes ni datos de la base anterior.

## Orden inicial
1. Ejecuta `00_CREAR_BASE.sql`.
2. Ejecuta `01_ESX_CORE.sql`. Es el esquema de `es_extended.sql` incluido en este paquete, adaptado para que use `zentirka_rp` en lugar de crear una base independiente `es_extended`.
3. Importa los SQL de los recursos que realmente vas a iniciar, usando la lista de abajo y revisando los requisitos de cada recurso.

## SQL presentes en el paquete

### Dependencias ESX
- `resources/[esx_addons]/esx_addonaccount/esx_addonaccount.sql`
- `resources/[esx_addons]/esx_addoninventory/esx_addoninventory.sql`
- `resources/[esx_addons]/esx_datastore/esx_datastore.sql`
- `resources/[esx_addons]/esx_society/esx_society.sql`

### Core y funciones ESX
- `resources/[core]/esx_identity/esx_identity.sql`
- `resources/[core]/esx_whitelist/whitelist.sql` (solo si activarás whitelist)
- `resources/[esx_addons]/esx_banking/banking.sql`
- `resources/[esx_addons]/esx_basicneeds/localization/es_esx_basicneeds.sql` (usar en lugar de `esx_basicneeds.sql`)
- `resources/[esx_addons]/esx_billing/esx_billing.sql`
- `resources/[esx_addons]/esx_death/esx_death.sql`
- `resources/[esx_addons]/esx_dmvschool/localization/es_esx_dmvschool.sql` (usar en lugar de `esx_dmvschool.sql`)
- `resources/[esx_addons]/esx_license/esx_license.sql`
- `resources/[esx_addons]/esx_status/esx_status.sql`

### Trabajos y vehículos
- `resources/[esx_addons]/esx_ambulancejob/esx_ambulancejob.sql`
- `resources/[esx_addons]/esx_policejob/localization/es_esx_policejob.sql` solo si decides activar el trabajo policial ESX antiguo. No lo combines con FRKN Police Job.
- `resources/[esx_addons]/esx_vehicleshop/localization/es_esx_vehicleshop.sql` (usar en lugar del SQL base)
- `resources/[esx_addons]/esx_garage/esx_garage.sql`
- `resources/[esx_addons]/esx_weaponshop/esx_weaponshop.sql` solo si lo mantienes activo.

### Recursos adicionales
- `resources/[d7_police]/d7_police_suite/sql/schema.sql`
- `resources/[tiendas]/dc_fuel/install/dc_fuel.sql`
- `resources/[tiendas]/dc_shops/install/dc_shops.sql` y luego `dc_shops_presets.sql`
- `resources/[trabajos]/pls_mechanic/INSTALL/install.sql`
- `sql/zentirka_bossmenu_societies.sql` después de crear los trabajos y las tablas de addon_account.

## Reglas para no romper una base nueva
- Ejecuta solo SQL de recursos que vayas a iniciar.
- Para un recurso con SQL localizado, usa el archivo español indicado en lugar del SQL base, nunca ambos.
- No importes `esx_policejob` como sistema activo si la policía principal será FRKN; el SQL de ese recurso solo aplica si lo mantienes.
- Revisa los logs: algunos recursos pueden crear/migrar sus tablas al iniciar.
- No ejecutes un SQL repetidamente si no está diseñado para ser idempotente.
- Si aparece un error, detente y revisa el mensaje; no borres tablas a ciegas.

## Conexión
En el `server.cfg` privado del host, apunta oxmysql a `zentirka_rp`. Nunca guardes contraseña ni credenciales en GitHub.
