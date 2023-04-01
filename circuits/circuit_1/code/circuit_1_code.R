################################################################################
# Script: circuit_1_code.R
# Autor: Santiago Ismael Flores Chávez
# Fecha de creación: 29 de Marzo de 2023
# Descripción: ...

################################################################################

# Carga de librerías necesarias
library(knitr)
library(errors)
library(ggplot2)

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

# Valores maximos y minimos para los voltaje y la corriente:
bd_circuito_1$corriente_minima <- errors_min(bd_circuito_1$Intensidad.de.corriente..mI._errores)
bd_circuito_1$corriente_maxima <- errors_max(bd_circuito_1$Intensidad.de.corriente..mI._errores)

bd_circuito_1$Voltaje_resistencia_minimo <- errors_min(bd_circuito_1$Voltaje.de.la.resistencia..V._errores)
bd_circuito_1$Voltaje_resistencia_maximo <- errors_max(bd_circuito_1$Voltaje.de.la.resistencia..V._errores)

bd_circuito_1$Voltaje_suministrado_minimo <- errors_min(bd_circuito_1$Voltaje.suministrado..V._errores)
bd_circuito_1$Voltaje_suministrado_maximo <- errors_max(bd_circuito_1$Voltaje.suministrado..V._errores)


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
bd_circuito_1$resistencia_minima <- errors_min(bd_circuito_1$Resistencia_errores)
bd_circuito_1$resistencia_maxima <- errors_max(bd_circuito_1$Resistencia_errores)
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
## kable(bd_circuito_1, format = "markdown", digits = 4, caption = "Datos obtenidos experimentalmente del circuito 1", col.names = c("Lectura", "Voltaje suministrado (V)", "Intensidad de corriente (mA)", "Volaje de la resistencia (V)") )

# Tabla para los valores experimentales de la incertidumbre.
kable(tabla_resistencia, format = "markdown",
      digits = 4,
      caption = "Mediciones del voltaje, corriente, resistencia y sus incertidumbres.",
      col.names = c("Lectura", "Voltaje de la resistencia (V)", "inc_v", "Intensidad de corriente (mA)", "inc_I", "Resistencia", "inc_R") )

# Grafico de dispercion corriente vs voltaje
# plot(tabla_resistencia$Voltaje.de.la.resistencia..V., tabla_resistencia$Intensidad.de.corriente..mI.)

# Crear el gráfico de dispersión indicando valores maximo y minimo
# plot(V_res, I, xlab = "Voltaje de resistencia (V)", ylab = "Intensidad (mA)", 
     #ylim = c(0, max(I) + max(error_y)), 
     # xlim = c(0, max(V_res) + max(error_x)), pch=19)

# # Agregar las barras de error
# # arrows(tabla_resistencia$Voltaje.de.la.resistencia..V., tabla_resistencia$Intensidad.de.corriente..mI. - tabla_resistencia$incertidumbre_amperaje, 
#        tabla_resistencia$Voltaje.de.la.resistencia..V., tabla_resistencia$Intensidad.de.corriente..mI. + tabla_resistencia$incertidumbre_amperaje, 
#        angle=90, code=3, length=0.1)
# 
# # arrows(tabla_resistencia$Voltaje.de.la.resistencia..V. - tabla_resistencia$incertidumbre_voltaje, 
#        tabla_resistencia$Intensidad.de.corriente..mI., 
#        tabla_resistencia$Voltaje.de.la.resistencia..V. + tabla_resistencia$incertidumbre_voltaje, 
#        tabla_resistencia$Intensidad.de.corriente..mI., 
#        angle=90, code=3, length=0.1)




ggplot(bd_circuito_1, aes(x = Voltaje.de.la.resistencia..V., y = Intensidad.de.corriente..mI.)) + 
  geom_point(color = "black", size = 2) +
  geom_errorbar(aes(ymin = corriente_minima, 
                    ymax = corriente_maxima), 
                width = 0.0015,
                color = "red") +
  geom_errorbar(aes(xmin = Voltaje_resistencia_minimo, 
                    xmax = Voltaje_resistencia_maximo), 
                width = 0.15,
                color = "red") +
  labs(title = "Relación voltaje-corriente",
       x = "Voltaje (V)",
       y = "Corriente (mA)",
       caption = "Gráfico de disperción que muestra la relación que hay entre el\n voltaje y la corriente que pasa por la resistencia del circuito") +
  theme_classic() + 
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"),
        axis.title = element_text(size = 14),
        text = element_text(family = "Arial"),
        axis.text = element_text(size = 12),
        plot.caption = element_text(hjust = 1, margin = margin(t = 10), size = 8),
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size = 12),
        panel.background = element_rect(fill = "white", colour = "grey50", size = 1),
        panel.grid.major = element_line(colour = "gray", size = 0.4),
        panel.grid.minor = element_line(color = "gray70", size = 0.3, linetype = "dashed"))


