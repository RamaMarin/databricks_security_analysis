# Databricks notebook source
# /// script
# [tool.databricks.environment]
# environment_version = "5"
# ///
# MAGIC %sql
# MAGIC SELECT *
# MAGIC FROM yucatan_project.security_visualization.incidencias_municipales_silver
# MAGIC LIMIT 5;
