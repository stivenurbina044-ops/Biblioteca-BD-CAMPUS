-- =====================================================================
-- Biblioteca Campus - Modelo Físico de Base de Datos (MySQL)
-- =====================================================================
-- Autor: Examen - Biblioteca Campus
-- Descripción: Estructura de tablas, llaves primarias y foráneas
--              para el sistema de gestión de la Biblioteca Campus.
-- =====================================================================

DROP DATABASE IF EXISTS biblioteca_campus;
CREATE DATABASE biblioteca_campus
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE biblioteca_campus;

-- ---------------------------------------------------------------------
-- Tabla: autor
-- ---------------------------------------------------------------------
CREATE TABLE autor (
    id_autor      INT AUTO_INCREMENT PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    apellido      VARCHAR(100) NOT NULL,
    nacionalidad  VARCHAR(60)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: libro
-- ---------------------------------------------------------------------
CREATE TABLE libro (
    id_libro        INT AUTO_INCREMENT PRIMARY KEY,
    titulo          VARCHAR(200) NOT NULL,
    genero          VARCHAR(80),
    isbn            VARCHAR(20) NOT NULL UNIQUE,
    disponibilidad  BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: libro_autor (entidad intermedia N:M entre libro y autor)
-- ---------------------------------------------------------------------
CREATE TABLE libro_autor (
    id_libro  INT NOT NULL,
    id_autor  INT NOT NULL,
    PRIMARY KEY (id_libro, id_autor),
    CONSTRAINT fk_libroautor_libro
        FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_libroautor_autor
        FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: editorial
-- ---------------------------------------------------------------------
CREATE TABLE editorial (
    id_editorial  INT AUTO_INCREMENT PRIMARY KEY,
    nombre        VARCHAR(150) NOT NULL,
    pais          VARCHAR(60)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: publicacion (ediciones de un libro)
-- ---------------------------------------------------------------------
CREATE TABLE publicacion (
    id_publicacion     INT AUTO_INCREMENT PRIMARY KEY,
    id_libro           INT NOT NULL,
    id_editorial       INT NOT NULL,
    numero_edicion     INT NOT NULL,
    fecha_publicacion  DATE NOT NULL,
    CONSTRAINT fk_publicacion_libro
        FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_publicacion_editorial
        FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: miembro
-- ---------------------------------------------------------------------
CREATE TABLE miembro (
    id_miembro      INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    apellido        VARCHAR(100) NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    telefono        VARCHAR(20),
    fecha_registro  DATE NOT NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tabla: transaccion (préstamos y devoluciones)
-- ---------------------------------------------------------------------
CREATE TABLE transaccion (
    id_transaccion            INT AUTO_INCREMENT PRIMARY KEY,
    id_libro                  INT NOT NULL,
    id_miembro                INT NOT NULL,
    fecha_prestamo             DATE NOT NULL,
    fecha_devolucion_esperada  DATE NOT NULL,
    fecha_devolucion_real      DATE NULL,
    estado                     ENUM('prestado','devuelto','atrasado') NOT NULL DEFAULT 'prestado',
    CONSTRAINT fk_transaccion_libro
        FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_transaccion_miembro
        FOREIGN KEY (id_miembro) REFERENCES miembro(id_miembro)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Índices adicionales de apoyo a las consultas
-- ---------------------------------------------------------------------
CREATE INDEX idx_libro_genero ON libro(genero);
CREATE INDEX idx_libro_titulo ON libro(titulo);
CREATE INDEX idx_autor_nombre ON autor(nombre, apellido);
CREATE INDEX idx_miembro_nombre ON miembro(nombre, apellido);
CREATE INDEX idx_transaccion_estado ON transaccion(estado);