Contexto

El emprendimiento "Librería en Línea" es una tienda de libros que opera en línea y permite a los clientes comprar libros a través de su página web. La librería ha crecido rápidamente y necesitan una base de datos para gestionar su inventario de libros, los datos de los clientes, los pedidos realizados y los pagos. La base de datos debe ser capaz de registrar las operaciones de compra, gestionar la disponibilidad de libros y llevar un control de las transacciones. Además, deben asegurarse de que la base de datos sea eficiente y mantenga la integridad de los datos.

Objetivo de la actividad

El objetivo de la actividad es que el equipo cree una base de datos utilizando DDL para gestionar toda la información de la librería. Deberán definir correctamente las tablas, los campos, las llaves primarias y foráneas, además de aplicar las restricciones necesarias y realizar modificaciones en la estructura de la base de datos.

Instrucciones

Crear la base de datos
El equipo debe crear una base de datos llamada libreria_db.

Definir y crear las tablas con los siguientes campos:

Clientes

id_cliente (INT, clave primaria, autoincremental)

nombre_cliente (VARCHAR(100), no nulo)

correo_cliente (VARCHAR(100), no nulo)

telefono_cliente (VARCHAR(15), no nulo)

direccion_cliente (VARCHAR(255), no nulo)

Libros

id_libro (INT, clave primaria, autoincremental)

titulo_libro (VARCHAR(255), no nulo)

autor_libro (VARCHAR(100), no nulo)

precio_libro (DECIMAL(10,2), no nulo)

cantidad_disponible (INT, no nulo)

categoria_libro (VARCHAR(50), no nulo)

Pedidos

id_pedido (INT, clave primaria, autoincremental)

id_cliente (INT, clave foránea que referencia a Clientes)

fecha_pedido (DATE, no nulo)

total_pedido (DECIMAL(10,2), no nulo)

estado_pedido (VARCHAR(50), no nulo)

Detalles_Pedido

id_detalle (INT, clave primaria, autoincremental)

id_pedido (INT, clave foránea que referencia a Pedidos)

id_libro (INT, clave foránea que referencia a Libros)

cantidad_libro (INT, no nulo)

precio_libro (DECIMAL(10,2), no nulo)

Pagos

id_pago (INT, clave primaria, autoincremental)

id_pedido (INT, clave foránea que referencia a Pedidos)

fecha_pago (DATE, no nulo)

monto_pago (DECIMAL(10,2), no nulo)

metodo_pago (VARCHAR(50), no nulo)

Restricciones y reglas a seguir:

El campo telefono_cliente debe permitir solo valores numéricos de 10 dígitos.

El campo correo_cliente debe ser único y no puede ser nulo.

El campo cantidad_disponible en la tabla Libros no puede ser negativo.

Los campos id_pedido, id_cliente y id_libro deben ser obligatorios.

Cada pedido debe estar asociado a un solo cliente y cada detalle de pedido debe referirse a un solo libro.

Modificaciones a realizar en la base de datos:

Cambiar el tipo de dato de telefono_cliente a VARCHAR(20) para permitir más flexibilidad en la entrada de números internacionales.

Modificar el campo precio_libro en Libros para que acepte un valor con hasta 3 decimales (decimales(10,3)) en lugar de dos.

Actualizar la tabla Pagos para incluir un nuevo campo fecha_confirmacion que registre cuándo se confirma el pago.

Eliminar la tabla Detalles_Pedido y sus registros cuando se haya confirmado la entrega de todos los libros de un pedido.

Eliminar una tabla
Después de realizar los cambios en la estructura de la base de datos, eliminar la tabla Pagos.

Truncar una tabla
Truncar la tabla Pedidos para eliminar todos los registros de pedidos. Asegurarse de que esto no afecte la integridad referencial.
