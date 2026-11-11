library(dplyr)

# PASO 1: CARGAR RESULTADOS 
resultados.raw <- read.delim("WCA_export_results.tsv", header = FALSE, sep = "\t", quote = "")
resultados.raw <- resultados.raw[-1, ] # Eliminar encabezado corrupto

# CORRECCIÓN DE COLUMNAS:
# V3 = best (mejor tiempo en centésimas)
# V4 = average (promedio en centésimas)
# V5 = competitionId 
# V6 = pos (posición en el torneo)
# V7 = eventId ("333")
# V9 = personId (ID del participante)
# V13 = countryId (País)

tabla.final.333 <- resultados.raw %>%
  dplyr::filter(V7 == "333") %>% 
  dplyr::select(
    personId = V9, 
    competitionId = V5, 
    best = V3,      
    average = V4,   
    countryId = V13
  ) %>%
  dplyr::mutate(
    best = as.numeric(best),
    average = as.numeric(average)
  )

# PASO 2: CONVERTIR TIEMPOS A SEGUNDOS REALES


tabla.final.333 <- tabla.final.333 %>%
  dplyr::mutate(
    best.segundos = ifelse(best > 0, best / 100, NA),
    average.segundos = ifelse(average > 0, average / 100, NA)
  )

# PASO 3: REPORTE FINAL Y GUARDADO

if(nrow(tabla.final.333) > 0) {
  
resumen <- tabla.final.333 %>% 
  summarise(tiempo.promedio = mean(average.segundos, na.rm = TRUE),
            n = n(),
                  .by = countryId
                       ) %>% 
  rename(pais = countryId) 
  
resumen <- resumen %>% 
  mutate(
    pais = countrycode::countrycode(pais, origin = "country.name.en", destination = "iso3c"),
    pais = ifelse(is.na(pais), "KSV", pais) 
  )

  
  # Guardar archivo definitivo
write.csv(resumen, "tiempos.promedio.por.pais", row.names = FALSE)  

  write.csv(tabla.final.333, "tiempos.y.paises.333.csv", row.names = FALSE)
  print("Archivo guardado con éxito como 'tiempos.y.paises.333.csv'")
} else {
  print("⚠️ Algo falló en el procesamiento.")
}

