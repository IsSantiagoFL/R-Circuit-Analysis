#!/bin/bash

# Pide al usuario el nombre del circuito
read -p "Introduce el nombre del circuito: " circuit_name

# crea el directorio del circuito
mkdir "$circuit_name"

# Crea las subcarpetas dentro del directorio del circuito
mkdir "$circuit_name/data"
mkdir "$circuit_name/code"
mkdir "$circuit_name/images"
mkdir "$circuit_name/documents"
mkdir "$circuit_name/references"
mkdir "$circuit_name/results"

# Cración de los archivos dentro de las subcarpetas correspondientes
touch "$circuit_name/data/${circuit_name}_data.csv"
touch "$circuit_name/code/${circuit_name}_code.R"
touch "$circuit_name/results/${circuit_name}_results.Rmd"

# Mensaje de confirmación
echo "Estructura de carpetas y archivos creada para el circuito $circuit_name"
