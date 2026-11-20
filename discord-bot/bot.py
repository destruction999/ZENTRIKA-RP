import os
import json
from pathlib import Path

import discord
from discord import app_commands
from discord.ext import commands

# Secret config stays on the host outside the Git-synced discord-bot folder.
CONFIG_PATH = Path("/home/container/private_config.json")
if CONFIG_PATH.exists():
    try:
        private_config = json.loads(CONFIG_PATH.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, OSError) as exc:
        raise RuntimeError("No se pudo leer private_config.json") from exc
else:
    private_config = {}

TOKEN = os.getenv("DISCORD_TOKEN") or private_config.get("DISCORD_TOKEN")
GUILD_ID = os.getenv("DISCORD_GUILD_ID") or private_config.get("DISCORD_GUILD_ID")

intents = discord.Intents.default()
bot = commands.Bot(command_prefix="!", intents=intents)


def admin_only():
    return app_commands.checks.has_permissions(administrator=True)


class ConfirmDelete(discord.ui.View):
    def __init__(self, channel: discord.abc.GuildChannel):
        super().__init__(timeout=30)
        self.channel = channel

    @discord.ui.button(label="Confirmar eliminación", style=discord.ButtonStyle.danger)
    async def confirm(self, interaction: discord.Interaction, button: discord.ui.Button):
        if not interaction.user.guild_permissions.administrator:
            await interaction.response.send_message("No tienes permiso de administrador.", ephemeral=True)
            return
        try:
            name = self.channel.name
            await self.channel.delete(reason=f"Eliminado por {interaction.user}")
            await interaction.response.edit_message(
                content=f"Canal **{name}** eliminado.", view=None
            )
        except discord.Forbidden:
            await interaction.response.edit_message(
                content="No tengo permisos suficientes para eliminar ese canal.", view=None
            )
        except discord.NotFound:
            await interaction.response.edit_message(
                content="Ese canal ya no existe.", view=None
            )


    @discord.ui.button(label="Cancelar", style=discord.ButtonStyle.secondary)
    async def cancel(self, interaction: discord.Interaction, button: discord.ui.Button):
        await interaction.response.edit_message(content="Acción cancelada.", view=None)


@bot.event
async def on_ready():
    try:
        if GUILD_ID:
            guild = discord.Object(id=int(GUILD_ID))
            synced = await bot.tree.sync(guild=guild)
            print(f"Conectado como {bot.user}. {len(synced)} comandos sincronizados.")
        else:
            synced = await bot.tree.sync()
            print(f"Conectado como {bot.user}. {len(synced)} comandos globales sincronizados.")
    except Exception as exc:
        print(f"Error sincronizando comandos: {exc}")


@bot.tree.command(name="estado", description="Comprueba que ZENTRIKA CONTROL está activo.")
@admin_only()
async def estado(interaction: discord.Interaction):
    await interaction.response.send_message(
        f"ZENTRIKA CONTROL está activo en **{interaction.guild.name}**.",
        ephemeral=True
    )


@bot.tree.command(name="crear_categoria", description="Crea una categoría de Discord.")
@app_commands.describe(nombre="Nombre de la nueva categoría")
@admin_only()
async def crear_categoria(interaction: discord.Interaction, nombre: str):
    if not nombre.strip() or len(nombre) > 100:
        await interaction.response.send_message("El nombre debe tener entre 1 y 100 caracteres.", ephemeral=True)
        return
    category = await interaction.guild.create_category(
        name=nombre.strip(), reason=f"Solicitado por {interaction.user}"
    )
    await interaction.response.send_message(f"Categoría creada: **{category.name}**.", ephemeral=True)


@bot.tree.command(name="crear_canal", description="Crea un canal de texto.")
@app_commands.describe(nombre="Nombre del canal", categoria="Categoría opcional")
@admin_only()
async def crear_canal(
    interaction: discord.Interaction,
    nombre: str,
    categoria: discord.CategoryChannel | None = None
):
    if not nombre.strip() or len(nombre) > 100:
        await interaction.response.send_message("El nombre debe tener entre 1 y 100 caracteres.", ephemeral=True)
        return
    channel = await interaction.guild.create_text_channel(
        name=nombre.strip(),
        category=categoria,
        reason=f"Solicitado por {interaction.user}"
    )
    await interaction.response.send_message(f"Canal creado: {channel.mention}.", ephemeral=True)


@bot.tree.command(name="borrar_canal", description="Solicita borrar un canal; requiere confirmación.")
@app_commands.describe(canal="Canal que quieres eliminar")
@admin_only()
async def borrar_canal(interaction: discord.Interaction, canal: discord.TextChannel):
    await interaction.response.send_message(
        f"Vas a eliminar **#{canal.name}**. Esta acción no se puede deshacer.",
        view=ConfirmDelete(canal),
        ephemeral=True
    )


@bot.tree.error
async def on_app_command_error(interaction: discord.Interaction, error: app_commands.AppCommandError):
    if isinstance(error, app_commands.MissingPermissions):
        message = "Este comando requiere permisos de administrador."
    else:
        print(f"Error de comando: {error}")
        message = "Ocurrió un error. Revisa los registros del bot."
    if interaction.response.is_done():
        await interaction.followup.send(message, ephemeral=True)
    else:
        await interaction.response.send_message(message, ephemeral=True)


if not TOKEN:
    raise RuntimeError("Falta configurar DISCORD_TOKEN en private_config.json o en variables de entorno.")

bot.run(TOKEN)
