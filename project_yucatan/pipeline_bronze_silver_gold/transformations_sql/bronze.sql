-- ==========================================================================
-- == Incrementally load RAW 'Incidencia delictiva estatal.csv'                               ==
-- ==========================================================================
CREATE OR REFRESH STREAMING TABLE incidencia_delictiva_estatal_bronze
COMMENT "Raw data from 'Incidencia delictiva estatal.csv'"
TBLPROPERTIES ( --TBLPROPERTIES to support special characters in column names
  'delta.columnMapping.mode' = 'name',
  'delta.minReaderVersion' = '2',
  'delta.minWriterVersion' = '5'
)
AS
SELECT 
    *,
    _metadata.file_modification_time AS file_modification_time,
    _metadata.file_path AS file_path,
    _metadata.file_name AS source_file,
    current_timestamp() AS ingestion_time
FROM STREAM(read_files(
    '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/',
    format => 'csv',
    header => true,
    inferSchema => true,
    encoding => 'ISO-8859-1',
    pathGlobFilter => 'Incidencia delictiva estatal.csv'
    ));



-- ==========================================================================
-- == Incrementally load RAW 'Incidencia delictiva municipal.csv'                               ==
-- ==========================================================================
CREATE OR REFRESH STREAMING TABLE incidencia_delictiva_municipal_bronze
COMMENT "Raw data from 'Incidencia delictiva municipal.csv'"
TBLPROPERTIES ( --TBLPROPERTIES to support special characters in column names
  'delta.columnMapping.mode' = 'name',
  'delta.minReaderVersion' = '2',
  'delta.minWriterVersion' = '5'
)
AS
SELECT
    *,
    _metadata.file_modification_time AS file_modification_time,
    _metadata.file_path AS file_path,
    _metadata.file_name AS source_file,
    current_timestamp() AS ingestion_time
FROM STREAM(read_files(
    '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/',
    format => 'csv',
    header => true,
    inferSchema => true,
    encoding => 'ISO-8859-1',
    pathGlobFilter => 'Incidencia delictiva municipal.csv'
    ));



-- ==========================================================================
-- == Incrementally load RAW 'Victimas del fuero comun.csv'                               ==
-- ==========================================================================
CREATE OR REFRESH STREAMING TABLE victimas_fuero_comun_bronze
COMMENT "Raw data from 'Victimas del fuero comun.csv'"
TBLPROPERTIES ( --TBLPROPERTIES to support special characters in column names
  'delta.columnMapping.mode' = 'name',
  'delta.minReaderVersion' = '2',
  'delta.minWriterVersion' = '5'
)
AS
SELECT
    *,
    _metadata.file_modification_time AS file_modification_time,
    _metadata.file_path AS file_path,
    _metadata.file_name AS source_file,
    current_timestamp() AS ingestion_time
FROM STREAM(read_files(
    '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/',
    format => 'csv',
    header => true,
    inferSchema => true,
    encoding => 'ISO-8859-1',
    pathGlobFilter => 'Víctimas del fuero común.csv'
    ));



-- ==========================================================================
-- == Incrementally load RAW 'data_pesca_ilegal.csv'                               ==
-- ==========================================================================
CREATE OR REFRESH STREAMING TABLE incidencias_pesca_ilegal_bronze
COMMENT "Raw data from 'data_pesca_ilegal.csv'"
TBLPROPERTIES ( --TBLPROPERTIES to support special characters in column names
  'delta.columnMapping.mode' = 'name',
  'delta.minReaderVersion' = '2',
  'delta.minWriterVersion' = '5'
)
AS
SELECT
    *,
    _metadata.file_modification_time AS file_modification_time,
    _metadata.file_path AS file_path,
    _metadata.file_name AS source_file,
    current_timestamp() AS ingestion_time
FROM STREAM(read_files(
    '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/',
    format => 'csv',
    header => true,
    inferSchema => true,
    encoding => 'ISO-8859-1',
    pathGlobFilter => 'data_pesca_ilegal.csv'
    ));



-- ==========================================================================
-- == Incrementally load RAW 'INM_estatal_dic25.csv'                               ==
-- ==========================================================================
CREATE OR REFRESH STREAMING TABLE incidencias_estatal_conglomerado_bronze
COMMENT "Raw data from 'INM_estatal_dic25.csv'"
TBLPROPERTIES ( --TBLPROPERTIES to support special characters in column names
  'delta.columnMapping.mode' = 'name',
  'delta.minReaderVersion' = '2',
  'delta.minWriterVersion' = '5'
)
AS
SELECT
    *,
    _metadata.file_modification_time AS file_modification_time,
    _metadata.file_path AS file_path,
    _metadata.file_name AS source_file,
    current_timestamp() AS ingestion_time
FROM STREAM(read_files(
    '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/',
    format => 'csv',
    header => true,
    inferSchema => true,
    encoding => 'ISO-8859-1',
    pathGlobFilter => 'INM_estatal_dic25.csv'
    ));