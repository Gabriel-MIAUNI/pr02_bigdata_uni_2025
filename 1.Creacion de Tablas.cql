-- 1. Crear el Keyspace con SimpleStrategy (para un solo nodo)
-- El keyspace es el contenedor de las tablas en Cassandra. En este caso, se utiliza 'SimpleStrategy' 
-- para la replicación con un solo nodo (replication_factor = 1). 'IF NOT EXISTS' asegura que no se 
-- cree nuevamente si ya existe un keyspace con el mismo nombre.
CREATE KEYSPACE IF NOT EXISTS order_management_data 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Seleccionar el keyspace para que las operaciones siguientes ocurran dentro de él
USE order_management_data;

-- 2. Crear la tabla 'orders_by_user'
-- Esta tabla almacena los pedidos por usuario. Se establece un PRIMARY KEY compuesto por 'user_id',
-- 'order_timestamp' y 'order_id', lo que permite una partición por usuario y un orden de los pedidos
-- por timestamp y ID de pedido en orden descendente.
CREATE TABLE IF NOT EXISTS orders_by_user (
  user_id TEXT,                         -- ID del usuario
  order_timestamp TIMESTAMP,            -- Fecha y hora del pedido
  order_id TEXT,                        -- ID del pedido
  order_status TEXT,                    -- Estado del pedido
  order_total DECIMAL,                  -- Total del pedido
  PRIMARY KEY ((user_id),order_timestamp,order_id) -- Clave primaria para particionar por usuario
) WITH CLUSTERING ORDER BY (order_timestamp DESC, order_id ASC); -- Ordenar por timestamp y order_id

-- 3. Crear la tabla 'orders_by_id'
-- Esta tabla almacena información detallada de un pedido por ID. Se utilizan columnas STATIC para almacenar
-- valores que no cambian entre los ítems del pedido (como el estado, el timestamp, y el total).
CREATE TABLE IF NOT EXISTS orders_by_id (
  order_id TEXT,                        -- ID del pedido
  item_name TEXT,                       -- Nombre del ítem
  item_id TEXT,                         -- ID del ítem
  item_description TEXT,                -- Descripción del ítem
  item_price DECIMAL,                   -- Precio del ítem
  item_quantity INT,                    -- Cantidad de ítems
  order_status TEXT STATIC,             -- Estado del pedido (STATIC: valor compartido por todos los ítems)
  order_timestamp TIMESTAMP STATIC,     -- Timestamp del pedido (STATIC)
  order_subtotal DECIMAL STATIC,        -- Subtotal del pedido (STATIC)
  order_shipping DECIMAL STATIC,        -- Costo de envío (STATIC)
  order_tax DECIMAL STATIC,             -- Impuestos del pedido (STATIC)
  order_total DECIMAL STATIC,           -- Total del pedido (STATIC)
  payment_summary TEXT STATIC,          -- Resumen del pago (STATIC)
  payment_details MAP<TEXT,TEXT> STATIC, -- Detalles del pago (STATIC)
  billing_summary TEXT STATIC,          -- Resumen de la facturación (STATIC)
  billing_details MAP<TEXT,TEXT> STATIC, -- Detalles de la facturación (STATIC)
  shipping_summary TEXT STATIC,         -- Resumen de envío (STATIC)
  shipping_details MAP<TEXT,TEXT> STATIC, -- Detalles del envío (STATIC)
  delivery_id TEXT STATIC,              -- ID de entrega (STATIC)
  delivery_details MAP<TEXT,TEXT> STATIC, -- Detalles de entrega (STATIC)
  PRIMARY KEY ((order_id),item_name,item_id) -- Clave primaria para particionar por order_id
);

-- 4. Crear la tabla 'orders_by_user_item'
-- Esta tabla almacena información de los ítems de los pedidos, vinculando a los usuarios y los ítems
-- mediante una clave primaria compuesta. El orden de los pedidos dentro de cada usuario se hace por 
-- 'order_timestamp' y 'order_id'.
CREATE TABLE IF NOT EXISTS orders_by_user_item (
  user_id TEXT,                         -- ID del usuario
  item_id TEXT,                         -- ID del ítem
  order_timestamp TIMESTAMP,            -- Fecha y hora del pedido
  order_id TEXT,                        -- ID del pedido
  PRIMARY KEY ((user_id,item_id),order_timestamp,order_id) -- Clave primaria para particionar por user_id y item_id
) WITH CLUSTERING ORDER BY (order_timestamp DESC, order_id ASC); -- Ordenar por timestamp y order_id

-- 5. Crear la tabla 'order_status_history_by_id'
-- Esta tabla registra el historial de cambios de estado de un pedido. La clave primaria incluye el 'order_id'
-- y 'status_timestamp' para almacenar el historial de estados a lo largo del tiempo.
CREATE TABLE IF NOT EXISTS order_status_history_by_id (
  order_id TEXT,                        -- ID del pedido
  status_timestamp TIMESTAMP,           -- Timestamp del cambio de estado
  order_status TEXT,                    -- Estado del pedido
  PRIMARY KEY ((order_id),status_timestamp) -- Clave primaria para particionar por order_id
) WITH CLUSTERING ORDER BY (status_timestamp DESC); -- Ordenar por status_timestamp

-- 6. Ver las tablas del keyspace actual
-- El comando 'DESCRIBE TABLES' muestra todas las tablas presentes en el keyspace actualmente seleccionado.
DESCRIBE TABLES;
