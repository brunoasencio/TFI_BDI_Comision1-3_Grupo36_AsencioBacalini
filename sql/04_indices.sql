-- ETAPA 3: Creación de índices

DROP INDEX IF EXISTS idx_pedido_fecha ON PEDIDO;
DROP INDEX IF EXISTS idx_pedido_usuario ON PEDIDO;
DROP INDEX IF EXISTS idx_producto_categoria ON PRODUCTO;
DROP INDEX IF EXISTS idx_detalle_pedido ON DETALLE_PEDIDO;
DROP INDEX IF EXISTS idx_detalle_producto ON DETALLE_PEDIDO;

CREATE INDEX idx_pedido_fecha
ON PEDIDO(fecha);

CREATE INDEX idx_pedido_usuario
ON PEDIDO(id_usuario);

CREATE INDEX idx_producto_categoria
ON PRODUCTO(id_categoria);

CREATE INDEX idx_detalle_pedido
ON DETALLE_PEDIDO(id_pedido);

CREATE INDEX idx_detalle_producto
ON DETALLE_PEDIDO(id_producto);