-- ETAPA 3: Consultas con EXPLAIN

-- Consulta 1: Consulta de igualdad para el análisis del uso de UNIQUE sobre la columna mail de USUARIO  
EXPLAIN
SELECT *
FROM USUARIO
WHERE mail = 'usuario0500@foodstore.com';

-- Consulta 2: Consulta de rango para evaluar el rendimiento de búsquedas por fecha y el uso del índice idx_pedido_fecha.
EXPLAIN
SELECT *
FROM PEDIDO
WHERE fecha BETWEEN '2025-01-01' AND '2025-06-30';

-- Consulta 3: Consulta JOIN para análisis de unión entre PEDIDO y USUARIO mediante la FK id_usuario
EXPLAIN
SELECT
    p.id_pedido,
    u.nombre,
    u.apellido
FROM PEDIDO p
INNER JOIN USUARIO u
    ON p.id_usuario = u.id_usuario

