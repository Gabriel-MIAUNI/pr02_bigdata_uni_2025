-- 1. Seleccionar la base de datos 'order_management_data'
USE order_management_data;

-- 2. Actualizar el estado del pedido en la tabla 'orders_by_id' a 'canceled'
-- Solo se actualizar� si el estado actual del pedido es 'pending'.
-- La condici�n 'IF order_status = 'pending'' asegura que solo se modifique si el pedido tiene el estado 'pending'.
UPDATE orders_by_id 
SET order_status = 'canceled'  -- Cambia el estado del pedido a 'canceled'.
WHERE order_id = '113-3827060-8722206'  -- Filtra por el 'order_id' espec�fico.
IF order_status = 'pending';  -- Solo actualiza si el estado actual es 'pending'.

-- 3. Actualizar el estado del pedido en la tabla 'orders_by_user' a 'canceled'
-- Filtra por el 'order_id', 'user_id' y 'order_timestamp' para asegurarse de que se actualice el registro correcto.
UPDATE orders_by_user 
SET order_status = 'canceled'  -- Cambia el estado del pedido a 'canceled'.
WHERE order_id = '113-3827060-8722206'  -- Filtra por el 'order_id'.
  AND user_id = 'joe'  -- Filtra por el 'user_id' de 'joe'.
  AND order_timestamp = '2020-11-17 222043';  -- Filtra por la fecha exacta del pedido.

-- 4. Insertar un nuevo registro en la tabla 'order_status_history_by_id'
-- Inserta un nuevo estado 'canceled' en el historial de estados del pedido con la fecha y hora actual (utilizando NOW()).
INSERT INTO order_status_history_by_id (order_id, status_timestamp, order_status)
VALUES ('113-3827060-8722206', TOTIMESTAMP(NOW()), 'canceled');  -- Inserta el estado 'canceled' con la hora actual.

-- 5. Consultar el estado del pedido en la tabla 'orders_by_id'
-- Se selecciona el estado del pedido con 'order_id' espec�fico para verificar si la actualizaci�n fue exitosa.
SELECT order_status
FROM orders_by_id
WHERE order_id = '113-3827060-8722206';  -- Filtra por el 'order_id'.

-- 6. Consultar el estado del pedido en la tabla 'orders_by_user'
-- Se selecciona el estado del pedido para el usuario 'joe' en una fecha y hora espec�fica para verificar si la actualizaci�n fue exitosa.
SELECT order_status
FROM orders_by_user
WHERE order_id = '113-3827060-8722206'  -- Filtra por el 'order_id'.
  AND user_id = 'joe'  -- Filtra por el 'user_id' de 'joe'.
  AND order_timestamp = '2020-11-17 222043';  -- Filtra por la fecha exacta del pedido.

-- 7. Consultar el estado m�s reciente del historial de estados en la tabla 'order_status_history_by_id'
-- Se selecciona el estado m�s reciente para el pedido espec�fico. 'LIMIT 1' asegura que solo se recupere el �ltimo estado registrado.
SELECT order_status
FROM order_status_history_by_id
WHERE order_id = '113-3827060-8722206'
LIMIT 1;  -- Limita la consulta al �ltimo registro de estado.
