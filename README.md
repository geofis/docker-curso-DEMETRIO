# Python científico con Docker

Entorno reproducible para:

- NumPy
- Pandas
- Matplotlib
- SciPy
- xarray
- NetCDF4

Compatible con:

- Linux
- Windows
- macOS

---

# Requisitos

Instalar Docker:

Windows:
https://www.docker.com/products/docker-desktop/

Linux:
https://docs.docker.com/engine/install/

---

# Descargar repositorio

```bash
git clone https://github.com/usuario/python-cientifico.git

cd python-cientifico
```

---

# Crear entorno

```bash
docker compose build
```

---

# Iniciar

Linux:

```bash
./scripts/iniciar.sh
```

Windows (PowerShell):

```powershell
docker compose up -d

docker exec -it python-cientifico bash
```

---

# Ejemplo CSV

```bash
python ejemplos/ejemplo_csv.py
```

---

# Ejemplo NetCDF

```bash
python ejemplos/ejemplo_netcdf.py
```

---

# Colocar datos

Copiar archivos dentro de:

```text
datos/
```

Dentro del contenedor aparecerán como:

```text
/datos/
```

Ejemplo:

```python
df=pd.read_csv("/datos/archivo.csv")
```

# Datos en Drive

[https://drive.google.com/drive/folders/1Uum3oaP0UcxXvS-uw_W5eZsps26u_bzY](https://drive.google.com/drive/folders/1Uum3oaP0UcxXvS-uw_W5eZsps26u_bzY)
