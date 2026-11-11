# Relación entre Tiempos de Resolución WCA (3x3x3) y Rendimiento Académico (PISA)
---

## 📁 Estructura del Repositorio

- `Individual_TorresMoraga_HerramientasDatosI_2026.qmd`: Documento principal en Quarto que integra el análisis final y compila el reporte en PDF.
- `Individual_TorresMoraga_HerramientasDatosI_2026.pdf`: Versión final compilada del reporte académico.
- `cod/limpia data/`: Carpeta que contiene los scripts de procesamiento y generación de tablas:
  - `cargar datos WCA.R`: Script encargado de procesar los microdatos de la WCA y unirlos con las fuentes de PISA y el Banco Mundial.
  - `creacion de tablas.qmd`: Documento en Quarto utilizado como apoyo para la creación de gráficos, tablas y almacenamiento de versiones intermedias de las bases de datos.

---

## ⚠️ Nota sobre los Archivos Pesados y Datos de la WCA

Debido a las políticas de límite de tamaño de archivo de GitHub, **los microdatos en bruto de la World Cube Association no se encuentran incluidos en este repositorio**. 

Los archivos excluidos únicamente por su peso son:
- El archivo comprimido original de la base de datos de la WCA (`.zip`)
- El archivo de exportación masiva en bruto (`WCA_export_results.tsv`)

> **Nota:** Las bases de datos intermedias y procesadas que no representan problemas de almacenamiento **sí se encuentran adjuntas en el repositorio**, por lo que es posible compilar y auditar el flujo de trabajo directamente.

### Cómo replicar todo el pipeline desde cero:
1. **Descarga de microdatos WCA (opcional si deseas re-procesar todo):** Obtén el archivo oficial más reciente de exportación de resultados desde la [sección de exportación de la WCA](https://www.worldcubeassociation.org/results/misc/export.html) y colócalo en tu directorio local.
2. **Ejecución del pipeline:** Utiliza el script `cargar datos WCA.R` ubicado en la carpeta `cod/limpia data/` para procesar el archivo masivo, aplicar los filtros de participación (umbral de 300 participantes) e integrar las fuentes complementarias (*learningtower* y *WDI*).
3. **Compilación del reporte:** Renderiza el documento principal en Quarto para generar las salidas finales:
   ```bash
   quarto render Individual_TorresMoraga_HerramientasDatosI_2026.qmd --to pdf