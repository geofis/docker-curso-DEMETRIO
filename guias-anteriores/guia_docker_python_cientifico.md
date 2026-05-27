# Guía rápida: Contenedor Docker Python científico

Este entorno crea un contenedor Docker con Python y los paquetes:

- NumPy
- Pandas
- Matplotlib
- SciPy
- xarray
- NetCDF4

Además monta el disco secundario `/media/jr/datos` para acceder a los archivos directamente sin copiarlos al contenedor.

---

# 1. Crear directorio de trabajo

```bash
mkdir ~/python-cientifico
cd ~/python-cientifico
```

---

# 2. Crear el Dockerfile

Crear un archivo llamado:

```text
Dockerfile
```

con el siguiente contenido:

```dockerfile
FROM python:3.12-slim

# Dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    gfortran \
    libnetcdf-dev \
    && rm -rf /var/lib/apt/lists/*

# Paquetes Python científicos
RUN pip install --no-cache-dir \
    numpy \
    pandas \
    matplotlib \
    scipy \
    xarray \
    netCDF4

# Directorio de trabajo por defecto
WORKDIR /trabajo

CMD ["/bin/bash"]
```

---

# 3. Construir la imagen

Ejecutar:

```bash
docker build -t python-cientifico .
```

Esto crea una imagen Docker llamada:

```text
python-cientifico
```

---

# 4. Ejecutar el contenedor con acceso al disco secundario

Ejecutar:

```bash
docker run -it --rm \
    -v /media/jr/datos:/datos \
    -v $(pwd):/trabajo \
    python-cientifico
```

## Explicación

### `-it`

Permite abrir una consola interactiva.

### `--rm`

Elimina automáticamente el contenedor al salir.

La imagen permanece instalada.

### `-v /media/jr/datos:/datos`

Monta:

```text
/media/jr/datos
```

como:

```text
/datos
```

dentro del contenedor.

Ejemplo:

Archivo real:

```text
/media/jr/datos/clima/datos.csv
```

Se verá dentro del contenedor como:

```text
/datos/clima/datos.csv
```

### `-v $(pwd):/trabajo`

Monta el directorio actual como directorio de trabajo.

---

# 5. Leer datos desde Python

Ejemplo con CSV:

```python
import pandas as pd

df = pd.read_csv("/datos/mi_archivo.csv")

print(df.head())
```

Ejemplo con NetCDF:

```python
import xarray as xr

ds = xr.open_dataset("/datos/clima.nc")

print(ds)
```

---

# 6. Verificar instalación

Ejecutar:

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

# 7. Entrar nuevamente al entorno

Más adelante puedes volver a entrar usando:

```bash
docker run -it --rm \
    -v /media/jr/datos:/datos \
    python-cientifico
```

---

# Notas

- Los datos permanecen en el disco físico real.
- Eliminar el contenedor no elimina los archivos.
- La imagen Docker queda instalada hasta borrarla manualmente.
- Puedes instalar paquetes adicionales posteriormente:

```bash
pip install nombre_paquete
```

- Ver imágenes instaladas:

```bash
docker images
```

- Ver contenedores:

```bash
docker ps -a
```

- Eliminar una imagen:

```bash
docker rmi python-cientifico
```

---

# Estructura típica

```text
~/python-cientifico/
│
├── Dockerfile
└── README.md
```