-- ETAPA 2: CARGA MASIVA DE DATOS

SET SESSION cte_max_recursion_depth = 100000;

-- Creación de 2000 usuarios 
INSERT INTO USUARIO (
    nombre,
    apellido,
    mail,
    celular,
    contrasenia,
    rol,
    eliminado,
    createdAt
)
WITH RECURSIVE numeros AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numeros
    WHERE n < 2000
)
SELECT
    CONCAT('Nombre', n),
    CONCAT('Apellido', n),
    CONCAT('usuario', LPAD(n,4,'0'), '@foodstore.com'),
    CONCAT('341', LPAD(n,7,'0')),
    '123456',
    CASE
        WHEN MOD(n,20)=0 THEN 'ADMIN'
        ELSE 'USUARIO'
    END,
    0,
    NOW()
FROM numeros;

-- Creación de 2000 productos 
INSERT INTO PRODUCTO (
    nombre,
    precio,
    descripcion,
    stock,
    imagen,
    disponible,
    eliminado,
    createdAt,
    id_categoria
)
WITH RECURSIVE numeros AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numeros
    WHERE n < 2000
)
SELECT
    CONCAT('Producto ', n),
    ROUND(50 + MOD(n * 17, 5000), 2),
    CONCAT('Descripcion del producto ', n),
    10 + MOD(n * 7, 200),
    CONCAT('img_producto_', n, '.jpg'),
    CASE
        WHEN MOD(n,10)=0 THEN 0
        ELSE 1
    END,
    0,
    NOW(),
    MOD(n-1,20)+1
FROM numeros;

-- Creación de 3000 pedidos
WITH RECURSIVE numeros AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numeros
    WHERE n < 3000
)
SELECT
    CURDATE() - INTERVAL MOD(n,365) DAY AS fecha,

    CASE
        WHEN MOD(n,20) = 0 THEN 'CANCELADO'
        WHEN MOD(n,5) = 0 THEN 'PENDIENTE'
        WHEN MOD(n,3) = 0 THEN 'CONFIRMADO'
        ELSE 'TERMINADO'
    END AS estado,

    ROUND(500 + MOD(n * 37, 25000),2) AS total,

    CASE
        WHEN MOD(n,10) < 5 THEN 'TARJETA'
        WHEN MOD(n,10) < 8 THEN 'TRANSFERENCIA'
        ELSE 'EFECTIVO'
    END AS forma_pago,

    NOW() AS createdAt,

    0 AS eliminado,

    MOD(n-1,2000)+1 AS id_usuario

FROM numeros;


-- Creación de 9000 detalles de pedido
INSERT INTO DETALLE_PEDIDO (
    cantidad,
    subtotal,
    eliminado,
    createdAt,
    id_pedido,
    id_producto
)
SELECT
    (MOD(p.id_pedido + s.n, 5) + 1),

    ROUND(
        (MOD(p.id_pedido + s.n, 5) + 1) *
        pr.precio
    ,2),

    0,

    NOW(),

    p.id_pedido,

    MOD((p.id_pedido * 7 + s.n * 13), 2000) + 1

FROM PEDIDO p
CROSS JOIN (
    SELECT 1 AS n
    UNION ALL SELECT 2
    UNION ALL SELECT 3
) s
JOIN PRODUCTO pr
    ON pr.id_producto =
       MOD((p.id_pedido * 7 + s.n * 13), 2000) + 1;
       
-- Verificaciones   
SELECT COUNT(*)
FROM PRODUCTO p
LEFT JOIN CATEGORIA c
ON p.id_categoria = c.id_categoria
WHERE c.id_categoria IS NULL;

SELECT COUNT(*)
FROM PEDIDO p
LEFT JOIN USUARIO u
ON p.id_usuario = u.id_usuario
WHERE u.id_usuario IS NULL;

SELECT COUNT(*)
FROM DETALLE_PEDIDO d
LEFT JOIN PRODUCTO p
ON d.id_producto = p.id_producto
WHERE p.id_producto IS NULL;

SELECT COUNT(*)
FROM DETALLE_PEDIDO d
LEFT JOIN PEDIDO p
ON d.id_pedido = p.id_pedido
WHERE p.id_pedido IS NULL;