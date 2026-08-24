<p align="center">
  <img src="assets/logo.svg" alt="DiffPatchTool" width="360">
</p>

<h1 align="center">DiffPatchTool</h1>

<p align="center">
  <img src="https://img.shields.io/github/downloads/Reproteq/DiffPatchTool/total?label=Downloads&logo=github" alt="Downloads">
</p>
<p align="center">
  <a href="https://diffpatchtool.com"><b>diffpatchtool.com</b></a> ·
  by <b>Reproteq</b> · Author: <b>Alex G.T.</b>
</p>

**DiffPatchTool** es una herramienta de escritorio para **comparing, generating diffs, applying patches, inspecting, and editing binary files** — designed especially for working with ECU firmware (`.bin`), but suitable for any pair of binary files.

Written in **Rust**  using [egui/eframe](https://github.com/emilk/egui), compiles to a **single portable `.exe`** with no external dependencies: modern light theme, embedded icons, colored hex viewer, optional server connection, and automatic updates from GitHub.

by **Reproteq** · Author: **Alex G.T.**

![DiffPatchTool](assets/1.png)
![DiffPatchTool](assets/web1.png)
![img](assets/2.png)
![img](assets/3.png)
![img](assets/4.png)
![img](assets/5.png)
![img](assets/6.png)
![img](assets/7.png)
---

## Table of Contents

- [Features](#features)
- [Diff Format](#diff-format-3-columns)
- [Usage](#usage)
  - [Load Files](#1-load-files-a-and-b)
  - [Save Diff (Patch)](#2-save-diff-a-b)
  - [Apply Patch](#3-apply-patch)
  - [Hex Comparator](#4-hex-comparator-hexcomp)
  - [Edit Bytes and Blocks](#5-edit-bytes-and-blocks)
  - [Search and Navigate](#6-search-and-navigate)
  - [Analyzer](#7-analyzer-ecu-identifiers)
- [Server Connection](#server-connection)
- [Settings and System](#settings-and-system)
- [Updates](#updates)
- [Building](#building)
- [In Development / Future](#in-development--future)
- [☕ Support My Work](#-support-my-work)

---

## Features

- **Byte-by-byte comparison** de two files  using la list of differences.
- **3-column diff format** (`dirección`, `valor viejo`, `valor nuevo`), **backward-compatible**  using older patches de 2 columnas. Patches are saved como `_patch.diff` (también se leen los `.txt` antiguos).
- **Patch application**  using original-value verification y warning if the base file does not match.
- **Hex comparator** tipo editor: two side-by-side A | B panels, changed bytes en rojo, offsets en azul, ASCII column.
- **Vista configurable** del volcado: 8 / 16 / 32 bits, endianness (lo-hi / hi-lo) y base (hex / decimal) — estilo WinOLS.
- **Advanced selection**: consecutive, rectangular y by rows; define a block by start/end offsets; select/deselect all.
- **Selection operations**: rellenar  using `00` / `FF`, `XOR`, write a typed value across the entire block.
- **Copy and paste bytes** (Ctrl+C / Ctrl+V), preserving the rectangular shape when pasting.
- **Undo / redo** (Ctrl+Z / Ctrl+Y), including byte-by-byte editing.
- **Context menu** (clic derecho)  using copiar, pegar, rellenar, definir bloque desde el byte, copiar selección a un fichero nuevo y escribir portapapeles ( using aviso si el fichero crece).
- **Buscador** por hex o ASCII en A o B,  using resaltado.
- **Navegación** entre diferencias y jump to an offset (`Goto`).
- **Analyzer**: extracts ECU identifiers (números de pieza, versiones) del fichero cargado, configurable por `regex.txt`.
- **Optional server connection** (login) para funciones online — la app funciona igual sin conexión.
- **Persistent configuration** (`config.json`): recuerda preferencias de vista, selección y opciones.
- **Progress bar** para operaciones grandes (background processing, la interfaz no se congela).
- **Automatic updates** desde GitHub Releases,  using reinicio automático tras instalar.

---

## Diff Format (3 Columns)

Saving a diff writes three columns:

```
0xADDR   0xOLD   0xNEW
```

| Columna | Meaning                                  |
|---------|----------------------------------------------|
| `ADDR`  | offset (address) of the changed byte       |
| `OLD`   | old value (byte from file A / original)  |
| `NEW`   | new value (byte from file B / modified)|

Patches are saved como `<B>_<timestamp>_patch.diff`. Se siguen leyendo los older patches en `.txt` (2 y 3 columnas).

---

## Usage

### 1. Load Files A and B

Drag and drop files onto the **A** (original) y **B** (modificado o un `.diff`), or click each area to select them. They can also be loaded from the functions menu.

### 2. Save Diff A-B

Compare A and B and save the differences en un fichero `<B>_<timestamp>_patch.diff` en formato de 3 columnas. Displays the name, size, and date of each file, y el number of differences found.

### 3. Apply Patch

Load the original into **A** y un `.diff` (o `.txt` antiguo) en **B**, y generates a patched file. Si el parche trae la columna de valores viejos, se verifica que coincidan  using A y se avisa if the base file is not the correct one.

### 4. Hex Comparator (HexComp)

Opens a **separate window**  using el hexadecimal dump de A y B lado a lado:

- **Offsets en azul**, **changed bytes en rojo**, **bytes editados en naranja**.
- **"differences only"** mode ( using líneas de contexto) o **todo el binario**.
- **Vista configurable**: 8 / 16 / 32 bits, endianness (lo-hi / hi-lo) y base (hex / decimal).
- Barra de herramientas organizada por función: navegación, localización, selección/edición y vista.
- Se puede abrir  using **un solo fichero** (editor mode) además de para comparar dos.
- The size of each file is displayed next to its name.

### 5. Edit Bytes and Blocks

- **Click** en un byte to select it and type **2 dígitos hex** to change it; the cursor advances to the next byte.
- **Selección** consecutive, **rectangular** (solo las columnas del rectángulo) o por **filas**.
- **Define block** escribiendo los offsets de inicio y fin, o desde el menú contextual sobre un byte.
- **Operations** sobre la selección: `00`, `FF`, `XOR`, or type a value to apply it to the entire block.
- **Copiar / pegar** bytes (Ctrl+C / Ctrl+V); el pegado respeta la forma rectangular.
- **Undo / redo** (Ctrl+Z / Ctrl+Y).
- **Copiar selección a un fichero nuevo** (`.bin`).
- **Escribir el portapapeles** desde un byte,  using aviso si el fichero va a crecer.
- **Guardar** A y/o B editados como `.bin` nuevo, o **exportar** el diff del estado actual ( using las ediciones).

### 6. Search and Navigate

- **Goto**: enter an offset en hexadecimal y salta a él, centrado.
- **Find**: searches in **Hex** (`C2 FC 01`) o en **ASCII** (texto), en A o B,  using resaltado y siguiente/anterior.
- **Difference arrows**: recorren las diferencias una a una, centrando cada una.
- The scroll bar remains visible como referencia del tamaño del fichero.

### 7. Analyzer (ECU Identifiers)

When a file is loaded, el **analyzer** automatically extracts identificadores relevantes (Bosch part numbers, EDC17 / MED17 / MD1 versions, etc.) definidos en `regex.txt`. Useful for quickly identifying which ECU each file belongs to. It can be enabled / disabled en **Settings**.

---

## Server Connection

DiffPatchTool can **optionally** connect to the server de [diffpatchtool.com](https://diffpatchtool.com) para funciones online. **Logging in is not required para usar la aplicación** — all local features remain available.

- **Connection icon** en la barra: gris (disconnected) o verde (connected). Un clic opens the login or logs out.
- **Login opcional**  using Reproteq account. The session is remembered between launches (token), y optionally the email and password.
- Conectarse enables additional features como **save and share patches** y **check whether a patch matches**  using un fichero cargado.

---

## Settings and System

- **Settings** (menú): enable / disable the analyzer, account management, y preferences that are saved en `config.json` (`%APPDATA%\Reproteq\DiffPatchTool\`).
- **System** (menú): system information — machine identifier (**HWID**), operating system, CPU, RAM, executable path y versión.

---

## Updates

DiffPatchTool checks for a new version en GitHub **on startup** y using the toolbar button. If a newer release is available, un botón permite **download and install** la actualización; el ejecutable se reemplaza y la aplicación **automatically restarts**.

---

## Building

Requires [Rust](https://rustup.rs) installed.

```bash
cargo run              # build and run (development)
cargo build --release  # optimized binary
```

The final executable is located at `target/release/DiffPatchTool.exe`.

En Linux se necesitan las librerías de development de GUI la primera vez:

```bash
sudo apt install libxcb1-dev libxkbcommon-dev libwayland-dev \
                 libgtk-3-dev libglib2.0-dev pkg-config
```

### Icons and Logo

- **Window icon**: se rasteriza desde `assets/r.svg`.
- **`.exe` icon** (Explorador y barra de tareas): `assets/icon.ico` (multi-resolución 16–256), embedded by `build.rs` al compilar en Windows.
- **Logo** de la interfaz y del README: `assets/logo.svg`.

Los SVG  using texto deben convertirse a trazados (paths) antes, because the rasterizer does not embed fonts.

---

## In Development / Future

DiffPatchTool is under active development. Upcoming work:

- **Online patch database**: store patches on the server y, when a file is loaded, instantly determine **which patches are compatible** — mediante huellas (hashes de dirección+valor) e identificadores de ECU, without ever uploading the complete firmware.
- **Web  using dominio propio** ([diffpatchtool.com](https://diffpatchtool.com)): account portal, patch management, and downloads.
- **Patch compatibility verification** de un parche  using el fichero cargado before applying it.
- **More display modes** en el hex (float,  using signo, binario).
- Continuous performance and usability improvements.

---

## ☕ Support My Work

Si encuentras útil este proyecto y te gustaría apoyar su development, considera hacer una donación. ¡Cualquier cantidad es bienvenida y muy apreciada!

**Bitcoin (BTC):**

```
1Mmwhdw4mQzbuLbmPFdEF2uXMVi8X3kv68
```

**PayPal:** reproteq@gmail.com

| Amount        | Donation Link                                                        |
|--------------|---------------------------------------------------------------------------|
| 1 €          | [Donate 1 €](https://www.paypal.com/paypalme/reproteqofficial/1)                    |
| 5 €          | [Donate 5 €](https://www.paypal.com/paypalme/reproteqofficial/5)                    |
| 10 €         | [Donate 10 €](https://www.paypal.com/paypalme/reproteqofficial/10)                  |
| 25 €         | [Donate 25 €](https://www.paypal.com/paypalme/reproteqofficial/25)                  |
| 50 €         | [Donate 50 €](https://www.paypal.com/paypalme/reproteqofficial/50)                  |
| 100 €        | [Donate 100 €](https://www.paypal.com/paypalme/reproteqofficial/100)               |
| Amount Libre  | [Donate Otro Amount](https://www.paypal.com/paypalme/reproteqofficial)              |

---

## Contact

- Website: [diffpatchtool.com](https://diffpatchtool.com) · [reproteq.com](https://reproteq.com)
- Email: reproteq@gmail.com
- Telegram: [@reproteq](https://t.me/reproteq)

---

## License

© Reproteq. All rights reserved.
