-- ==========================================================================
-- 1. JERARQUÍA DE GEOGRAFÍA (3NF)
-- ==========================================================================

CREATE OR REFRESH MATERIALIZED VIEW cat_estado
COMMENT "Catálogo de entidades federativas (3NF)"
AS
SELECT DISTINCT
    clave_estado AS clave_ent,
    estado AS entidad
FROM yucatan_project.security_visualization.incidencias_municipales_silver;

CREATE OR REFRESH MATERIALIZED VIEW dim_geografia
COMMENT "Dimensión de geografía a nivel municipio (3NF)"
AS
SELECT DISTINCT
    (clave_estado * 1000) + clave_municipio AS id_geografia,
    clave_municipio AS cve_municipio,
    municipio,
    clave_estado AS clave_ent
FROM yucatan_project.security_visualization.incidencias_municipales_silver;


-- ==========================================================================
-- 2. JERARQUÍA DE DELITOS (3NF)
-- ==========================================================================

CREATE OR REFRESH MATERIALIZED VIEW cat_bien_juridico
COMMENT "Catálogo de bienes jurídicos afectados (3NF)"
AS
SELECT DISTINCT
    ABS(HASH(bien_juridico_afectado)) AS id_bien,
    bien_juridico_afectado
FROM yucatan_project.security_visualization.incidencias_municipales_silver;

CREATE OR REFRESH MATERIALIZED VIEW cat_tipo_delito
COMMENT "Catálogo de tipos de delito (3NF)"
AS
SELECT DISTINCT
    ABS(HASH(bien_juridico_afectado, tipo_de_delito)) AS id_tipo,
    ABS(HASH(bien_juridico_afectado)) AS id_bien,
    tipo_de_delito
FROM yucatan_project.security_visualization.incidencias_municipales_silver;

CREATE OR REFRESH MATERIALIZED VIEW cat_subtipo_delito
COMMENT "Catálogo de subtipos de delito (3NF)"
AS
SELECT DISTINCT
    ABS(HASH(bien_juridico_afectado, tipo_de_delito, subtipo_de_delito)) AS id_subtipo,
    ABS(HASH(bien_juridico_afectado, tipo_de_delito)) AS id_tipo,
    subtipo_de_delito
FROM yucatan_project.security_visualization.incidencias_municipales_silver;

CREATE OR REFRESH MATERIALIZED VIEW dim_modalidad_delito
COMMENT "Dimensión de modalidades de delito (3NF)"
AS
SELECT DISTINCT
    ABS(HASH(bien_juridico_afectado, tipo_de_delito, subtipo_de_delito, modalidad_del_delito)) AS id_modalidad,
    ABS(HASH(bien_juridico_afectado, tipo_de_delito, subtipo_de_delito)) AS id_subtipo,
    modalidad_del_delito AS modalidad
FROM yucatan_project.security_visualization.incidencias_municipales_silver;


-- ==========================================================================
-- 3. JERARQUÍA DE TIEMPO (3NF)
-- ==========================================================================

CREATE OR REFRESH MATERIALIZED VIEW cat_mes
COMMENT "Catálogo de meses del año (3NF)"
AS
SELECT explode(array(
    named_struct('mes_numero', 1, 'mes_nombre', 'enero'),
    named_struct('mes_numero', 2, 'mes_nombre', 'febrero'),
    named_struct('mes_numero', 3, 'mes_nombre', 'marzo'),
    named_struct('mes_numero', 4, 'mes_nombre', 'abril'),
    named_struct('mes_numero', 5, 'mes_nombre', 'mayo'),
    named_struct('mes_numero', 6, 'mes_nombre', 'junio'),
    named_struct('mes_numero', 7, 'mes_nombre', 'julio'),
    named_struct('mes_numero', 8, 'mes_nombre', 'agosto'),
    named_struct('mes_numero', 9, 'mes_nombre', 'septiembre'),
    named_struct('mes_numero', 10, 'mes_nombre', 'octubre'),
    named_struct('mes_numero', 11, 'mes_nombre', 'noviembre'),
    named_struct('mes_numero', 12, 'mes_nombre', 'diciembre')
)) AS mes;

CREATE OR REFRESH MATERIALIZED VIEW dim_tiempo
COMMENT "Dimensión de tiempo (3NF)"
AS
WITH anios AS (
    SELECT DISTINCT anio FROM yucatan_project.security_visualization.incidencias_municipales_silver
)
SELECT 
    CAST(CONCAT(CAST(a.anio AS STRING), LPAD(CAST(c.mes.mes_numero AS STRING), 2, '0')) AS INT) AS id_tiempo,
    a.anio,
    c.mes.mes_numero
FROM anios a
CROSS JOIN cat_mes c;


-- ==========================================================================
-- 4. TABLA DE HECHOS (AQUÍ SÍ USAS STREAMING)
-- ==========================================================================

CREATE OR REFRESH STREAMING TABLE fact_incidencias
COMMENT "Tabla de hechos de delitos. Modelo Copo de Nieve (3NF)."
AS
SELECT 
    CAST(
        CONCAT(CAST(anio AS STRING), 
        CASE mes_nombre 
            WHEN 'enero' THEN '01' WHEN 'febrero' THEN '02' WHEN 'marzo' THEN '03'
            WHEN 'abril' THEN '04' WHEN 'mayo' THEN '05' WHEN 'junio' THEN '06'
            WHEN 'julio' THEN '07' WHEN 'agosto' THEN '08' WHEN 'septiembre' THEN '09'
            WHEN 'octubre' THEN '10' WHEN 'noviembre' THEN '11' WHEN 'diciembre' THEN '12'
        END) 
    AS INT) AS id_tiempo,
    
    (clave_estado * 1000) + clave_municipio AS id_geografia,
    
    ABS(HASH(bien_juridico_afectado, tipo_de_delito, subtipo_de_delito, modalidad_del_delito)) AS id_modalidad,
    
    cantidad_delitos

-- Fíjate cómo esta es la ÚNICA tabla que lee de STREAM()
FROM STREAM(yucatan_project.security_visualization.incidencias_municipales_silver)
UNPIVOT (
    cantidad_delitos FOR mes_nombre IN (
        enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre
    )
)
WHERE cantidad_delitos > 0;
