# Transmilenio Prueba Tecnica

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(readxl))

print("Inicio")

# importa data
print("Lee Data")
# df <- read_excel("PSO20220223.xls",sheet = "Arcos Comerciales y T.Recorrido")
df <- read_excel("milenio/PSO20220223.xls",sheet = "Arcos Comerciales y T.Recorrido")


# manipula data
print("Manipulando Data")
data <- df %>%
  select(
    linea,
    sentido,
    secuencia,
    tipodia,
    sublinea = trayecto,
    tr_optimoo = tr_optimo,
    tr_minimoo = tr_minimo,
    tr_maximoo = tr_maximo,
    nodo = nodo_1,
    nodo_2,
    hora_desdeo = hora_desde,
    hora_hastao = hora_hasta
  ) %>%
  mutate(hora_desde = as.POSIXct(hora_desdeo,format = "%H:%M:%S"),
         hora_hasta = as.POSIXct(hora_hastao,format = "%H:%M:%S")) %>%
  group_by(linea,sublinea,sentido) %>%
  mutate(
            tr_optimo = min(tr_optimoo),
            tr_minimo = min(tr_minimoo),
            tr_maximo = min(tr_maximoo)
            ) %>%
  mutate(hora_minimo = min(hora_desde),
         hora_maximo = max(hora_desde)) %>%
  select(
    linea,
    sentido,
    tipodia,
    sublinea,
    tr_optimo,
    tr_minimo,
    tr_maximo,
    nodo,
    nodo_2,
    hora_desde,
    hora_minimo,
    hora_maximo
  ) %>%
  filter(hora_desde == hora_minimo |
           hora_desde == hora_maximo)

  
# save manipulated data to output folder
print("Guarda data manipulada a .csv")
# write_csv(data, "output/data.csv")
write_csv(data, "milenio/output/data.csv")

print(glimpse(data))
print("Terminado")
