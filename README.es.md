# clean-macOS-icon-cache

Una pequeña utilidad de macOS que limpia la caché de iconos del sistema y reinicia Dock y Finder para corregir iconos rotos, ausentes o desactualizados.

> ⚠️ Esta utilidad elimina archivos de caché del sistema con privilegios de administrador y reinicia Dock y Finder. Su escritorio se actualizará brevemente durante el proceso. Lea la sección [Seguridad](#seguridad) antes de ejecutarla.

## Idiomas

El idioma principal de este proyecto es el inglés. La documentación también está disponible en los siguientes idiomas:

- English (idioma principal) — [README.md](README.md)
- 简体中文 (chino) — [README.zh-CN.md](README.zh-CN.md)
- Español — este documento

## Archivos

| Archivo | Descripción |
| --- | --- |
| `clean-icon-cache.js` | Script JXA con un diálogo de confirmación. Solicita privilegios de administrador al ejecutarse. |
| `clean-icon-cache.sh` | Versión de shell. Usa `sudo` directamente. |
| `build-app.sh` | Compila un `.app` de doble clic a partir de `clean-icon-cache.js`. |

## Cómo funciona

1. Elimina las cachés `com.apple.dock.iconcache` y `com.apple.iconservices` en los directorios de caché de cada usuario en `/private/var/folders/`.
2. Elimina `/Library/Caches/com.apple.iconservices.store`.
3. Reinicia Dock y Finder con `killall Dock` y `killall Finder`.

## Uso

### Ejecutar desde el código fuente

Versión JXA:

```bash
osascript clean-icon-cache.js
```

Versión de shell:

```bash
chmod +x clean-icon-cache.sh
./clean-icon-cache.sh
```

Ambas versiones solicitan privilegios de administrador y piden confirmación antes de hacer cualquier cambio. Para omitir la pregunta, use `--yes`; para previsualizar qué se eliminaría sin modificar nada, use `--dry-run`:

```bash
./clean-icon-cache.sh --yes
./clean-icon-cache.sh --dry-run
```

Si la limpieza falla, Dock y Finder no se reinician.

### Compilar la aplicación

```bash
./build-app.sh
```

Esto crea `dist/clean-macOS-icon-cache.app`, que puede abrir con doble clic. Compilar localmente evita la advertencia de Gatekeeper sobre "desarrollador no verificado".

## Firma de código y notarización

Este proyecto **no** está firmado con un Apple Developer ID y **no** está notarizado por Apple, porque su autor no está inscrito en el Apple Developer Program. La `.app` generada por `build-app.sh` solo tiene una firma ad hoc.

La aplicación funciona con normalidad cuando se compila y se abre en su propio Mac. Sin embargo, después de descargar un zip desde una Release de GitHub, macOS puede bloquear el primer lanzamiento con una advertencia de "desarrollador no verificado".

Para abrirla de todos modos:

1. Recomendado: compile desde el código fuente con `./build-app.sh` y ejecute la aplicación.
2. Haga clic con Control en la aplicación y elija **Abrir** para el primer lanzamiento.
3. O elimine el atributo de cuarentena en Terminal:

   ```bash
   xattr -dr com.apple.quarantine /path/to/clean-macOS-icon-cache.app
   ```

Esta aplicación solicita privilegios de administrador. Revise el código fuente antes de ejecutarla. Tenga en cuenta que la ausencia de notarización no es una señal de seguridad: simplemente refleja que el autor no ha pagado por una cuenta de Apple Developer.

## Seguridad

- Los objetivos de eliminación se limitan a rutas conocidas de la caché de iconos de macOS, pero los scripts contienen `sudo` y `rm -rf`. Lea el código antes de ejecutarlos.
- Dock y Finder se reiniciarán. Las aplicaciones a pantalla completa pueden cerrarse y los iconos del escritorio se volverán a cargar.
- Requiere macOS y privilegios de administrador.

## Licencia

[MIT](LICENSE)
