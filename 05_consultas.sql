-- ETAPA 3: Realización de cuatro consultas

-- Consulta 1: JOIN (Visualización de pedidos por cada usuario para análisis de comporas y seguimiento de actividad)
SELECT
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido) AS usuario,
    p.id_pedido,
    p.fecha,
    p.estado,
    p.total
FROM USUARIO u
INNER JOIN PEDIDO p
ON u.id_usuario = p.id_usuario
ORDER BY p.fecha DESC;

-- Consulta 2: JOIN (Cálculo de unidades vendidas por producto por categoría para identificar demanda)
SELECT
    c.nombre AS categoria,
    pr.nombre AS producto,
    SUM(dp.cantidad) AS unidades_vendidas
FROM DETALLE_PEDIDO dp
INNER JOIN PRODUCTO pr
ON dp.id_producto = pr.id_producto
INNER JOIN CATEGORIA c
ON pr.id_categoria = c.id_categoria
GROUP BY c.nombre, pr.nombre
ORDER BY unidades_vendidas DESC;

-- Consulta 3: GROUP BY + HAVING (Determinar cantidad de pedidos por usuario)
SELECT
    u.id_usuario,
    CONCAT(u.nombre,' ',u.apellido) AS usuario,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM USUARIO u
INNER JOIN PEDIDO p
    ON u.id_usuario = p.id_usuario
GROUP BY u.id_usuario, usuario
HAVING COUNT(p.id_pedido) >= 2
ORDER BY cantidad_pedidos DESC;

-- Consulta 4: Subconsulta (Cálculo de precio promedio de los productos y selección de los que los superan)
SELECT
    id_producto,
    nombre,
    precio
FROM PRODUCTO
WHERE precio >
(
    SELECT AVG(precio)
    FROM PRODUCTO
)
ORDER BY precio DESC;
