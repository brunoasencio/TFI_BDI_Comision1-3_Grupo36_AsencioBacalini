-- ETAPA 2: CREACIÓN DE CATÁLOGO

USE FOOD_STORE;

INSERT INTO CATEGORIA
(nombre, descripcion, createdAt, eliminada)
VALUES
('Hamburguesas', 'Hamburguesas simples y especiales', NOW(), FALSE),
('Pizzas', 'Pizzas de distintos sabores', NOW(), FALSE),
('Empanadas', 'Empanadas horneadas y fritas', NOW(), FALSE),
('Sandwiches', 'Sandwiches frios y calientes', NOW(), FALSE),
('Milanesas', 'Milanesas al plato y sandwich', NOW(), FALSE),
('Pastas', 'Pastas caseras', NOW(), FALSE),
('Ensaladas', 'Ensaladas frescas', NOW(), FALSE),
('Postres', 'Postres artesanales', NOW(), FALSE),
('Helados', 'Helados y copas heladas', NOW(), FALSE),
('Desayunos', 'Opciones para desayuno', NOW(), FALSE),
('Meriendas', 'Opciones para merienda', NOW(), FALSE),
('Cafeteria', 'Cafe, te e infusiones', NOW(), FALSE),
('Bebidas', 'Bebidas sin alcohol', NOW(), FALSE),
('Jugos', 'Jugos naturales y saborizados', NOW(), FALSE),
('Gaseosas', 'Gaseosas de distintas marcas', NOW(), FALSE),
('Cervezas', 'Cervezas nacionales e importadas', NOW(), FALSE),
('Combos', 'Promociones y combos', NOW(), FALSE),
('Veganos', 'Productos aptos veganos', NOW(), FALSE),
('Sin TACC', 'Productos aptos celiacos', NOW(), FALSE),
('Otros', 'Productos varios', NOW(), FALSE);