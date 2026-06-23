-- ETAPA 3: Creación de una vista

--  Permite consultar en una única estructura los datos principales de cada pedido
DROP VIEW IF EXISTS vw_pedidos_completos;
CREATE VIEW vw_pedidos_completos AS
SELECT
    p.id_pedido,
    p.fecha,
    p.estado,
    p.forma_pago,
    p.total,
    CONCAT(u.nombre,' ',u.apellido) AS usuario
FROM PEDIDO p
INNER JOIN USUARIO u
    ON p.id_usuario = u.id_usuario;

-- Prueba de la vista
SELECT *
FROM vw_pedidos_completos
LIMIT 20;