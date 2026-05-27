# Python científico con Docker

Entorno reproducible para análisis científico con:

## Python

- NumPy
- Pandas
- Matplotlib
- SciPy
- xarray
- NetCDF4

## Octave

- Octave
- netcdf
- statistics
- io
- parallel

Compatible con scripts MATLAB simples y scripts diseñados para Octave.

Compatible con:

- Linux
- Windows
- macOS

---

# Requisitos

Se requiere Docker instalado en el sistema.

## Windows

### 1. Instalar Docker Desktop

Descargar:

https://www.docker.com/products/docker-desktop/

Durante la instalación:

- Activar WSL2 cuando el instalador lo solicite
- Reiniciar el equipo si es necesario

### 2. Verificar instalación

Abrir PowerShell y ejecutar:

```powershell
docker --version
docker-compose --version
```

o en versiones recientes:

```powershell
docker compose version
```

Resultado esperado:

```text
Docker version XX.XX.X
Docker Compose version X.X.X
```

---

## Linux (Ubuntu/Debian)

### 1. Instalar Docker

```bash
sudo apt update

sudo apt install \
    docker.io \
    docker-compose
```

### 2. Permitir ejecutar Docker sin sudo (opcional)

```bash
sudo usermod -aG docker $USER
```

Cerrar sesión y volver a entrar.

### 3. Verificar instalación

```bash
docker --version
docker-compose --version
```

Resultado esperado:

```text
Docker version XX.XX.X
docker-compose version X.X.X
```

### 4. Comprobación rápida

```bash
docker run hello-world
```

Si aparece:

```text
Hello from Docker!
```

Docker funciona correctamente.

---

# Descargar repositorio

```bash
git clone https://github.com/usuario/python-cientifico.git

cd python-cientifico
```

---

# Construcción inicial

Construir la imagen:

Docker Compose v1:

```bash
docker-compose build
```

Docker Compose v2:

```bash
docker compose build
```

Este paso solo debe ejecutarse la primera vez o cuando cambie el Dockerfile.

---

# Iniciar entorno

## Linux

Dar permisos al script:

```bash
chmod +x scripts/iniciar.sh
```

Iniciar:

```bash
./scripts/iniciar.sh
```

El script:

- detecta Docker Compose v1 o v2
- construye la imagen si aún no existe
- inicia el contenedor si está detenido
- crea el contenedor si no existe
- inicia automáticamente Jupyter Notebook

---

## Windows (PowerShell)

Docker Compose v1:

```powershell
docker-compose up -d
```

Docker Compose v2:

```powershell
docker compose up -d
```

---

# Acceso a Jupyter Notebook

Una vez iniciado el entorno:

Linux:

```bash
./scripts/iniciar.sh
```

Windows:

Docker Compose v1:

```powershell
docker-compose up -d
```

Docker Compose v2:

```powershell
docker compose up -d
```

Abrir el navegador en:

```text
http://localhost:8888
```

Si el contenedor se ejecuta en otra máquina:

```text
http://IP_DEL_SERVIDOR:8888
```

---

## Directorios visibles desde Jupyter

Dentro de Jupyter aparecerán:

```text
/trabajo
```

Contiene:

```text
Dockerfile
README.md
scripts/
ejemplos/
datos/
```

y:

```text
/datos
```

que apunta al directorio de datos externo configurado en:

```yaml
volumes:
  - /media/usuario/datos:/datos
```

Ejemplo:

Archivo real:

```text
/media/usuario/datos/clima/datos.csv
```

Disponible dentro de Jupyter como:

```text
/datos/clima/datos.csv
```

Uso:

```python
import pandas as pd

df=pd.read_csv("/datos/clima/datos.csv")
```

---

# Verificar entorno de Python

Dentro del contenedor ejecutar:

```bash
python -c "
import numpy
import pandas
import matplotlib
import scipy
import xarray
import netCDF4

print('Todo OK')
"
```

Resultado esperado:

```text
Todo OK
```


---

# Verificar entorno de Octave

Dentro del contenedor ejecutar:

```bash
octave --version
```

Para listar paquetes instalados:

```bash
octave --eval "pkg list"
```

Resultado esperado:

```text
Package Name | Version

io
netcdf
parallel
statistics
```

---

# Ejecutar scripts MATLAB / Octave

El entorno incluye GNU Octave, compatible con muchos scripts `.m`.

Ejecutar un script:

```bash
octave archivo.m
```

o:

```bash
octave --eval "run('archivo.m')"
```

Ejemplo:

```bash
octave --eval "run('/datos/modelos/mi_script.m')"
```

---

## Compatibilidad

Funciona especialmente bien con:

- operaciones matriciales
- estadísticas
- análisis numérico
- NetCDF
- procesamiento de datos
- scripts diseñados específicamente para Octave

Algunas funciones propietarias de MATLAB pueden no existir en Octave y requerir modificaciones.

---

# Ejemplo CSV

Archivo:

```text
ejemplos/ejemplo_csv.py
```

Ejecutar:

```bash
python ejemplos/ejemplo_csv.py
```

Contenido:

```python
import pandas as pd

df=pd.read_csv("/datos/datos.csv")

print(df.head())
```

---

# Ejemplo NetCDF

Archivo:

```text
ejemplos/ejemplo_netcdf.py
```

Ejecutar:

```bash
python ejemplos/ejemplo_netcdf.py
```

Contenido:

```python
import xarray as xr

ds=xr.open_dataset("/datos/clima.nc")

print(ds)
```

---

# Colocar datos

Los datos deben colocarse dentro de:

```text
datos/
```

o en Linux puede modificarse el volumen para apuntar a otro disco, por ejemplo:

```yaml
volumes:
  - /media/usuario/datos:/datos
```

Dentro del contenedor aparecerán como:

```text
/datos
```

Ejemplo:

Archivo real:

```text
/media/usuario/datos/clima/archivo.csv
```

Dentro del contenedor:

```text
/datos/clima/archivo.csv
```

Uso:

```python
import pandas as pd

df=pd.read_csv("/datos/clima/archivo.csv")
```

---

# Detener entorno

Docker Compose v1:

```bash
docker-compose down
```

Docker Compose v2:

```bash
docker compose down
```

---

# Prueba completa desde cero

Eliminar contenedor:

Docker Compose v1:

```bash
docker-compose down
```

Eliminar imagen:

```bash
docker rmi python-cientifico
```

Reconstruir:

```bash
docker-compose build
```

Iniciar:

```bash
./scripts/iniciar.sh
```

---

# Datos de ejemplo

Datos disponibles en:

https://drive.google.com/drive/folders/1Uum3oaP0UcxXvS-uw_W5eZsps26u_bzY

---

# Estructura esperada

```text
python-cientifico/
│
├── Dockerfile
├── docker-compose.yml
├── README.md
├── .gitignore
│
├── scripts/
│   └── iniciar.sh
│
├── ejemplos/
│   ├── ejemplo_csv.py
│   └── ejemplo_netcdf.py
│
└── datos/
```