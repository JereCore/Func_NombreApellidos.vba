#CORRER DESDE AQUI
library(readxl)
library(dplyr)
library(data.table)


username_drive = Sys.getenv("OneDrive")
username_drive_validacion = Sys.getenv("OneDrive")
username_drive = gsub("\\\\", "/", username_drive)
username_drive_validacion = gsub("\\\\", "/", username_drive_validacion)
directorio_bases = paste(username_drive, "/MOVIMIENTOS_CLIENTES/Bases", sep = "")
setwd(directorio_bases)
temp = list.files(pattern="*.csv")
myfiles = lapply(temp, read.delim, sep=";")
myfiles2 <- Filter(function(x) length(x) == 35, myfiles)
myfiles2 <- lapply(myfiles2, function(x) cbind(x, MONTO_TRX = "",GLOSA_PERSONALIZADA = "", CODIGO_CCI = ""))
myfiles3 <- Filter(function(x) length(x) == 38, myfiles)
myfiles4 <- c(myfiles2, myfiles3)
DT = rbindlist(myfiles4)

#SELECCIONADO DIRECTORIO POR USUARIO
if (username_drive_validacion == "C:/Users/jloayzap/OneDrive - Falabella") {
  directorio_bases_usuario = paste(username_drive, "/MOVIMIENTOS_CLIENTES/jloayzap", sep = "")
  setwd(directorio_bases_usuario)
} else if (username_drive_validacion == "C:/Users/dcondorim/OneDrive - Falabella") {
  directorio_bases_usuario = paste(username_drive, "/MOVIMIENTOS_CLIENTES/dcondorim", sep = "")
  setwd(directorio_bases_usuario)
} else if (username_drive_validacion == "C:/Users/dvalladaresc/OneDrive - Falabella") {
  directorio_bases_usuario = paste(username_drive, "/MOVIMIENTOS_CLIENTES/dvalladaresc", sep = "")
  setwd(directorio_bases_usuario)
} else if ((username_drive_validacion == "C:/Users/cvicentes/OneDrive - Falabella")) {
  directorio_bases_usuario = paste(username_drive, "/MOVIMIENTOS_CLIENTES/cvicentes", sep = "")
  setwd(directorio_bases_usuario)
} else {
  directorio_bases_usuario = paste(username_drive, "/MOVIMIENTOS_CLIENTES/jcarpiom", sep = "")
  setwd(directorio_bases_usuario)
}
#HASTA AC?



MOVIMIENTOS_NOV <- sqldf("select * from DT where fecha like '%/11/2021%' and transaccion not in ('COBRO COMISION', 'COBRO ITF',
                 'COMISION RETIRO EN CUENTA CAJA MN CON ITF','DEVOLUCIÓN ITF', 'REG DEV COMPRA/RETIRO MN CON ITF',
                 'REGULARIZACIÓN ASUME BANCO MN', 'REGULARIZACIÓN ABONO T COMPRA/RETIRO MN') AND EVENTO <> 'REVR'")

REVERSAS_NOV <- sqldf("select * from DT where fecha like '%/11/2021%' and transaccion not in ('COBRO COMISION', 'COBRO ITF',
                 'COMISION RETIRO EN CUENTA CAJA MN CON ITF','DEVOLUCIÓN ITF', 'REG DEV COMPRA/RETIRO MN CON ITF',
                 'REGULARIZACIÓN ASUME BANCO MN', 'REGULARIZACIÓN ABONO T COMPRA/RETIRO MN') and EVENTO = 'REVR'")

##TRANSACCIONES QUE NO SE DEBEN DE TOMAR EN CUENTA
#COBRO COMISIÓN 
#COMISION RETIRO EN CUENTA CAJA MN CON ITF
#DEVOLUCIÓN ITF
#COBRO COMISIÃ
#REG DEV COMPRA/RETIRO MN CON ITF
#REGULARIZACIÓN ASUME BANCO MN
#REGULARIZACIÓN ABONO T COMPRA/RETIRO MN
#COBRO ITF

write.csv(MOVIMIENTOS_NOV, "MOVIMIENTOS_NOV2.csv")
write.csv(REVERSAS_NOV, "REVERSAS_NOV2.csv")


TRANSACCIONES <- sqldf("select DISTINCT(transaccion) from PRUEBA1")

str(DT)


#QUERYS EJEMPLO POR DNI
CONSULTA2 <-sqldf("select * FROM DT where NUMERODEDOCUMENTO like '%2051200209%'")


#QUERYS EJEMPLO POR CUENTA
CONSULTA_MI_FARMA <-sqldf("select * FROM DT where NOMBRES like '%MIFARMA%'")


#validacion_fcc_pasivos
CONSULTA_FCC_PASIV_DNI <-sqldf("select * FROM DT where NUMERODEDOCUMENTO like '%06728767%'")
CONSULTA_FCC_PASIV_CUENTA <-sqldf("select * FROM DT where CUENTA like '%3020400345289%'")

CONSULTA_FCC_PASIV_SBS1 <-sqldf("select * FROM DT where NUMERODEDOCUMENTO like '%07970181%'")
CONSULTA_FCC_PASIV_SBS2 <-sqldf("select * FROM DT where NUMERODEDOCUMENTO like '%43595092%'")
CONSULTA_FCC_PASIV_SBS3 <-sqldf("select * FROM DT where NUMERODEDOCUMENTO like '%09156928%'")


#EXPORTAR
write.csv(CONSULTA_MI_FARMA, "CONSULTA_MI_FARMA.csv")


LIQ_DAP <- sqldf("select * from DT where TRANSACCION like '%LIQUIDACION DAP%'")

write.csv(PRUEBA1, "MOVIMIENTOS_NOV.csv")

getwd()

