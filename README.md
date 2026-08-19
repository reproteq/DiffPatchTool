# DiffPatchTool

**DiffPatchTool** es una herramienta de escritorio para **comparar, generar diferencias (diff), aplicar parches (patch), inspeccionar y editar ficheros binarios** — pensada especialmente para el trabajo con firmware de ECU (`.bin`), pero válida para cualquier par de ficheros binarios.

Escrita en **Rust** con [egui/eframe](https://github.com/emilk/egui), compila a un **único `.exe` portable** sin dependencias externas: tema claro moderno, iconos embebidos, visor hexadecimal a color y auto-actualización desde GitHub.

by **Reproteq** · Autor: **Alex G.T.**

![DiffPatchTool](1.png)

---

## Índice

- [Características](#características)
- [Formato de diff](#formato-de-diff-3-columnas)
- [Uso](#uso)
  - [Cargar ficheros](#1-cargar-ficheros-a-y-b)
  - [Guardar diff (patch)](#2-guardar-diff-a-b)
  - [Aplicar patch](#3-aplicar-patch)
  - [Comparador hexadecimal](#4-comparador-hexadecimal-hexcomp)
  - [Editar bytes](#5-editar-bytes)
  - [Buscar y navegar](#6-buscar-y-navegar)
- [Actualizaciones](#actualizaciones)
- [Compilación](#compilación)
- [Iconos y personalización](#iconos-y-personalización)
- [Apoya mi trabajo](#-apoya-mi-trabajo)

---

## Características

- **Comparación byte a byte** de dos ficheros con la lista de diferencias.
- **Diff en formato de 3 columnas** (`dirección`, `valor viejo`, `valor nuevo`), **retrocompatible** con parches antiguos de 2 columnas.
- **Aplicación de parches** con verificación opcional del valor original y aviso si el fichero base no coincide.
- **Comparador hexadecimal** tipo editor: dos paneles A | B lado a lado, bytes cambiados en rojo, offsets en azul.
- **Edición de bytes** en A y en B directamente sobre el hex, y guardado como `.bin` nuevo.
- **Buscador** por hex o ASCII, con resaltado en verde.
- **Navegación** entre diferencias y salto a un offset (`Goto`).
- **Barra de progreso** para operaciones sobre ficheros grandes (trabajo en segundo plano, la interfaz no se congela).
- **Timestamps** en el log y en los nombres de los ficheros generados.
- **Auto-actualización** desde GitHub Releases.
- **Reportar bugs** por email con un clic.

---

## Formato de diff (3 columnas)

Al guardar un diff se escriben tres columnas:

```
0xADDR   0xOLD   0xNEW
```

| Columna | Significado                                  |
|---------|----------------------------------------------|
| `ADDR`  | offset (dirección) del byte que cambia       |
| `OLD`   | valor viejo (byte del fichero A / original)  |
| `NEW`   | valor nuevo (byte del fichero B / modificado)|

Ejemplo:

```
0x001A20 0x00 0xAB
0x001A21 0xFF 0xCD
```

**Retrocompatibilidad:** un parche antiguo de 2 columnas (`0xADDR 0xNEW`) se sigue aplicando sin problemas. Cada línea se interpreta según su número de columnas, así que el valor que se escribe siempre es el correcto. Al aplicar un parche de 2 columnas, la aplicación avisa de que no contiene la columna de valores viejos.

---

## Uso

### 1. Cargar ficheros A y B

Arrastra y suelta los ficheros sobre las zonas **A** (original) y **B** (modificado o un `diff.txt`), o haz clic en cada zona para elegirlos. También desde el menú de funciones.

![Cargar ficheros](2.png)

### 2. Guardar diff A-B

Compara A y B y guarda las diferencias en un fichero `<B>_<timestamp>_diff.txt` en formato de 3 columnas. Muestra el nombre, tamaño y fecha de cada fichero, y el número de diferencias encontradas.

![Guardar diff](3.png)

### 3. Aplicar patch

Carga el original en **A** y un `diff.txt` en **B**, y genera un fichero parcheado `<A>_<...>_patched.<ext>`. Si el parche trae la columna de valores viejos, se verifica que coincidan con A y se avisa si el fichero base no es el correcto.

![Aplicar patch](4.png)

### 4. Comparador hexadecimal (HexComp)

Abre una **ventana independiente** con el volcado hexadecimal de A y B lado a lado:

- **Offsets en azul**, **bytes cambiados en rojo**.
- Modo **"solo diferencias"** (con líneas de contexto configurables) o **todo el binario**.
- Columna ASCII a la derecha de cada panel.

![Comparador hex](5.png)

### 5. Editar bytes

Dentro del comparador puedes **editar bytes** tanto en A como en B:

- **Clic** en un byte para seleccionarlo (fondo amarillo) y escribe **2 dígitos hex** para cambiarlo; avanza automáticamente al siguiente.
- **Flechas ←/→** para moverte, **Esc** para deseleccionar.
- Los bytes editados se marcan en **naranja**.
- El icono de **disquete** guarda A y/o B editados como un `.bin` nuevo (no sobrescribe el original).
- El icono de **exportar** guarda el diff (patch) del estado actual, **incluyendo tus ediciones**.

![Editar bytes](6.png)

### 6. Buscar y navegar

- **Goto**: escribe un offset en hexadecimal y salta a él, centrado en la vista.
- **Find**: busca una secuencia en **Hex** (`C2 FC 01`) o en **ASCII** (texto), con resaltado en **verde** y botones de coincidencia siguiente/anterior.
- **Flechas de diferencia**: recorren las diferencias una a una, centrando cada una en pantalla.

![Buscar y navegar](7.png)

---

## Actualizaciones

DiffPatchTool comprueba automáticamente si hay una versión nueva en GitHub **al arrancar** y también mediante el botón de **comprobar actualizaciones** de la barra superior. Si hay una release más reciente, aparece un botón para **descargar e instalar** la actualización, que reemplaza el ejecutable. Tras actualizar, cierra y vuelve a abrir la aplicación.

---

## Compilación

Requiere [Rust](https://rustup.rs) instalado.

```bash
cargo run            # compilar y ejecutar (desarrollo)
cargo build --release
```

El ejecutable final queda en `target/release/DiffPatchTool.exe`.

En Linux se necesitan las librerías de desarrollo de GUI la primera vez:

```bash
sudo apt install libxcb1-dev libxkbcommon-dev libwayland-dev \
                 libgtk-3-dev libglib2.0-dev pkg-config
```

### Icono de la aplicación

Coloca un `icon.ico` (multi-resolución: 16, 32, 48, 256) en `assets/icon.ico`. Con eso:

- El **icono de la ventana** va embebido en el binario.
- El **icono del `.exe`** (Explorador y barra de tareas) lo incrusta `build.rs` al compilar en Windows.

---

## Iconos y personalización

La interfaz usa los iconos [Phosphor](https://phosphoricons.com/) (embebidos en el binario mediante `egui-phosphor`), por lo que se ven igual en cualquier sistema. Los colores del tema, los del visor hex y los tamaños se ajustan en el código (`setup_style`, `hex_row_layout`).

---

## ☕ Apoya mi trabajo

Si encuentras útil este proyecto y te gustaría apoyar su desarrollo, considera hacerme una donación. ¡Cualquier cantidad es bienvenida y muy apreciada!

**Bitcoin (BTC):**

```
1Mmwhdw4mQzbuLbmPFdEF2uXMVi8X3kv68
```

**PayPal:** reproteq@gmail.com

| Monto        | Enlace de Donación                                                        |
|--------------|---------------------------------------------------------------------------|
| 1 €          | [Donar 1 €](https://paypal.me/reproteqofficial/1)                    |
| 5 €          | [Donar 5 €](https://paypal.me/reproteqofficial/5)                    |
| 10 €         | [Donar 10 €](https://paypal.me/reproteqofficial/10)                  |
| 25 €         | [Donar 25 €](https://paypal.me/reproteqofficial/25)                  |
| 50 €         | [Donar 50 €](https://paypal.me/reproteqofficial/50)                  |
| 100 €        | [Donar 100 €](https://paypal.me/reproteqofficial/100)               |
| Monto Libre  | [Donar Otro Monto](https://paypal.me/reproteqofficial)              |

---

## Licencia

© Reproteq. Todos los derechos reservados.
