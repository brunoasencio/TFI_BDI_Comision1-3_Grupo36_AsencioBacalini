-- ETAPA 1: GENERACIÓN DEL ESQUEMA

DROP SCHEMA IF EXISTS FOOD_STORE;
CREATE SCHEMA FOOD_STORE;
USE FOOD_STORE;

DROP TABLE IF EXISTS CATEGORIA;
CREATE TABLE CATEGORIA (
    id_categoria BIGINT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    createdAt DATETIME NOT NULL,
    eliminada BOOLEAN NOT NULL,
    PRIMARY KEY (id_categoria),
    UNIQUE (nombre)
);

DROP TABLE IF EXISTS PRODUCTO;
CREATE TABLE PRODUCTO (
    id_producto BIGINT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    descripcion VARCHAR(255),
    stock INT NOT NULL,
    imagen VARCHAR(255),
    disponible BOOLEAN NOT NULL,
    eliminado BOOLEAN NOT NULL,
    createdAt DATETIME NOT NULL,
    id_categoria BIGINT NOT NULL,

    PRIMARY KEY (id_producto),

    FOREIGN KEY (id_categoria)
        REFERENCES CATEGORIA(id_categoria),

    CHECK (precio >= 0),
    CHECK (stock >= 0)
);

DROP TABLE IF EXISTS USUARIO;
CREATE TABLE USUARIO (
    id_usuario BIGINT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    mail VARCHAR(150) NOT NULL,
    celular VARCHAR(30) NOT NULL,
    contrasenia VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL,
    eliminado BOOLEAN NOT NULL,
    createdAt DATETIME NOT NULL,

    PRIMARY KEY (id_usuario) NOT NULL,

    UNIQUE (mail),

    CHECK (rol IN ('ADMIN','USUARIO'))
);

DROP TABLE IF EXISTS PEDIDO;
CREATE TABLE PEDIDO (
    id_pedido BIGINT AUTO_INCREMENT NOT NULL,
    fecha DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    forma_pago VARCHAR(20) NOT NULL,
    createdAt DATETIME NOT NULL,
    eliminado BOOLEAN NOT NULL,
    id_usuario BIGINT NOT NULL,

    PRIMARY KEY (id_pedido),

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario),

    CHECK (total >= 0),

    CHECK (estado IN (
        'PENDIENTE',
        'CONFIRMADO',
        'TERMINADO',
        'CANCELADO'
    )),

    CHECK (forma_pago IN (
        'TARJETA',
        'TRANSFERENCIA',
        'EFECTIVO'
    ))
);

DROP TABLE IF EXISTS DETALLE_PEDIDO;
CREATE TABLE DETALLE_PEDIDO (
    id_detalle BIGINT AUTO_INCREMENT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    eliminado BOOLEAN NOT NULL,
    createdAt DATETIME NOT NULL,
    id_pedido BIGINT NOT NULL,
    id_producto BIGINT NOT NULL,

    PRIMARY KEY (id_detalle),

    FOREIGN KEY (id_pedido)
        REFERENCES PEDIDO(id_pedido),

    FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto),

    CHECK (cantidad > 0),
    CHECK (subtotal >= 0)
);

-- INSERCIÓN CORRECTA 1
INSERT INTO CATEGORIA
(nombre, descripcion, createdAt, eliminada)
VALUES
('Bebidas', 'Gaseosas y jugos', NOW(), FALSE);

-- INSERCIÓN CORRECTA 2
INSERT INTO USUARIO
(nombre, apellido, mail, celular, contrasenia, rol, eliminado, createdAt)
VALUES
('Juan', 'Perez', 'juan@mail.com', '3464555555',
'1234', 'USUARIO', FALSE, NOW());

-- INSERCIÓN ERRÓNEA 1 (falla porque el mail ya fue registrado anteriormente)
INSERT INTO USUARIO
(nombre, apellido, mail, celular, contrasenia, rol, eliminado, createdAt)
VALUES
('Pedro', 'Gomez', 'juan@mail.com', '3464666666',
'1234', 'USUARIO', FALSE, NOW());

-- INSERCIÓN ERRÓNEA 2 (falla porque el precio del producto está en negativo)
INSERT INTO PRODUCTO
(nombre, precio, stock, disponible, eliminado,
createdAt, id_categoria)
VALUES
('Coca Cola', -50, 10, TRUE, FALSE,
NOW(), 1);