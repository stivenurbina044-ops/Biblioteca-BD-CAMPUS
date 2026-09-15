-- =====================================================================
-- Biblioteca Campus - Datos de ejemplo (INSERT)
-- =====================================================================
USE biblioteca_campus;

-- ---------------------------------------------------------------------
-- Autores
-- ---------------------------------------------------------------------
INSERT INTO autor (nombre, apellido, nacionalidad) VALUES
('Gabriel', 'García Márquez', 'Colombiana'),
('Isabel', 'Allende', 'Chilena'),
('Jorge Luis', 'Borges', 'Argentina'),
('J.K.', 'Rowling', 'Británica'),
('George', 'Orwell', 'Británica'),
('Mario', 'Vargas Llosa', 'Peruana');

-- ---------------------------------------------------------------------
-- Libros
-- ---------------------------------------------------------------------
INSERT INTO libro (titulo, genero, isbn, disponibilidad) VALUES
('Cien años de soledad', 'Realismo mágico', '978-0307474728', TRUE),
('La casa de los espíritus', 'Realismo mágico', '978-0307387074', TRUE),
('Ficciones', 'Ficción', '978-0307950899', FALSE),
('Harry Potter y la piedra filosofal', 'Fantasía', '978-0439708180', TRUE),
('1984', 'Distopía', '978-0451524935', FALSE),
('La ciudad y los perros', 'Novela', '978-8420471839', TRUE);

-- ---------------------------------------------------------------------
-- Relación Libro - Autor (N:M)
-- ---------------------------------------------------------------------
INSERT INTO libro_autor (id_libro, id_autor) VALUES
(1, 1), -- Cien años de soledad - García Márquez
(2, 2), -- La casa de los espíritus - Allende
(3, 3), -- Ficciones - Borges
(4, 4), -- Harry Potter - Rowling
(5, 5), -- 1984 - Orwell
(6, 6); -- La ciudad y los perros - Vargas Llosa

-- ---------------------------------------------------------------------
-- Editoriales
-- ---------------------------------------------------------------------
INSERT INTO editorial (nombre, pais) VALUES
('Editorial Sudamericana', 'Argentina'),
('Penguin Random House', 'Estados Unidos'),
('Bloomsbury Publishing', 'Reino Unido'),
('Secker & Warburg', 'Reino Unido'),
('Seix Barral', 'España');

-- ---------------------------------------------------------------------
-- Publicaciones (ediciones)
-- ---------------------------------------------------------------------
INSERT INTO publicacion (id_libro, id_editorial, numero_edicion, fecha_publicacion) VALUES
(1, 1, 1, '1967-05-30'),
(1, 2, 2, '2007-03-01'),
(2, 2, 1, '1982-01-01'),
(3, 1, 1, '1944-01-01'),
(4, 3, 1, '1997-06-26'),
(4, 3, 2, '2004-09-01'),
(5, 4, 1, '1949-06-08'),
(6, 5, 1, '1963-01-01');

-- ---------------------------------------------------------------------
-- Miembros
-- ---------------------------------------------------------------------
INSERT INTO miembro (nombre, apellido, email, telefono, fecha_registro) VALUES
('Camila', 'Rodríguez', 'camila.rodriguez@correo.com', '3001112233', '2023-02-10'),
('Andrés', 'Gómez', 'andres.gomez@correo.com', '3002223344', '2023-05-18'),
('Laura', 'Martínez', 'laura.martinez@correo.com', '3003334455', '2024-01-09'),
('Santiago', 'Pérez', 'santiago.perez@correo.com', '3004445566', '2024-06-22'),
('Valentina', 'Torres', 'valentina.torres@correo.com', '3005556677', '2025-03-15');

-- ---------------------------------------------------------------------
-- Transacciones (préstamos y devoluciones)
-- ---------------------------------------------------------------------
INSERT INTO transaccion (id_libro, id_miembro, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, estado) VALUES
(1, 1, '2025-08-01', '2025-08-15', '2025-08-14', 'devuelto'),
(3, 2, '2025-08-20', '2025-09-03', NULL, 'prestado'),
(5, 3, '2025-08-25', '2025-09-08', NULL, 'atrasado'),
(2, 4, '2025-09-01', '2025-09-15', '2025-09-10', 'devuelto'),
(4, 5, '2025-09-05', '2025-09-19', NULL, 'prestado'),
(6, 1, '2025-07-10', '2025-07-24', '2025-07-23', 'devuelto'),
(1, 3, '2025-09-10', '2025-09-24', NULL, 'prestado');