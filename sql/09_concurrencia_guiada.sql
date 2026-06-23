-- ETAPA 5: Concurrencia guiada

-- Prueba 1: DEADLOCK - Resultado esperado (Error Code: 1213 - Deadlock found when trying to get lock)
-- SESION A
START TRANSACTION;

UPDATE PRODUCTO
SET stock = stock - 1
WHERE id_producto = 1;
-- SESION B
START TRANSACTION;
UPDATE PRODUCTO
SET stock = stock - 1
WHERE id_producto = 2;

-- SESION A
UPDATE PRODUCTO
SET stock = stock - 1
WHERE id_producto = 2;
-- Quedará esperando bloqueo.

-- SESION B
UPDATE PRODUCTO
SET stock = stock - 1
WHERE id_producto = 1;

-- MySQL detecta el deadlock y cancelar una de las transacciones.

ROLLBACK;

-- PRUEBA 2 - READ COMMITTED - Resultado esperado: Observar que una transacción puede ver cambios confirmados por otra sesión.

-- SESION A
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT stock
FROM PRODUCTO
WHERE id_producto = 1;

-- SESION B
UPDATE PRODUCTO
SET stock = stock + 50
WHERE id_producto = 1;

COMMIT;

-- SESION A
SELECT stock
FROM PRODUCTO
WHERE id_producto = 1;

COMMIT;

-- Se observa el nuevo valor de stock.

-- Prueba 3: REPEATABLE READ - Resultado esperado: Observar que una transacción mantiene una visión consistente de los datos

-- SESIÓN A
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;

SELECT stock
FROM PRODUCTO
WHERE id_producto = 1;

-- SESION B
UPDATE PRODUCTO
SET stock = stock + 50
WHERE id_producto = 1;

COMMIT;

-- SESION A
SELECT stock
FROM PRODUCTO
WHERE id_producto = 1;

COMMIT;

-- Se mantiene el valor leído inicialmente hasta finalizar la transacción.