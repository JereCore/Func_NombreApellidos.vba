#CARGANDO DATOS

library(readr)
Noviembre <- read_delim("JLP/PAGOS_TC/Noviembre.txt", 
                        "\t", escape_double = FALSE, col_types = cols(Monto_de_pago_de_Tarjeta = col_character()), 
                        trim_ws = TRUE)
View(Noviembre)

#TRANSFORMANDO DE , DECIMAL A . PUNTO DECIMAL Y LUEGO A NÚMERICO
Noviembre$monto_2 <- sub(".", "", Noviembre$`Monto de pago de Tarjeta`, fixed = TRUE)
Noviembre$monto_3 <- sub(",", ".", Noviembre$monto_2, fixed = TRUE)
Noviembre$monto_4 <- as.numeric(Noviembre$monto_3)
Noviembre$monto <- Noviembre$monto_4
Noviembre$monto_2 <- NULL
Noviembre$monto_3 <- NULL
Noviembre$monto_4 <- NULL


#VALIDANDO TIPO DE DATO
class(Noviembre$`Monto de pago de Tarjeta`)
class(Noviembre$monto)

#AGRUPANDO MONTOS POR CLIENTE
Noviembre_agrupado <- sqldf("Select [Número Identificación], SUM(monto) from Noviembre group by [Número Identificación] ")

#ASIGNANDO MONTO A VARIABLE X PARA SU EVALUACIÓN DE CORTES
X <- Noviembre_agrupado$`SUM(monto)`

res1 <- hist(X)

cortes <- length(res1$breaks) - 1

div <- table(cut(X, breaks = 100, dig.lab=8))

mat <- data.frame(div)

mat

setwd("C:/Users/jloayzap/Documents/JLP/PAGOS_TC")

#OBTENIENDO MONTOS MAYORES A 30000 SOLES POR PAGO Y LUEGO TRANSFORMANDOLO A DOLAR
options(digits =9) # <- validar digitos decimales
Noviembre_30000 <- sqldf("select * from Noviembre where monto >= 30000")

Noviembre_30000$monto_dolar <- Noviembre_30000$monto/4.024419355

write.csv(Noviembre_30000,"Noviembre_30000.csv")
