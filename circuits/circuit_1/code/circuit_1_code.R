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
# bd_circuito_1$Voltaje.suministrado..V. <- round(bd_circuito_1$Voltaje.suministrado..V., 2)
# bd_circuito_1$Intensidad.de.corriente..mI. <- round(bd_circuito_1$Intensidad.de.corriente..mI., 1)
# bd_circuito_1$Voltaje.de.la.resistencia..V. <- round(bd_circuito_1$Voltaje.de.la.resistencia..V., 2)

# Creando las columnas para el valor y la incertidumbre
bd_circuito_1$Voltaje.suministrado..V._errores <- bd_circuito_1$Voltaje.suministrado..V.
bd_circuito_1$Voltaje.de.la.resistencia..V._errores <- bd_circuito_1$Voltaje.de.la.resistencia..V.
bd_circuito_1$Intensidad.de.corriente..mI._errores <- bd_circuito_1$Intensidad.de.corriente..mI.

# Dar las incertidumbres para cada columna:
errors(bd_circuito_1$Voltaje.suministrado..V._errores) <- 0.01
errors(bd_circuito_1$Voltaje.de.la.resistencia..V._errores) <- 0.01

errors(bd_circuito_1$Intensidad.de.corriente..mI._errores) <- 0.1

bd_circuito_1
View(bd_circuito_1)
class(bd_circuito_1)
str(bd_circuito_1)

# crear columna que contenga las incertidumbres para los voltajes y para la intensidad de corriente:
bd_circuito_1$incertidumbre_voltaje <- errors(bd_circuito_1$Voltaje.de.la.resistencia..V._errores)
bd_circuito_1$incertidumbre_amperaje <- errors(bd_circuito_1$Intensidad.de.corriente..mI._errores)

# Crear una columna para el valor experimental de la resistencia
bd_circuito_1$Resistencia <- (bd_circuito_1$Voltaje.de.la.resistencia..V. / bd_circuito_1$Intensidad.de.corriente..mI.) * 1000
bd_circuito_1$Resistencia_errores <- (bd_circuito_1$Voltaje.de.la.resistencia..V._errores / bd_circuito_1$Intensidad.de.corriente..mI._errores) * 1000
bd_circuito_1
View(bd_circuito_1)
class(bd_circuito_1)
str(bd_circuito_1)

# Crear una columna que contenga solo los valores de las incertidumbres de las resistencias

bd_circuito_1$incertidumbre_resistencia <- errors(bd_circuito_1$Resistencia_errores)


# CARGA

# Crear una dat frame que contenga los datos para hallar los valores experimentales de la resistencia
tabla_resistencia <- bd_circuito_1[, c("Lectura", "Voltaje.de.la.resistencia..V.", "incertidumbre_voltaje", "Intensidad.de.corriente..mI.", "incertidumbre_amperaje", "Resistencia", "incertidumbre_resistencia")]
tabla_resistencia

# VISUALIZACIÓN
## kable(bd_circuito_1)
kable(bd_circuito_1, format = "markdown", digits = 4, caption = "Datos obtenidos experimentalmente del circuito 1", col.names = c("Lectura", "Voltaje suministrado (V)", "Intensidad de corriente (mA)", "Volaje de la resistencia (V)") )

# Tabla para los valores experimentales de la incertidumbre.
kable(tabla_resistencia, format = "markdown",
      digits = 4,
      caption = "Mediciones del voltaje, corriente, resistencia y sus incertidumbres.",
      col.names = c("Lectura", "Volaje de la resistencia (V)", "inc_v", "Intensidad de corriente (mA)", "inc_I", "Resistencia", "inc_R") )
