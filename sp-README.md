<p align="center">
  <img src="assets/logo.svg" alt="DiffPatchTool" width="360">
</p>

<h1 align="center">DiffPatchTool</h1>

<p align="center">
  <a href="https://diffpatchtool.com"><b>diffpatchtool.com</b></a> ·
  by <b>Reproteq</b> · Autor: <b>Alex G.T.</b>
</p>

**DiffPatchTool** es una herramienta de escritorio para **comparar, generar diferencias (diff), aplicar parches (patch), inspeccionar y editar ficheros binarios** — pensada especialmente para el trabajo con firmware de ECU (`.bin`), pero válida para cualquier par de ficheros binarios.

Escrita en **Rust** con [egui/eframe](https://github.com/emilk/egui), compila a un **único `.exe` portable** sin dependencias externas: tema claro moderno, iconos embebidos, visor hexadecimal a color, conexión opcional al servidor y auto-actualización desde GitHub.

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
  - [Editar bytes y bloques](#5-editar-bytes-y-bloques)
  - [Buscar y navegar](#6-buscar-y-navegar)
  - [Analyzer](#7-analyzer-identificadores-de-ecu)
- [Conexión con el servidor](#conexión-con-el-servidor)
- [Ajustes y sistema](#ajustes-y-sistema)
- [Actualizaciones](#actualizaciones)
- [Compilación](#compilación)
- [En desarrollo / futuro](#en-desarrollo--futuro)
- [Apoya mi trabajo](#-apoya-mi-trabajo)

---

## Características

- **Comparación byte a byte** de dos ficheros con la lista de diferencias.
- **Diff en formato de 3 columnas** (`dirección`, `valor viejo`, `valor nuevo`), **retrocompatible** con parches antiguos de 2 columnas. Los parches se guardan como `_patch.diff` (también se leen los `.txt` antiguos).
- **Aplicación de parches** con verificación del valor original y aviso si el fichero base no coincide.
- **Comparador hexadecimal** tipo editor: dos paneles A | B lado a lado, bytes cambiados en rojo, offsets en azul, columna ASCII.
- **Vista configurable** del volcado: 8 / 16 / 32 bits, endianness (lo-hi / hi-lo) y base (hex / decimal) — estilo WinOLS.
- **Selección avanzada**: consecutiva, rectangular y por filas; definir bloque por offsets de inicio/fin; seleccionar/deseleccionar todo.
- **Operaciones sobre la selección**: rellenar con `00` / `FF`, `XOR`, escribir un valor tecleado sobre todo el bloque.
- **Copiar y pegar bytes** (Ctrl+C / Ctrl+V), respetando la forma rectangular al pegar.
- **Deshacer / rehacer** (Ctrl+Z / Ctrl+Y), incluida la edición byte a byte.
- **Menú contextual** (clic derecho) con copiar, pegar, rellenar, definir bloque desde el byte, copiar selección a un fichero nuevo y escribir portapapeles (con aviso si el fichero crece).
- **Buscador** por hex o ASCII en A o B, con resaltado.
- **Navegación** entre diferencias y salto a un offset (`Goto`).
- **Analyzer**: extrae identificadores de ECU (números de pieza, versiones) del fichero cargado, configurable por `regex.txt`.
- **Conexión opcional al servidor** (login) para funciones online — la app funciona igual sin conexión.
- **Configuración persistente** (`config.json`): recuerda preferencias de vista, selección y opciones.
- **Barra de progreso** para operaciones grandes (trabajo en segundo plano, la interfaz no se congela).
- **Auto-actualización** desde GitHub Releases, con reinicio automático tras instalar.

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

Los parches se guardan como `<B>_<timestamp>_patch.diff`. Se siguen leyendo los parches antiguos en `.txt` (2 y 3 columnas).

---

## Uso

### 1. Cargar ficheros A y B

Arrastra y suelta los ficheros sobre las zonas **A** (original) y **B** (modificado o un `.diff`), o haz clic en cada zona para elegirlos. También desde el menú de funciones.

### 2. Guardar diff A-B

Compara A y B y guarda las diferencias en un fichero `<B>_<timestamp>_patch.diff` en formato de 3 columnas. Muestra el nombre, tamaño y fecha de cada fichero, y el número de diferencias encontradas.

### 3. Aplicar patch

Carga el original en **A** y un `.diff` (o `.txt` antiguo) en **B**, y genera un fichero parcheado. Si el parche trae la columna de valores viejos, se verifica que coincidan con A y se avisa si el fichero base no es el correcto.

### 4. Comparador hexadecimal (HexComp)

Abre una **ventana independiente** con el volcado hexadecimal de A y B lado a lado:

- **Offsets en azul**, **bytes cambiados en rojo**, **bytes editados en naranja**.
- Modo **"solo diferencias"** (con líneas de contexto) o **todo el binario**.
- **Vista configurable**: 8 / 16 / 32 bits, endianness (lo-hi / hi-lo) y base (hex / decimal).
- Barra de herramientas organizada por función: navegación, localización, selección/edición y vista.
- Se puede abrir con **un solo fichero** (modo editor) además de para comparar dos.
- El tamaño de cada fichero se muestra junto a su nombre.

### 5. Editar bytes y bloques

- **Clic** en un byte para seleccionarlo y escribe **2 dígitos hex** para cambiarlo; avanza al siguiente.
- **Selección** consecutiva, **rectangular** (solo las columnas del rectángulo) o por **filas**.
- **Definir bloque** escribiendo los offsets de inicio y fin, o desde el menú contextual sobre un byte.
- **Operaciones** sobre la selección: `00`, `FF`, `XOR`, o teclear un valor que se aplica a todo el bloque.
- **Copiar / pegar** bytes (Ctrl+C / Ctrl+V); el pegado respeta la forma rectangular.
- **Deshacer / rehacer** (Ctrl+Z / Ctrl+Y).
- **Copiar selección a un fichero nuevo** (`.bin`).
- **Escribir el portapapeles** desde un byte, con aviso si el fichero va a crecer.
- **Guardar** A y/o B editados como `.bin` nuevo, o **exportar** el diff del estado actual (con las ediciones).

### 6. Buscar y navegar

- **Goto**: escribe un offset en hexadecimal y salta a él, centrado.
- **Find**: busca en **Hex** (`C2 FC 01`) o en **ASCII** (texto), en A o B, con resaltado y siguiente/anterior.
- **Flechas de diferencia**: recorren las diferencias una a una, centrando cada una.
- La barra de scroll permanece siempre visible como referencia del tamaño del fichero.

### 7. Analyzer (identificadores de ECU)

Al cargar un fichero, el **analyzer** extrae automáticamente identificadores relevantes (números de pieza Bosch, versiones EDC17 / MED17 / MD1, etc.) definidos en `regex.txt`. Útil para reconocer de un vistazo qué ECU es cada fichero. Se puede activar / desactivar en **Ajustes**.

---

## Conexión con el servidor

DiffPatchTool puede conectarse de forma **opcional** al servidor de [diffpatchtool.com](https://diffpatchtool.com) para funciones online. **No es necesario iniciar sesión para usar la aplicación** — todas las funciones locales están siempre disponibles.

- **Icono de conexión** en la barra: gris (desconectado) o verde (conectado). Un clic abre el login o cierra la sesión.
- **Login opcional** con cuenta de Reproteq. La sesión se recuerda entre arranques (token), y opcionalmente el email y la contraseña.
- Conectarse habilitará funciones extra como **guardar y compartir parches** y **comprobar si un parche encaja** con un fichero cargado.

---

## Ajustes y sistema

- **Ajustes** (menú): activar / desactivar el analyzer, gestión de la cuenta, y preferencias que se guardan en `config.json` (`%APPDATA%\Reproteq\DiffPatchTool\`).
- **System** (menú): información del equipo — identificador de máquina (**HWID**), sistema operativo, CPU, RAM, ruta del ejecutable y versión.

---

## Actualizaciones

DiffPatchTool comprueba si hay una versión nueva en GitHub **al arrancar** y mediante el botón de la barra. Si hay una release más reciente, un botón permite **descargar e instalar** la actualización; el ejecutable se reemplaza y la aplicación **se reinicia automáticamente**.

---

## Compilación

Requiere [Rust](https://rustup.rs) instalado.

```bash
cargo run              # compilar y ejecutar (desarrollo)
cargo build --release  # binario optimizado
```

El ejecutable final queda en `target/release/DiffPatchTool.exe`.

En Linux se necesitan las librerías de desarrollo de GUI la primera vez:

```bash
sudo apt install libxcb1-dev libxkbcommon-dev libwayland-dev \
                 libgtk-3-dev libglib2.0-dev pkg-config
```

### Iconos y logo

- **Icono de la ventana**: se rasteriza desde `assets/r.svg`.
- **Icono del `.exe`** (Explorador y barra de tareas): `assets/icon.ico` (multi-resolución 16–256), incrustado por `build.rs` al compilar en Windows.
- **Logo** de la interfaz y del README: `assets/logo.svg`.

Los SVG con texto deben convertirse a trazados (paths) antes, porque el rasterizador no incrusta fuentes.

---

## En desarrollo / futuro

DiffPatchTool está en evolución activa. Próximas líneas de trabajo:

- **Base de datos de parches online**: guardar parches en el servidor y, al cargar un fichero, saber **al instante qué parches le sirven** — mediante huellas (hashes de dirección+valor) e identificadores de ECU, sin subir nunca el firmware completo.
- **Web con dominio propio** ([diffpatchtool.com](https://diffpatchtool.com)): portal de cuenta, gestión de parches y descargas.
- **Verificación de compatibilidad** de un parche con el fichero cargado antes de aplicarlo.
- **Más modos de vista** en el hex (float, con signo, binario).
- Mejoras continuas de rendimiento y usabilidad.

---

## ☕ Apoya mi trabajo

Si encuentras útil este proyecto y te gustaría apoyar su desarrollo, considera hacer una donación. ¡Cualquier cantidad es bienvenida y muy apreciada!

**Bitcoin (BTC):**

```
1Mmwhdw4mQzbuLbmPFdEF2uXMVi8X3kv68
```

**PayPal:** reproteq@gmail.com

| Monto        | Enlace de Donación                                                        |
|--------------|---------------------------------------------------------------------------|
| 1 €          | [Donar 1 €](https://www.paypal.com/paypalme/reproteq/1)                    |
| 5 €          | [Donar 5 €](https://www.paypal.com/paypalme/reproteq/5)                    |
| 10 €         | [Donar 10 €](https://www.paypal.com/paypalme/reproteq/10)                  |
| 25 €         | [Donar 25 €](https://www.paypal.com/paypalme/reproteq/25)                  |
| 50 €         | [Donar 50 €](https://www.paypal.com/paypalme/reproteq/50)                  |
| 100 €        | [Donar 100 €](https://www.paypal.com/paypalme/reproteq/100)               |
| Monto Libre  | [Donar Otro Monto](https://www.paypal.com/paypalme/reproteq)              |

---

## Contacto

- Web: [diffpatchtool.com](https://diffpatchtool.com) · [reproteq.com](https://reproteq.com)
- Email: reproteq@gmail.com
- Telegram: [@reproteq](https://t.me/reproteq)

---

## Licencia

© Reproteq. Todos los derechos reservados.
