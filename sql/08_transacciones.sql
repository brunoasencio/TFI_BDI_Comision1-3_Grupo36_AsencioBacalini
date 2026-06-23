-- ETAPA 5: Transacciones

-- Transacción con COMMIT
START TRANSACTION;

UPDATE PRODUCTO
SET stock = stock - 5
WHERE id_producto = 1;

COMMIT;
-- Verificación
SELECT id_producto, stock
FROM PRODUCTO
WHERE id_producto = 1;

-- Transacción con ROLLBACK
START TRANSACTION;

UPDATE PRODUCTO
SET stock = stock - 10
WHERE id_producto = 2;

ROLLBACK;
-- Verificación
SELECT id_producto, stock
FROM PRODUCTO
WHERE id_producto = 2;

-- Procedimiento con manejo de errores
DROP PROCEDURE IF EXISTS ActualizarStockSeguro;
DELIMITER $$

CREATE PROCEDURE ActualizarStockSeguro(
IN p_id_producto BIGINT,
IN p_cantidad INT
)
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    ROLLBACK;
    SELECT 'ERROR - TRANSACCION CANCELADA' AS resultado;
END;

START TRANSACTION;

UPDATE PRODUCTO
SET stock = stock - p_cantidad
WHERE id_producto = p_id_producto;

COMMIT;

SELECT 'TRANSACCION CONFIRMADA' AS resultado;

END $$

DELIMITER ;
-- Verificación
CALL ActualizarStockSeguro(1, 2);