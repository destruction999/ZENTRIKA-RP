# Paquete grande: nueve fragmentos

El ZIP de recursos tiene 195,177,848 bytes. Se dividió localmente en nueve partes de máximo 24,000,000 bytes para poder cargarlas individualmente.

## Nombres
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_01.bin`
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_02.bin`
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_03.bin`
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_04.bin`
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_05.bin`
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_06.bin`
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_07.bin`
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_08.bin`
- `ZENTRIKA_BABLO_BOSSMENU_PARTE_09.bin`

También se generó `SHA256SUMS.json` con el tamaño y SHA-256 de cada fragmento y el tamaño total del archivo original.

## Reconstruir en Windows
Descarga las nueve partes en una misma carpeta. Abre CMD en esa carpeta y ejecuta:

```bat
copy /b ZENTRIKA_BABLO_BOSSMENU_PARTE_01.bin+ZENTRIKA_BABLO_BOSSMENU_PARTE_02.bin+ZENTRIKA_BABLO_BOSSMENU_PARTE_03.bin+ZENTRIKA_BABLO_BOSSMENU_PARTE_04.bin+ZENTRIKA_BABLO_BOSSMENU_PARTE_05.bin+ZENTRIKA_BABLO_BOSSMENU_PARTE_06.bin+ZENTRIKA_BABLO_BOSSMENU_PARTE_07.bin+ZENTRIKA_BABLO_BOSSMENU_PARTE_08.bin+ZENTRIKA_BABLO_BOSSMENU_PARTE_09.bin ZENTRIKA_BABLO_BOSSMENU_TODOS_LOS_TRABAJOS.zip
```

Después verifica el ZIP con 7-Zip antes de extraerlo. Los nueve fragmentos **aún no están cargados en el repositorio**; el conector de GitHub disponible no ofrece transferencia de archivos binarios locales grandes. Se deben subir desde la interfaz web o con Git LFS.
