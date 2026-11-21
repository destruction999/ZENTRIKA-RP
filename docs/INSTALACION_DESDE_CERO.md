# Instalar ZENTRIKA RP desde cero

## Objetivo
Instalar el servidor en un FXServer/TXAdmin nuevo y usar una base de datos nueva llamada `zentirka_rp`. No se importan personajes ni datos antiguos.

## Antes de empezar
- FXServer/TXAdmin limpio.
- MariaDB/MySQL compatible con oxmysql.
- Clave Cfx.re válida, guardada solo en el host.
- Paquete de recursos reconstruido y extraído conservando rutas.
- Acceso a phpMyAdmin o HeidiSQL.

## 1. Obtener los recursos
Descarga las nueve partes siguiendo `docs/GITHUB_PARTES.md`, reconstruye el ZIP y verifica que 7-Zip pueda abrirlo sin errores. Extrae las carpetas conservando sus nombres.

## 2. Crear la base nueva
Sigue el orden y la lista de `database/README.md`. El nombre de la base será `zentirka_rp`. Importa únicamente los SQL de los recursos que vas a iniciar; no cargues datos de usuarios anteriores.

## 3. Configurar FXServer
1. Copia `server-config/server.cfg.example` como `server.cfg`.
2. Coloca tu clave Cfx y la cadena MySQL real en el servidor, nunca en GitHub.
3. Asegura que el nombre de la base en la cadena sea `zentirka_rp`.
4. Inicia dependencias antes que los recursos que las requieren.
5. No inicies `esx_policejob` junto con FRKN Police Job.
6. Inicia BabloBossMenu una sola vez, después de ESX y las dependencias de sociedad.

## 4. Primer arranque y validación
- Revisa todos los logs de TXAdmin.
- Confirma conexión de oxmysql a `zentirka_rp`.
- Crea un personaje de prueba y guarda/carga.
- Prueba inventario, identidad, tiendas y vehículos.
- Prueba los trabajos y sus rangos.
- Prueba FRKN Police Job, radio y bodycam.
- Prueba BabloBossMenu: abrir, contratar, despedir, ascender y consultar saldo.
- Comprueba que no haya pagos duplicados.

La instalación y las pruebas en el host real siguen pendientes hasta ejecutarlas allí.
