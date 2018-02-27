

#  Creando el ambiente 

setwd("D:/Downloads")

library(bibliometrix)

#  Adquiriendo los datos

tos.1 <- readFiles("Marketing_WordMouth_02262018.txt")
class(tos.1)

tos.2 <- convert2df(tos.1)


tos.2$id.filas <- row.names(tos.2)
tos.2$id.filas <- NULL


# Análisis descriptivo

table(tos.2$PT)
# tos.2[  ,  ]

View(tos.2[tos.2$PT == "S",])

# Cambiar J por 1 y S por 2

tos.dummy <- tos.2

tos.dummy$PT <- ifelse(tos.dummy$PT == "J", 1, 2)

table(tos.dummy$PT)

table(tos.2$LA)

table(tos.2$DT)

#Creamos el dataframe con valores aleatorios
lista.enlaces <- data.frame(Source = c("author1"),
                            Target = c("author2"), 
                            stringsAsFactors = FALSE)

#Inicilizamos un acumulador, encargado de manejar los valores de todos los registros
continuidad<-0

for (i in 1:length(tos.2)){                 
  
  # Obtenemos cada referencia por separado
  Referencias <- data.frame(strsplit(tos.2$CR[c(i)], split=";"))
  #View(Referencias)
  
  #Hallamos la cantidad de referencias halladas en ese paper
  Size_referencias <- dim(Referencias)[1]
  #print(Size_referencias)
  
  #Creamos un ciclo para analizar cada referencia por separado
  for (j in 1:Size_referencias){
    lista.enlaces[j+continuidad,] <- data.frame(Source=tos.2$AF[c(i)], Target = as.character(Referencias[j,1]), stringsAsFactors = FALSE )
    #print(j+continuidad)
    #print(Referencias[j,1])
  }
  continuidad<-continuidad+Size_referencias
  #View(lista.enlaces)
}
View(lista.enlaces)