-- Crear el Keyspace 'order_management_data' con la estrategia de replicaci�n 'SimpleStrategy'.
-- 'SimpleStrategy' se usa cuando se tiene un solo nodo o no se necesita configuraciones avanzadas de replicaci�n.
-- Aqu� se especifica un factor de replicaci�n de 1 para un solo nodo.
CREATE KEYSPACE order_management_data
WITH replication = {
  'class': 'SimpleStrategy',  -- Usamos 'SimpleStrategy' ya que es adecuado para entornos con un solo nodo.
  'replication_factor': 1     -- Establecemos el factor de replicaci�n a 1 para tener una r�plica en el nodo �nico.
};

-- Seleccionar el keyspace creado para que las siguientes operaciones ocurran dentro de �l.
USE order_management_data;

-- Insertar datos en la tabla 'orders_by_user':
-- Esta tabla almacena informaci�n de los pedidos agrupados por 'user_id'.
-- Los valores insertados incluyen 'user_id', 'order_timestamp', 'order_id', 'order_status' y 'order_total'.
---------------------------------------------
INSERT INTO orders_by_user (user_id, order_timestamp, order_id, order_status, order_total)
VALUES ('joe','2020-11-17 22:20:43','113-3827060-8722206','pending',40.99); -- Pedido de 'joe' con estado 'pending'.
INSERT INTO orders_by_user (user_id, order_timestamp, order_id, order_status, order_total)
VALUES ('joe','2020-10-22 10:00:28','111-0461064-1669732','delivered',63.99); -- Pedido de 'joe' con estado 'delivered'.
INSERT INTO orders_by_user (user_id, order_timestamp, order_id, order_status, order_total)
VALUES ('joe','2020-06-11 15:22:51','109-3421477-1773057','delivered',55.99); -- Pedido de 'joe' con estado 'delivered'.
INSERT INTO orders_by_user (user_id, order_timestamp, order_id, order_status, order_total)
VALUES ('joe','2019-12-01 08:37:55','104-8435452-3642550','canceled',34.99); -- Pedido de 'joe' con estado 'canceled'.
INSERT INTO orders_by_user (user_id, order_timestamp, order_id, order_status, order_total)
VALUES ('jen','2020-01-01 09:45:00','111-6227115-9100432','delivered',30.99); -- Pedido de 'jen' con estado 'delivered'.

-- Insertar datos en la tabla 'orders_by_id':
-- Esta tabla almacena informaci�n detallada de los �tems en cada pedido, identificados por 'order_id'.
-- Se insertan productos con sus descripciones, precios y cantidades.
---------------------------------------------
INSERT INTO orders_by_id (order_id, item_name, item_id, item_description, item_price, item_quantity)
VALUES ('113-3827060-8722206','Almonds','n-0012','Almonds, 1lb',7.00,2); -- �tem 'Almonds' con cantidad 2.
INSERT INTO orders_by_id (order_id, item_name, item_id, item_description, item_price, item_quantity)
VALUES ('113-3827060-8722206','Hazelnuts','n-0005','Hazelnuts, 1lb',12.00,1); -- �tem 'Hazelnuts' con cantidad 1.
INSERT INTO orders_by_id (order_id, item_name, item_id, item_description, item_price, item_quantity)
VALUES ('113-3827060-8722206','Pecans','n-0023','Pecans, 1lb',10.00,1); -- �tem 'Pecans' con cantidad 1.

-- Insertar informaci�n del pedido '113-3827060-8722206' con un resumen de la orden:
-- Incluye detalles del pago, facturaci�n, env�o, y datos de entrega.
INSERT INTO orders_by_id (order_id, order_status, order_timestamp, order_subtotal, order_shipping, order_tax, order_total, payment_summary, payment_details, billing_summary, billing_details, shipping_summary, shipping_details, delivery_id, delivery_details)
VALUES ('113-3827060-8722206','pending','2020-11-17 22:20:43',36.00,4.99,0.00,40.99,'Visa ending 1234',{'card number':'4321-0000-0000-1234','exp date':'10/24'},'111 Main St, Austin, TX',{'street':'101 Main St','city':'Austin','state':'TX'},'999 Ala Moana Blvd, Honolulu, HI',{'street':'999 Ala Moana Blvd','city':'Honolulu','state':'HI'},'fedex-2',{'service':'FedEx 2Day'});

-- Insertar m�s datos para otros pedidos (ejemplo con otro 'order_id'):

INSERT INTO orders_by_id (order_id, item_name, item_id, item_description, item_price, item_quantity)
VALUES ('111-0461064-1669732','Almonds','n-0012','Almonds, 1lb',7.00,1);
INSERT INTO orders_by_id (order_id, item_name, item_id, item_description, item_price, item_quantity)
VALUES ('111-0461064-1669732','Pine nuts','n-0024','Pine nuts, 1lb',21.00,1);
INSERT INTO orders_by_id (order_id, item_name, item_id, item_description, item_price, item_quantity)
VALUES ('111-0461064-1669732','Pecans','n-0023','Pecans, 1lb',10.00,3);

-- Insertar la informaci�n del pedido '111-0461064-1669732' con el resumen de la orden.
INSERT INTO orders_by_id (order_id, order_status, order_timestamp, order_subtotal, order_shipping, order_tax, order_total, payment_summary, payment_details, billing_summary, billing_details, shipping_summary, shipping_details, delivery_id, delivery_details)
VALUES ('111-0461064-1669732','delivered','2020-10-22 10:00:28',58.00,5.99,0.00,63.99,'Visa ending 1234',{'card number':'4321-0000-0000-1234','exp date':'10/24'},'111 Main St, Austin, TX',{'street':'101 Main St','city':'Austin','state':'TX'},'111 Main St, Austin, TX',{'street':'101 Main St','city':'Austin','state':'TX'},'fedex-2',{'service':'FedEx 2Day'});

-- Insertar m�s datos para otros pedidos, similar a los anteriores.

-- Insertar datos en la tabla 'orders_by_user_item':
-- Relaciona a los usuarios con los �tems de sus pedidos. Se utiliza 'user_id' y 'item_id' para la clave primaria.
---------------------------------------------
INSERT INTO orders_by_user_item (user_id, item_id, order_timestamp, order_id)
VALUES ('joe','n-0012','2020-11-17 22:20:43','113-3827060-8722206');
INSERT INTO orders_by_user_item (user_id, item_id, order_timestamp, order_id)
VALUES ('joe','n-0005','2020-11-17 22:20:43','113-3827060-8722206');
INSERT INTO orders_by_user_item (user_id, item_id, order_timestamp, order_id)
VALUES ('joe','n-0023','2020-11-17 22:20:43','113-3827060-8722206');

-- Continuar con los dem�s �tems para 'joe' y 'jen', agregando sus detalles de pedido.

-- Insertar datos en la tabla 'order_status_history_by_id':
-- Esta tabla mantiene el historial de los estados de cada pedido.
---------------------------------------------
INSERT INTO order_status_history_by_id (order_id, status_timestamp, order_status)
VALUES ('113-3827060-8722206','2020-11-18 09:34:10','pending');
INSERT INTO order_status_history_by_id (order_id, status_timestamp, order_status)
VALUES ('113-3827060-8722206','2020-11-17 22:20:43','received');
