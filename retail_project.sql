-- ============================================================
-- PROYECTO RETAIL - PRE-ENTREGA
-- PostgreSQL
-- ============================================================

-- ============================================================
-- DDL - CREACIÓN DE TABLAS
-- ============================================================

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    edad INTEGER NOT NULL,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT chk_clientes_edad
        CHECK (edad >= 18 AND edad <= 120)
);


CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT chk_productos_precio
        CHECK (precio > 0),

    CONSTRAINT chk_productos_stock
        CHECK (stock >= 0)
);


CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT fk_ventas_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto),

    CONSTRAINT chk_ventas_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_ventas_precio_unitario
        CHECK (precio_unitario > 0)
);


-- ============================================================
-- DML - CARGA INICIAL DE DATOS
-- ============================================================

BEGIN;

-- CLIENTES

INSERT INTO clientes
    (nombre, apellido, email, edad, fecha_registro)
VALUES
    ('Juan', 'Pérez', 'juan.perez@email.com', 28, '2026-09-01'),
    ('María', 'Gómez', 'maria.gomez@email.com', 35, '2026-09-02'),
    ('Carlos', 'Rodríguez', 'carlos.rodriguez@email.com', 42, '2026-09-03'),
    ('Laura', 'Fernández', 'laura.fernandez@email.com', 24, '2026-09-04'),
    ('Diego', 'Martínez', 'diego.martinez@email.com', 31, '2026-09-05');


-- PRODUCTOS

INSERT INTO productos
    (nombre, categoria, precio, stock)
VALUES
    ('Notebook Lenovo IdeaPad', 'Electrónica', 850000.00, 10),
    ('Mouse Logitech M185', 'Electrónica', 25000.00, 50),
    ('Teclado Redragon Kumara', 'Electrónica', 65000.00, 25),
    ('Silla de oficina', 'Muebles', 180000.00, 15),
    ('Escritorio de oficina', 'Muebles', 250000.00, 8);


-- VENTAS

INSERT INTO ventas
    (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
VALUES
    (1, 1, 1, 850000.00, '2026-09-10 10:30:00'),
    (2, 2, 2, 25000.00, '2026-09-11 11:15:00'),
    (3, 3, 1, 65000.00, '2026-09-12 14:20:00'),
    (4, 4, 1, 180000.00, '2026-09-13 16:45:00'),
    (5, 5, 1, 250000.00, '2026-09-14 09:10:00'),
    (1, 2, 1, 25000.00, '2026-09-15 12:00:00');

COMMIT;


-- ============================================================
-- UPDATE - AUMENTO DEL 10% EN PRODUCTOS ELECTRÓNICOS
-- ============================================================

-- SELECT PREVIO

SELECT id_producto, nombre, categoria, precio
FROM productos
WHERE categoria = 'Electrónica';

-- UPDATE

UPDATE productos
SET precio = ROUND(precio * 1.10, 2)
WHERE categoria = 'Electrónica';


-- ============================================================
-- DELETE - ELIMINACIÓN DE UNA VENTA DE PRUEBA
-- ============================================================

-- SELECT PREVIO

SELECT *
FROM ventas
WHERE id_venta = 6;

-- DELETE

DELETE FROM ventas
WHERE id_venta = 6;


-- ============================================================
-- CONSULTAS FINALES DE VERIFICACIÓN
-- ============================================================

SELECT * FROM clientes;

SELECT * FROM productos;

SELECT * FROM ventas;
