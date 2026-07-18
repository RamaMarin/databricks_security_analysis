-- ==========================================================================
-- == STREAMING TABLE: incidencias_municipales_silver                      ==
-- ==========================================================================

CREATE OR REPLACE STREAMING TABLE incidencias_municipales_silver (
    anio INT COMMENT "Year of the record",
    clave_estado INT COMMENT "State code",
    estado STRING COMMENT "State name",
    clave_municipio INT COMMENT "Municipality code",
    municipio STRING COMMENT "Municipality name",
    bien_juridico_afectado STRING COMMENT "Affected legal good",
    tipo_de_delito STRING COMMENT "Type of crime",
    subtipo_de_delito STRING COMMENT "Subtype of crime",
    modalidad_del_delito STRING COMMENT "Modality of crime",
    enero INT COMMENT "Number of crimes in January",
    febrero INT COMMENT "Number of crimes in February",
    marzo INT COMMENT "Number of crimes in March",
    abril INT COMMENT "Number of crimes in April",
    mayo INT COMMENT "Number of crimes in May",
    junio INT COMMENT "Number of crimes in June",
    julio INT COMMENT "Number of crimes in July",
    agosto INT COMMENT "Number of crimes in August",
    septiembre INT COMMENT "Number of crimes in September",
    octubre INT COMMENT "Number of crimes in October",
    noviembre INT COMMENT "Number of crimes in November",
    diciembre INT COMMENT "Number of crimes in December"
)
COMMENT "Table with the number of crimes committed in each municipality of Mexico"
AS
SELECT 
    CAST(`Año` AS INT) AS anio,
    CAST(Clave_Ent AS INT) AS clave_estado,
    Entidad AS estado,
    CAST(`Cve. Municipio` AS INT) AS clave_municipio,
    Municipio AS municipio,
    `Bien jurídico afectado` AS bien_juridico_afectado,
    `Tipo de delito` AS tipo_de_delito,
    `Subtipo de delito` AS subtipo_de_delito,
    `Modalidad` AS modalidad_del_delito,
    CAST(Enero AS INT) AS enero,
    CAST(Febrero AS INT) AS febrero,
    CAST(Marzo AS INT) AS marzo,
    CAST(Abril AS INT) AS abril,
    CAST(Mayo AS INT) AS mayo,
    CAST(Junio AS INT) AS junio,
    CAST(Julio AS INT) AS julio,
    CAST(Agosto AS INT) AS agosto,
    CAST(Septiembre AS INT) AS septiembre,
    CAST(Octubre AS INT) AS octubre,
    CAST(Noviembre AS INT) AS noviembre,
    CAST(Diciembre AS INT) AS diciembre
FROM STREAM (yucatan_project.security_visualization.incidencia_delictiva_municipal_bronze);
--