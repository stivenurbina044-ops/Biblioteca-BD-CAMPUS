# Biblioteca Campus - Consultas SQL

Listar todos los libros disponibles
```sql
SELECT id_libro, titulo, genero, isbn
FROM libro
WHERE disponibilidad = TRUE;
```

Buscar libros por género
```sql
SELECT id_libro, titulo, genero, isbn, disponibilidad
FROM libro
WHERE genero = 'Fantasía';
```

Obtener información de un libro por ISBN
```sql
SELECT *
FROM libro
WHERE isbn = '978-0439708180';
```

Contar el número de libros en la biblioteca
```sql
SELECT COUNT(*) AS total_libros
FROM libro;
```

Listar todos los autores
```sql
SELECT id_autor, nombre, apellido, nacionalidad
FROM autor;
```

Buscar autores por nombre
```sql
SELECT id_autor, nombre, apellido, nacionalidad
FROM autor
WHERE nombre LIKE '%Isabel%' OR apellido LIKE '%Isabel%';
```

Obtener todos los libros de un autor específico
```sql
SELECT l.id_libro, l.titulo, l.genero, l.isbn
FROM libro l
INNER JOIN libro_autor la ON l.id_libro = la.id_libro
INNER JOIN autor a ON la.id_autor = a.id_autor
WHERE a.id_autor = 1;
```

Listar todas las ediciones de un libro
```sql
SELECT p.id_publicacion, p.numero_edicion, p.fecha_publicacion, e.nombre AS editorial
FROM publicacion p
INNER JOIN editorial e ON p.id_editorial = e.id_editorial
WHERE p.id_libro = 1
ORDER BY p.numero_edicion;
```

Obtener la última edición de un libro
```sql
SELECT p.id_publicacion, p.numero_edicion, p.fecha_publicacion, e.nombre AS editorial
FROM publicacion p
INNER JOIN editorial e ON p.id_editorial = e.id_editorial
WHERE p.id_libro = 1
ORDER BY p.fecha_publicacion DESC
LIMIT 1;
```

Contar cuántas ediciones hay de un libro específico
```sql
SELECT id_libro, COUNT(*) AS numero_ediciones
FROM publicacion
WHERE id_libro = 1
GROUP BY id_libro;
```

Listar todas las transacciones de préstamo
```sql
SELECT id_transaccion, id_libro, id_miembro, fecha_prestamo,
       fecha_devolucion_esperada, fecha_devolucion_real, estado
FROM transaccion;
```

Obtener los libros prestados actualmente
```sql
SELECT t.id_transaccion, l.titulo, m.nombre, m.apellido,
       t.fecha_prestamo, t.fecha_devolucion_esperada
FROM transaccion t
INNER JOIN libro l ON t.id_libro = l.id_libro
INNER JOIN miembro m ON t.id_miembro = m.id_miembro
WHERE t.estado IN ('prestado', 'atrasado');
```

Contar el número de transacciones de un miembro específico
```sql
SELECT id_miembro, COUNT(*) AS total_transacciones
FROM transaccion
WHERE id_miembro = 1
GROUP BY id_miembro;
```

Listar todos los miembros de la biblioteca
```sql
SELECT id_miembro, nombre, apellido, email, telefono, fecha_registro
FROM miembro;
```

Buscar un miembro por nombre:
```sql
SELECT id_miembro, nombre, apellido, email, telefono
FROM miembro
WHERE nombre LIKE '%Laura%' OR apellido LIKE '%Laura%';
```

Obtener las transacciones de un miembro específico
```sql
SELECT t.id_transaccion, l.titulo, t.fecha_prestamo,
       t.fecha_devolucion_esperada, t.fecha_devolucion_real, t.estado
FROM transaccion t
INNER JOIN libro l ON t.id_libro = l.id_libro
WHERE t.id_miembro = 1;
```

Listar todos los libros y sus autores
```sql
SELECT l.titulo, a.nombre, a.apellido
FROM libro l
INNER JOIN libro_autor la ON l.id_libro = la.id_libro
INNER JOIN autor a ON la.id_autor = a.id_autor
ORDER BY l.titulo;
```

Obtener el historial de préstamos de un libro específico
```sql
SELECT t.id_transaccion, m.nombre, m.apellido,
       t.fecha_prestamo, t.fecha_devolucion_esperada, t.fecha_devolucion_real, t.estado
FROM transaccion t
INNER JOIN miembro m ON t.id_miembro = m.id_miembro
WHERE t.id_libro = 1
ORDER BY t.fecha_prestamo DESC;
```

Contar cuántos libros han sido prestados en total
```sql
SELECT COUNT(DISTINCT id_libro) AS libros_prestados_total
FROM transaccion;
```

Listar todos los libros junto con su última edición y estado de disponibilidad
```sql
SELECT l.id_libro, l.titulo, l.disponibilidad,
       p.numero_edicion AS ultima_edicion, p.fecha_publicacion
FROM libro l
LEFT JOIN publicacion p ON p.id_publicacion = (
    SELECT p2.id_publicacion
    FROM publicacion p2
    WHERE p2.id_libro = l.id_libro
    ORDER BY p2.fecha_publicacion DESC
    LIMIT 1
);
```