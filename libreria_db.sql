--M5-AE4-ABPRO-Ejercicio grupal--
--Integrantes:
--Alicia Contreras
--Johana Torres

--1.Crear la base de datos
DROP DATABASE libreria_db;
CREATE DATABASE IF NOT EXISTS libreria_db;
USE libreria_db;

--2.Definir y crear las tablas con los siguientes campos:
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(100) NOT NULL,
    correo_cliente VARCHAR(100) NOT NULL,
    telefono_cliente VARCHAR(15) NOT NULL,
    direccion_cliente VARCHAR(255) NOT NULL
);

CREATE TABLE Libros (
    id_libro INT PRIMARY KEY AUTO_INCREMENT,
    titulo_libro VARCHAR(255) NOT NULL,
    autor_libro VARCHAR(100) NOT NULL,
    precio_libro DECIMAL(10, 2) NOT NULL,
    cantidad_disponible INT NOT NULL,
    categoria_libro VARCHAR(50) NOT NULL
);

CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    total_pedido DECIMAL(10, 2) NOT NULL,
    estado_pedido VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Detalles_Pedido (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_libro INT NOT NULL,
    cantidad_libro INT NOT NULL,
    precio_libro DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);

CREATE TABLE Pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto_pago DECIMAL(10, 2) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

--Datos para probar
INSERT INTO Clientes (nombre_cliente, correo_cliente, telefono_cliente, direccion_cliente) VALUES
('Ana Torres', 'ana.torres@email.com', '5551234567', 'Calle Falsa 123, Ciudad Capital'),
('Carlos Ruiz', 'carlos.ruiz@email.com', '5558765432', 'Avenida Siempre Viva 742, Metrópolis'),
('Luisa Pardo', 'luisa.pardo@email.com', '5559876543', 'Plaza Mayor 45, Pueblo Grande');

INSERT INTO Libros (titulo_libro, autor_libro, precio_libro, cantidad_disponible, categoria_libro) VALUES
('Cien Años de Soledad', 'Gabriel García Márquez', 22.50, 15, 'Ficción'),
('El Señor de los Anillos', 'J.R.R. Tolkien', 35.00, 10, 'Fantasía'),
('Sapiens: De animales a dioses', 'Yuval Noah Harari', 25.75, 20, 'No Ficción'),
('Duna', 'Frank Herbert', 19.99, 12, 'Ciencia Ficción'),
('Orgullo y Prejuicio', 'Jane Austen', 15.20, 18, 'Clásico');

INSERT INTO Pedidos (id_cliente, fecha_pedido, total_pedido, estado_pedido) VALUES
(1, '2025-08-10', 0.00, 'Entregado'),
(2, '2025-08-11', 0.00, 'Enviado'),  
(1, '2025-08-12', 0.00, 'Procesando'); 

INSERT INTO Detalles_Pedido (id_pedido, id_libro, cantidad_libro, precio_libro) VALUES
(1, 1, 1, 22.50), 
(1, 3, 1, 25.75); 

INSERT INTO Detalles_Pedido (id_pedido, id_libro, cantidad_libro, precio_libro) VALUES
(2, 2, 2, 35.00);  

INSERT INTO Detalles_Pedido (id_pedido, id_libro, cantidad_libro, precio_libro) VALUES
(3, 4, 1, 19.99), 
(3, 5, 1, 15.20); 

UPDATE Pedidos p
SET p.total_pedido = (
    SELECT SUM(dp.cantidad_libro * dp.precio_libro)
    FROM Detalles_Pedido dp
    WHERE dp.id_pedido = p.id_pedido
)
WHERE p.id_pedido IN (1, 2, 3);

INSERT INTO Pagos (id_pedido, fecha_pago, monto_pago, metodo_pago) VALUES
(1, '2025-08-10', 48.25, 'Tarjeta de Crédito'), 
(2, '2025-08-11', 70.00, 'PayPal');    


--3.Restricciones y reglas a seguir
ALTER TABLE Clientes
MODIFY COLUMN telefono_cliente INT(10) NOT NULL;

ALTER TABLE Libros
MODIFY COLUMN cantidad_disponible INT NOT NULL CHECK (cantidad_disponible >=0);

ALTER TABLE clientes
MODIFY COLUMN correo_cliente VARCHAR (255) NOT NULL UNIQUE;


--4.Modificaciones a realizar en la base de datos:
ALTER TABLE clientes
MODIFY COLUMN telefono_cliente VARCHAR(20) NOT NULL;

ALTER TABLE libros
MODIFY COLUMN precio_libro DECIMAL(10,3) NOT NULL CHECK (precio_libro > 0);

ALTER TABLE pagos
ADD COLUMN fecha_confirmacion DATE NOT NULL;


--4. Eliminar la tabla Detalles_Pedido y sus registros cuando se haya confirmado la entrega de todos los libros de un pedido.
DELIMITER $$
DROP PROCEDURE IF EXISTS eliminar_tabla_detalles_pedido $$
CREATE PROCEDURE eliminar_tabla_pedido(IN p_estado_pedido VARCHAR(50))
proc: BEGIN

  START TRANSACTION;

  IF p_estado_pedido != 'Entregado' THEN
    ROLLBACK; SELECT 'ERROR: No todos los pedidos están entregados' AS estado; LEAVE proc;
  END IF;

    DROP TABLE IF EXISTS Detalles_Pedido;
    COMMIT; SELECT 'OK: Tabla Detalles_Pedido eliminada' AS estado;
END $$
DELIMITER ;
CALL eliminar_tabla_detalles_pedido('Entregado');


--5.Eliminar una tabla
DROP TABLE pagos;


--6.Truncar una tabla
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Pedidos;
SET FOREIGN_KEY_CHECKS = 1;


