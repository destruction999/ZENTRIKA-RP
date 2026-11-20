# ZENTRIKA CONTROL — Discord bot

Bot privado de administración para ZENTRIKA RP.

## Funciones iniciales
- `/estado`: comprueba que el bot está conectado.
- `/crear_categoria`: crea una categoría.
- `/crear_canal`: crea un canal de texto.
- `/borrar_canal`: solicita confirmación antes de borrar un canal.

Todos los comandos requieren que quien los use tenga permisos de Administrador en Discord. La eliminación siempre requiere una segunda confirmación.

## Variables privadas
Configura en Render:
- `DISCORD_TOKEN`: token del bot de Discord. Nunca lo publiques ni lo compartas en el chat.
- `DISCORD_GUILD_ID`: ID numérico del servidor Discord donde se sincronizan los comandos.

## Instalación
1. Crea una aplicación en https://discord.com/developers/applications.
2. Añade un Bot y copia el token directamente a la variable privada `DISCORD_TOKEN` en Render.
3. En OAuth2 URL Generator selecciona `bot` y `applications.commands`; concede Administrator solo al bot de confianza.
4. Invita el bot al servidor correcto.
5. Despliega este directorio como Background Worker en Render.
6. Define las dos variables de entorno.

No subas tokens, contraseñas ni archivos `.env` a GitHub.
