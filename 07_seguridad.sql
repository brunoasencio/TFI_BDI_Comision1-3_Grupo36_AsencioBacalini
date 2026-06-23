-- ETAPA 4: SEGURIDAD E INTEGRIDAD

-- Creación de un usuario con mínimos privilegios (sólo lectura)
DROP USER IF EXISTS 'food_reader'@'localhost';

CREATE USER 'food_reader'@'localhost'
IDENTIFIED BY 'Food1234';
GRANT SELECT
ON FOOD_STORE.*
TO 'food_reader'@'localhost';
FLUSH PRIVILEGES;

-- Vista de usuarios ocultando información sensible
DROP VIEW IF EXISTS vw_usuarios_publicos;

CREATE VIEW vw_usuarios_publicos AS
SELECT
    id_usuario,
    nombre,
    apellido,
    mail,
    celular,
    rol,
    createdAt
FROM USUARIO;

-- Vista de pedidos simplificada 
DROP VIEW IF EXISTS vw_pedidos_publicos;

CREATE VIEW vw_pedidos_publicos AS
SELECT
    id_pedido,
    fecha,
    estado,
    total,
    forma_pago
FROM PEDIDO;

-- Procedimiento almacenado seguro
DROP PROCEDURE IF EXISTS BuscarUsuarioPorMail;

DELIMITER $$

CREATE PROCEDURE BuscarUsuarioPorMail(
    IN p_mail VARCHAR(150)
)
BEGIN
    SELECT
        id_usuario,
        nombre,
        apellido,
        mail,
        rol
    FROM USUARIO
    WHERE mail = p_mail;
END $$

DELIMITER ;

-- Prueba de integridad UNIQUE (debe fallar porque el mail está registrado previamente)
INSERT INTO USUARIO
(
    nombre,
    apellido,
    mail,
    celular,
    contrasenia,
    rol,
    eliminado,
    createdAt
)
VALUES
(
    'Prueba',
    'Duplicado',
    'usuario0001@foodstore.com',
    '3410000000',
    '1234',
    'CLIENTE',
    0,
    NOW()
);

-- Prueba de integridad de clave foránea (debe fallar porque el usuario es inexistente)
INSERT INTO PEDIDO
(
    fecha,
    estado,
    total,
    forma_pago,
    createdAt,
    eliminado,
    id_usuario
)
VALUES
(
    CURDATE(),
    'PENDIENTE',
    1000,
    'EFECTIVO',
    NOW(),
    0,
    999999
);

-- Prueba anti SQL Injection (se recibe el valor como texto y no como código SQL)
CALL BuscarUsuarioPorMail(
    ''' OR 1=1 --'
);

-- Pruebas de las vistas 
SELECT * FROM vw_usuarios_publicos LIMIT 10;
SELECT * FROM vw_pedidos_publicos LIMIT 10;