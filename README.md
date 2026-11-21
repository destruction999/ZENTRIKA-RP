# ZENTRIKA RP

Repositorio de instalación y desarrollo del servidor FiveM **ZENTRIKA RP**.

## Base técnica
- ESX Legacy 1.16.3
- oxmysql, ox_lib, ox_inventory y ox_target
- pma-voice
- BabloBossMenu como menú de jefe unificado (requiere prueba funcional en servidor)

## Carpetas
- `database/`: creación de base de datos nueva e instrucciones SQL.
- `docs/`: instalación desde cero, GitHub y mantenimiento.
- `resources/`: recursos por categorías.
- `server-config/`: plantilla de configuración; no contiene claves reales.

## Instalación
Empieza por [Instalación desde cero](docs/INSTALACION_DESDE_CERO.md) y sigue [la guía de base de datos](database/README.md).

## Paquete de recursos
El ZIP modificado pesa 195,177,848 bytes y se dividió localmente en nueve fragmentos de máximo 24,000,000 bytes. Consulta [la guía de fragmentos](docs/GITHUB_PARTES.md). **Los fragmentos todavía no se han subido a GitHub**; deben cargarse en la interfaz web o mediante Git LFS.

## Seguridad y redistribución
No publiques claves, contraseñas, tokens, datos de jugadores ni archivos de configuración reales. Verifica las licencias y permisos de redistribución de recursos de terceros antes de hacer público el paquete. Usa `.gitignore` y guarda secretos solo en el servidor.
