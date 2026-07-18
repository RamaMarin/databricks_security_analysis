-- ==========================================
-- JERARQUÍA DE GEOGRAFÍA
-- ==========================================
CREATE TABLE cat_estado (
    clave_ent INT NOT NULL,
    entidad VARCHAR(255) NOT NULL,
    PRIMARY KEY (clave_ent)
);

CREATE TABLE dim_geografia (
    id_geografia INT NOT NULL,
    cve_municipio INT NOT NULL,
    municipio VARCHAR(255) NOT NULL,
    clave_ent INT NOT NULL,
    PRIMARY KEY (id_geografia),
    FOREIGN KEY (clave_ent) REFERENCES cat_estado(clave_ent)
);

-- ==========================================
-- JERARQUÍA DE DELITO
-- ==========================================
CREATE TABLE cat_bien_juridico (
    id_bien INT NOT NULL,
    bien_juridico_afectado VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_bien)
);

CREATE TABLE cat_tipo_delito (
    id_tipo INT NOT NULL,
    id_bien INT NOT NULL,
    tipo_de_delito VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_tipo),
    FOREIGN KEY (id_bien) REFERENCES cat_bien_juridico(id_bien)
);

CREATE TABLE cat_subtipo_delito (
    id_subtipo INT NOT NULL,
    id_tipo INT NOT NULL,
    subtipo_de_delito VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_subtipo),
    FOREIGN KEY (id_tipo) REFERENCES cat_tipo_delito(id_tipo)
);

CREATE TABLE dim_modalidad_delito (
    id_modalidad INT NOT NULL,
    id_subtipo INT NOT NULL,
    modalidad VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_modalidad),
    FOREIGN KEY (id_subtipo) REFERENCES cat_subtipo_delito(id_subtipo)
);

-- ==========================================
-- JERARQUÍA DE TIEMPO
-- ==========================================
CREATE TABLE cat_mes (
    mes_numero INT NOT NULL,
    mes_nombre VARCHAR(20) NOT NULL,
    PRIMARY KEY (mes_numero)
);

CREATE TABLE dim_tiempo (
    id_tiempo INT NOT NULL,
    anio INT NOT NULL,
    mes_numero INT NOT NULL,
    PRIMARY KEY (id_tiempo),
    FOREIGN KEY (mes_numero) REFERENCES cat_mes(mes_numero)
);

-- ==========================================
-- TABLA DE HECHOS
-- ==========================================
CREATE TABLE fact_incidencias (
    id_incidencia INT NOT NULL,
    id_tiempo INT NOT NULL,
    id_geografia INT NOT NULL,
    id_modalidad INT NOT NULL,
    cantidad_delitos INT NOT NULL,
    PRIMARY KEY (id_incidencia),
    FOREIGN KEY (id_tiempo) REFERENCES dim_tiempo(id_tiempo),
    FOREIGN KEY (id_geografia) REFERENCES dim_geografia(id_geografia),
    FOREIGN KEY (id_modalidad) REFERENCES dim_modalidad_delito(id_modalidad)
);