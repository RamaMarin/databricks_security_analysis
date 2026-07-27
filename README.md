# Análisis de Índices de Delincuencia en México - Data Pipeline End-to-End

## Descripción del Proyecto
Este proyecto es un pipeline de datos end-to-end diseñado para procesar, transformar y visualizar estadísticas oficiales de índices de delincuencia en México. Implementa una **Arquitectura Medallion** utilizando el ecosistema de **Databricks LakeFlow** para orquestar la ingesta y transformación de datos, apoyado por **Supabase** como capa de servicio y **Looker Studio** para la visualización final.

## Arquitectura de Datos

1. **Data Source:** Datos oficiales de índices delictivos de México.
2. **Databricks (LakeFlow):**
   - **Capa Bronze:** Ingesta de datos crudos manteniendo el formato original e historial (`bronze.sql`).
   - **Capa Silver:** Limpieza, filtrado, normalización y cruce de datos para obtener una estructura tabular refinada (`silver.sql`).
   - **Capa Gold:** Agregaciones a nivel de negocio y métricas clave listas para el consumo de BI (`gold.sql`).
3. **Serving Layer (Supabase):** La base de datos PostgreSQL en Supabase almacena los datos de la capa Gold (`schema_database.sql`), actuando como el backend optimizado para consultas analíticas.
4. **Visualización (Looker Studio):** Dashboard interactivo conectado directamente a Supabase (PostgreSQL) para explorar tendencias de delincuencia.

## Estructura del Repositorio
```text
project_yucatan/
└── pipeline_bronze_silver_gold/
    ├── explorations/
    │   └── Exploration.ipynb      # Análisis exploratorio inicial (EDA)
    ├── transformations_py/
    │   ├── bronze.sql             # Scripts de ingesta cruda
    │   ├── silver.sql             # Lógica de limpieza y transformación
    │   └── gold.sql               # Modelado dimensional / agregaciones
    └── utilities/
        └── schema_database.sql    # DDL para Supabase
```

## Tecnologías Utilizadas
- **Procesamiento y ETL:** Databricks (LakeFlow)
- **Lenguajes:** SQL, Python (Notebooks)
- **Almacenamiento (Gold):** Supabase (PostgreSQL)
- **Visualización (BI):** Looker Studio
- **Patrón Arquitectónico:** Medallion Architecture

## 👨‍💻 Autor
**Rama Marin Orozco**  
*Ingeniería en Datos*
