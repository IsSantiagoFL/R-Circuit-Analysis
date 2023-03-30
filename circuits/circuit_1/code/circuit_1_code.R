################################################################################
# Script: circuit_1_code.R
# Autor: Santiago Ismael Flores Chávez
# Fecha de creación: 29 de Marzo de 2023
# Descripción: ...

################################################################################

# Carga de librerías necesarias
library(knitr)
library(errors)

################################################################################

# EXTRACCIÓN

# Cargar el archivo CSV
ruta_archivo <- "circuits/circuit_1/data/circuit_1_data.csv"
bd_circuito_1 <- read.csv(ruta_archivo, header = TRUE, sep = ",")

# Verificar que se haya cargado correctamente
head(bd_circuito_1)
View(bd_circuito_1)
class(bd_circuito_1)

# TRANSFORMACIÓN

str(bd_circuito_1)

# Dar formato de la precisión de las lecturas a las columnas.
bd_circuito_1$Voltaje.suministrado..V. <- round(bd_circuito_1$Voltaje.suministrado..V., 2)
bd_circuito_1$Intensidad.de.corriente..mI. <- round(bd_circuito_1$Intensidad.de.corriente..mI., 1)
bd_circuito_1$Voltaje.de.la.resistencia..V. <- round(bd_circuito_1$Voltaje.de.la.resistencia..V., 2)


# CARGA



# VISUALIZACIÓN
## kable(bd_circuito_1)
kable(bd_circuito_1, format = "markdown", digits = 4, caption = "Datos obtenidos experimentalmente del circuito 1", col.names = c("Lectura", "Voltaje suministrado (V)", "Intensidad de corriente (mA)", "Volaje de la resistencia (V)") )


