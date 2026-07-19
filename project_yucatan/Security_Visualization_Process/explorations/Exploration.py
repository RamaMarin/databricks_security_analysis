# Databricks notebook source
import os

raw_data_volume = '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/'

# COMMAND ----------

# MAGIC %fs ls '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/'

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT *
# MAGIC FROM read_files(
# MAGIC     '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/INM_estatal_dic25.csv',
# MAGIC     format => 'text'
# MAGIC )
# MAGIC LIMIT 10

# COMMAND ----------

# DBTITLE 1,Cell 4
display(spark.sql(f"""
SELECT *
FROM read_files(
    '{raw_data_volume}Incidencia delictiva municipal.csv',
    format => 'csv',
    header => true,
    encoding => 'ISO-8859-1'
    )
LIMIT 10
"""))

# COMMAND ----------

display(spark.sql(f"""
SELECT *
FROM read_files(
    '{raw_data_volume}Incidencia delictiva estatal.csv',
    format => 'csv',
    header => true,
    encoding => 'UTF-8'
    )
LIMIT 10
"""))

# COMMAND ----------

display(spark.sql(f"""
SELECT *
FROM read_files(
    '{raw_data_volume}INM_estatal_dic25.csv',
    format => 'csv',
    header => true,
    encoding => 'UTF-8'
    )
LIMIT 10
"""))

# COMMAND ----------

display(spark.sql(f"""
SELECT *
FROM read_files(
    '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/Víctimas del fuero común.csv',
    format => 'csv',
    header => true,
    encoding => 'ISO-8859-1'
    )
LIMIT 10
"""))

# COMMAND ----------

display(spark.sql(f"""
SELECT *
FROM read_files(
    '/Volumes/yucatan_project/security_visualization/security_volume/raw_data/data_pesca_ilegal.csv',
    format => 'csv',
    header => true,
    encoding => 'ISO-8859-1'
    )
LIMIT 10
"""))

# COMMAND ----------

csv_files = [
    "Incidencia delictiva municipal.csv",
    "Incidencia delictiva estatal.csv",
    "INM_estatal_dic25.csv",
    "Víctimas del fuero común.csv",
    "data_pesca_ilegal.csv"
]

column_names = {}

for file in csv_files:
    df = spark.read.format("csv") \
        .option("header", "true") \
        .option("encoding", "ISO-8859-1" if file in ["Incidencia delictiva municipal.csv", "Víctimas del fuero común.csv", "data_pesca_ilegal.csv"] else "UTF-8") \
        .load(f"/Volumes/yucatan_project/security_visualization/security_volume/raw_data/{file}")
    column_names[file] = df.columns

display(column_names)
