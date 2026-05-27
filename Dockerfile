FROM python:3.12-slim

LABEL maintainer="Jose Martinez"

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    gfortran \
    make \
    libnetcdf-dev \
    octave \
    octave-netcdf \
    octave-statistics \
    octave-io \
    octave-parallel \
    gnuplot \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    numpy \
    pandas \
    matplotlib \
    scipy \
    xarray \
    netCDF4 \
    notebook

WORKDIR /trabajo

CMD ["/bin/bash"]