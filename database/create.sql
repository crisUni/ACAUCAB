CREATE TABLE IF NOT EXISTS LUGAR (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('ESTADO', 'MUNICIPIO', 'PARROQUIA')),
    fk_lugar INT
);

CREATE TABLE IF NOT EXISTS RECETA (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    elaboracion TEXT NOT NULL,
    instrucciones TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PRESENTACION (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL
);

CREATE TABLE IF NOT EXISTS DESCUENTO (
    id INT PRIMARY KEY,
    porcentaje FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS TIENDA_VIRTUAL (
    id INT PRIMARY KEY,
    descripcion TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS CARACTERISTICA (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS HORARIO (
    id INT PRIMARY KEY,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    dia_semana VARCHAR(15) NOT NULL CHECK (dia_semana IN ('Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo'))
);

CREATE TABLE IF NOT EXISTS BENEFICIO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PRIVILEGIO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS INGREDIENTE (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS ROL (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS BANCO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS TIPO_TARJETA (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    procesador VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS ESTATUS (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS TASA_CAMBIO (
    id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    tasa_bs_dolar FLOAT NOT NULL,
    tasa_bs_punto FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS LUGAR_TIENDA (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('ALMACEN', 'PASILLO', 'ANAQUEL')),
    fk_lugar_tienda INT
);

CREATE TABLE IF NOT EXISTS METODO_PAGO (
    id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS INGR_RECE (
    fk_ingrediente INT NOT NULL,
    fk_receta INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    PRIMARY KEY (fk_ingrediente, fk_receta),
    FOREIGN KEY (fk_ingrediente) REFERENCES INGREDIENTE(id),
    FOREIGN KEY (fk_receta) REFERENCES RECETA(id)
);

CREATE TABLE IF NOT EXISTS ROL_PRIV (
    fk_rol INT NOT NULL,
    fk_privilegio INT NOT NULL,
    PRIMARY KEY (fk_rol, fk_privilegio),
    FOREIGN KEY (fk_rol) REFERENCES ROL(id),
    FOREIGN KEY (fk_privilegio) REFERENCES PRIVILEGIO(id)
);

CREATE TABLE IF NOT EXISTS PROVEEDOR (
    id INT PRIMARY KEY,
    rif VARCHAR(30) NOT NULL,
    direccion TEXT NOT NULL,
    denominacion_comercial VARCHAR(100) NOT NULL,
    razon_social VARCHAR(100) NOT NULL,
    pagina_web VARCHAR(200),
    fk_lugar_1 INT NOT NULL,
    fk_lugar_2 INT NOT NULL,
    FOREIGN KEY (fk_lugar_1) REFERENCES LUGAR(id),
    FOREIGN KEY (fk_lugar_2) REFERENCES LUGAR(id)
);

CREATE TABLE IF NOT EXISTS CLIENTE (
    id INT PRIMARY KEY,
    rif VARCHAR(30) NOT NULL,
    direccion TEXT NOT NULL,
    numero_registro INT,
    fk_lugar_1 INT NOT NULL,
    fk_lugar_2 INT NOT NULL,
    FOREIGN KEY (fk_lugar_1) REFERENCES LUGAR(id),
    FOREIGN KEY (fk_lugar_2) REFERENCES LUGAR(id)
);

CREATE TABLE IF NOT EXISTS TIENDA_FISICA (
    id INT PRIMARY KEY,
    capacidad INT NOT NULL,
    direccion TEXT NOT NULL,
    fk_lugar INT NOT NULL,
    FOREIGN KEY (fk_lugar) REFERENCES LUGAR(id)
);

CREATE TABLE IF NOT EXISTS EMPLEADO (
    id INT PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL,
    primer_nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100),
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100),
    fecha_nacimiento DATE NOT NULL,
    genero VARCHAR(20) NOT NULL,
    fecha_union DATE NOT NULL,
    fk_lugar INT NOT NULL,
    FOREIGN KEY (fk_lugar) REFERENCES LUGAR(id)
);

CREATE TABLE IF NOT EXISTS TARJETA (
    id INT PRIMARY KEY,
    fk_metodo_pago INT NOT NULL,
    fk_banco INT NOT NULL,
    fk_tipo_tarjeta INT NOT NULL,
    numero_tarjeta INT NOT NULL,
    fecha_vence DATE NOT NULL,
    nombre_titular VARCHAR(100) NOT NULL,
    cvv INT CHECK (cvv >= 100 AND cvv <= 999),
    FOREIGN KEY (fk_metodo_pago) REFERENCES METODO_PAGO(id),
    FOREIGN KEY (fk_banco) REFERENCES BANCO(id),
    FOREIGN KEY (fk_tipo_tarjeta) REFERENCES TIPO_TARJETA(id)
);

CREATE TABLE IF NOT EXISTS CHEQUE (
    id INT PRIMARY KEY,
    fk_metodo_pago INT NOT NULL,
    numero INT NOT NULL,
    fk_banco INT NOT NULL,
    memo TEXT,
    FOREIGN KEY (fk_metodo_pago) REFERENCES METODO_PAGO(id),
    FOREIGN KEY (fk_banco) REFERENCES BANCO(id)
);

CREATE TABLE IF NOT EXISTS EFECTIVO (
    id INT PRIMARY KEY,
    fk_metodo_pago INT NOT NULL,
    denominacion INT NOT NULL,
    tipo_moneda VARCHAR(50) NOT NULL,
    FOREIGN KEY (fk_metodo_pago) REFERENCES METODO_PAGO(id)
);

CREATE TABLE IF NOT EXISTS PUNTO (
    id INT PRIMARY KEY,
    fk_metodo_pago INT NOT NULL,
    FOREIGN KEY (fk_metodo_pago) REFERENCES METODO_PAGO(id)
);

CREATE TABLE IF NOT EXISTS AFILIACION (
    numero INT PRIMARY KEY,
    fecha DATE NOT NULL,
    monto_mensual FLOAT NOT NULL,
    fk_proveedor INT NOT NULL,
    FOREIGN KEY (fk_proveedor) REFERENCES PROVEEDOR(id)
);

CREATE TABLE IF NOT EXISTS COMPRA (
    id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    monto_total FLOAT NOT NULL,
    fk_proveedor INT NOT NULL,
    FOREIGN KEY (fk_proveedor) REFERENCES PROVEEDOR(id)
);

CREATE TABLE IF NOT EXISTS PNATURAL (
    id INT PRIMARY KEY,
    fk_cliente INT UNIQUE NOT NULL,
    cedula VARCHAR(20),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nacimiento DATE,
    FOREIGN KEY (fk_cliente) REFERENCES CLIENTE(id)
);

CREATE TABLE IF NOT EXISTS PJURIDICO (
    id INT PRIMARY KEY,
    fk_cliente INT UNIQUE NOT NULL,
    denominacion_comercial VARCHAR(100),
    razon_social VARCHAR(100),
    pagina_web VARCHAR(200),
    capital_disponible FLOAT,
    FOREIGN KEY (fk_cliente) REFERENCES CLIENTE(id)
);

CREATE TABLE IF NOT EXISTS DEPARTAMENTO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    fk_tienda_fisica INT NOT NULL,
    FOREIGN KEY (fk_tienda_fisica) REFERENCES TIENDA_FISICA(id)
);

CREATE TABLE IF NOT EXISTS EMPL_HORA (
    fk_empleado INT NOT NULL,
    fk_horario INT NOT NULL,
    asistencia INT,
    PRIMARY KEY (fk_empleado, fk_horario),
    FOREIGN KEY (fk_empleado) REFERENCES EMPLEADO(id),
    FOREIGN KEY (fk_horario) REFERENCES HORARIO(id)
);

CREATE TABLE IF NOT EXISTS USUARIO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    fk_empleado INT,
    fk_cliente INT,
    fk_proveedor INT,
    fk_rol INT NOT NULL,
    FOREIGN KEY (fk_empleado) REFERENCES EMPLEADO(id),
    FOREIGN KEY (fk_cliente) REFERENCES CLIENTE(id),
    FOREIGN KEY (fk_proveedor) REFERENCES PROVEEDOR(id),
    FOREIGN KEY (fk_rol) REFERENCES ROL(id)
);

CREATE TABLE IF NOT EXISTS TELEFONO (
    id INT PRIMARY KEY,
    codigo_pais INT NOT NULL,
    numero INT NOT NULL,
    fk_proveedor INT,
    fk_cliente INT,
    fk_empleado INT,
    FOREIGN KEY (fk_proveedor) REFERENCES PROVEEDOR(id),
    FOREIGN KEY (fk_cliente) REFERENCES CLIENTE(id),
    FOREIGN KEY (fk_empleado) REFERENCES EMPLEADO(id)
);

CREATE TABLE IF NOT EXISTS CORREO (
    id INT PRIMARY KEY,
    correo VARCHAR(100) NOT NULL,
    dominio VARCHAR(100) NOT NULL,
    fk_proveedor INT,
    fk_cliente INT,
    fk_empleado INT,
    FOREIGN KEY (fk_proveedor) REFERENCES PROVEEDOR(id),
    FOREIGN KEY (fk_cliente) REFERENCES CLIENTE(id),
    FOREIGN KEY (fk_empleado) REFERENCES EMPLEADO(id)
);

CREATE TABLE IF NOT EXISTS ESTA_COMP (
    fk_compra INT NOT NULL,
    fk_estatus INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (fk_compra, fk_estatus, fecha_inicio),
    FOREIGN KEY (fk_compra) REFERENCES COMPRA(id),
    FOREIGN KEY (fk_estatus) REFERENCES ESTATUS(id)
);

CREATE TABLE IF NOT EXISTS DETALLE_COMPRA (
    id INT PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario FLOAT NOT NULL,
    fk_compra INT NOT NULL,
    FOREIGN KEY (fk_compra) REFERENCES COMPRA(id)
);

CREATE TABLE IF NOT EXISTS CARGO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS PERSONAL_CONTACTO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fk_juridico INT,
    fk_proveedor INT,
    fk_cargo INT,
    FOREIGN KEY (fk_juridico) REFERENCES PJURIDICO(id),
    FOREIGN KEY (fk_proveedor) REFERENCES PROVEEDOR(id),
    FOREIGN KEY (fk_cargo) REFERENCES CARGO(id)
);

CREATE TABLE IF NOT EXISTS TIPO_CERVEZA (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fk_tipo_cerveza INT,
    fk_receta INT NOT NULL,
    FOREIGN KEY (fk_tipo_cerveza) REFERENCES TIPO_CERVEZA(id),
    FOREIGN KEY (fk_receta) REFERENCES RECETA(id)
);

CREATE TABLE IF NOT EXISTS CERVEZA (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    historia TEXT,
    fk_tipo_cerveza INT NOT NULL,
    fk_proveedor INT NOT NULL,
    fk_lugar INT NOT NULL,
    FOREIGN KEY (fk_tipo_cerveza) REFERENCES TIPO_CERVEZA(id),
    FOREIGN KEY (fk_proveedor) REFERENCES PROVEEDOR(id),
    FOREIGN KEY (fk_lugar) REFERENCES LUGAR(id)
);

CREATE TABLE IF NOT EXISTS COMENTARIO (
    id INT PRIMARY KEY,
    descripcion TEXT NOT NULL,
    fk_cerveza INT NOT NULL,
    FOREIGN KEY (fk_cerveza) REFERENCES CERVEZA(id)
);

CREATE TABLE IF NOT EXISTS CERV_PRES (
    fk_cerveza INT NOT NULL,
    fk_presentacion INT NOT NULL,
    precio FLOAT NOT NULL,
    PRIMARY KEY (fk_cerveza, fk_presentacion),
    FOREIGN KEY (fk_cerveza) REFERENCES CERVEZA(id),
    FOREIGN KEY (fk_presentacion) REFERENCES PRESENTACION(id)
);

CREATE TABLE IF NOT EXISTS DESC_CERV_PRES (
    fk_cerveza INT NOT NULL,
    fk_presentacion INT NOT NULL,
    fk_descuento INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    PRIMARY KEY (fk_cerveza, fk_presentacion, fk_descuento),
    FOREIGN KEY (fk_cerveza) REFERENCES CERVEZA(id),
    FOREIGN KEY (fk_presentacion) REFERENCES PRESENTACION(id),
    FOREIGN KEY (fk_descuento) REFERENCES DESCUENTO(id)
);

CREATE TABLE IF NOT EXISTS TIPO_EVENTO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS EVENTO (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    numero_entradas INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    direccion TEXT NOT NULL,
    fk_evento INT,
    fk_tipo_evento INT NOT NULL,
    fk_lugar INT NOT NULL,
    FOREIGN KEY (fk_evento) REFERENCES EVENTO(id),
    FOREIGN KEY (fk_tipo_evento) REFERENCES TIPO_EVENTO(id),
    FOREIGN KEY (fk_lugar) REFERENCES LUGAR(id)
);

CREATE TABLE IF NOT EXISTS VENTA (
    id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    monto_total FLOAT NOT NULL,
    fk_tienda_virtual INT,
    fk_tienda_fisica INT,
    fk_evento INT,
    fk_cliente INT,
    FOREIGN KEY (fk_tienda_virtual) REFERENCES TIENDA_VIRTUAL(id),
    FOREIGN KEY (fk_tienda_fisica) REFERENCES TIENDA_FISICA(id),
    FOREIGN KEY (fk_evento) REFERENCES EVENTO(id),
    FOREIGN KEY (fk_cliente) REFERENCES CLIENTE(id)
);

CREATE TABLE IF NOT EXISTS ESTA_VENT (
    fk_venta INT NOT NULL,
    fk_estatus INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (fk_venta, fk_estatus, fecha_inicio),
    FOREIGN KEY (fk_venta) REFERENCES VENTA(id),
    FOREIGN KEY (fk_estatus) REFERENCES ESTATUS(id)
);

CREATE TABLE IF NOT EXISTS ESTA_EVEN (
    fk_evento INT NOT NULL,
    fk_estatus INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (fk_evento, fk_estatus, fecha_inicio),
    FOREIGN KEY (fk_evento) REFERENCES EVENTO(id),
    FOREIGN KEY (fk_estatus) REFERENCES ESTATUS(id)
);

CREATE TABLE IF NOT EXISTS CERV_CARA (
    fk_caracteristica INT NOT NULL,
    fk_cerveza INT NOT NULL,
    descripcion TEXT NOT NULL,
    PRIMARY KEY (fk_caracteristica, fk_cerveza),
    FOREIGN KEY (fk_caracteristica) REFERENCES CARACTERISTICA(id),
    FOREIGN KEY (fk_cerveza) REFERENCES CERVEZA(id)
);

CREATE TABLE IF NOT EXISTS INVE_TIEN (
    fk_cerveza INT NOT NULL,
    fk_presentacion INT NOT NULL,
    fk_tienda INT NOT NULL,
    fk_lugar_tienda INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad >= 0),
    PRIMARY KEY (fk_cerveza, fk_presentacion, fk_tienda),
    FOREIGN KEY (fk_cerveza) REFERENCES CERVEZA(id),
    FOREIGN KEY (fk_presentacion) REFERENCES PRESENTACION(id),
    FOREIGN KEY (fk_tienda) REFERENCES TIENDA_FISICA(id),
    FOREIGN KEY (fk_lugar_tienda) REFERENCES LUGAR_TIENDA(id)
);

CREATE TABLE IF NOT EXISTS EVEN_PROV (
    fk_evento INT NOT NULL,
    fk_proveedor INT NOT NULL,
    PRIMARY KEY (fk_evento, fk_proveedor),
    FOREIGN KEY (fk_evento) REFERENCES EVENTO(id),
    FOREIGN KEY (fk_proveedor) REFERENCES PROVEEDOR(id)
);

CREATE TABLE IF NOT EXISTS EVEN_CLIE (
    fk_evento INT NOT NULL,
    fk_cliente INT NOT NULL,
    precio FLOAT,
    PRIMARY KEY (fk_evento, fk_cliente),
    FOREIGN KEY (fk_evento) REFERENCES EVENTO(id),
    FOREIGN KEY (fk_cliente) REFERENCES CLIENTE(id)
);

CREATE TABLE IF NOT EXISTS CARG_EMPL (
    fk_empleado INT NOT NULL,
    fk_cargo INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    salario_base FLOAT NOT NULL,
    PRIMARY KEY (fk_empleado, fk_cargo, fecha_inicio),
    FOREIGN KEY (fk_empleado) REFERENCES EMPLEADO(id),
    FOREIGN KEY (fk_cargo) REFERENCES CARGO(id)
);

CREATE TABLE IF NOT EXISTS EMPL_BENE (
    fk_empleado INT NOT NULL,
    fk_cargo INT NOT NULL,
    fk_beneficio INT NOT NULL,
    monto_beneficio FLOAT,
    PRIMARY KEY (fk_empleado, fk_cargo, fk_beneficio),
    FOREIGN KEY (fk_empleado) REFERENCES EMPLEADO(id),
    FOREIGN KEY (fk_cargo) REFERENCES CARGO(id),
    FOREIGN KEY (fk_beneficio) REFERENCES BENEFICIO(id)
);

CREATE TABLE IF NOT EXISTS INVE_EVEN (
    fk_cerveza INT NOT NULL,
    fk_presentacion INT NOT NULL,
    fk_evento INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad >= 0),
    PRIMARY KEY (fk_cerveza, fk_presentacion, fk_evento),
    FOREIGN KEY (fk_cerveza) REFERENCES CERVEZA(id),
    FOREIGN KEY (fk_presentacion) REFERENCES PRESENTACION(id),
    FOREIGN KEY (fk_evento) REFERENCES EVENTO(id)
);

CREATE TABLE IF NOT EXISTS PUNT_CLIE (
    fk_punto INT NOT NULL,
    fk_cliente INT NOT NULL,
    fk_tasa_cambio INT NOT NULL,
    cantidad_puntos INT NOT NULL,
    PRIMARY KEY (fk_punto, fk_cliente),
    FOREIGN KEY (fk_punto) REFERENCES PUNTO(id),
    FOREIGN KEY (fk_cliente) REFERENCES CLIENTE(id),
    FOREIGN KEY (fk_tasa_cambio) REFERENCES TASA_CAMBIO(id)
);

CREATE TABLE IF NOT EXISTS PAGO (
    fk_metodo_pago INT NOT NULL,
    fk_venta INT NOT NULL,
    fk_tasa_cambio INT NOT NULL,
    monto FLOAT NOT NULL,
    PRIMARY KEY (fk_metodo_pago, fk_venta),
    FOREIGN KEY (fk_metodo_pago) REFERENCES METODO_PAGO(id),
    FOREIGN KEY (fk_venta) REFERENCES VENTA(id),
    FOREIGN KEY (fk_tasa_cambio) REFERENCES TASA_CAMBIO(id)
);

CREATE TABLE IF NOT EXISTS JUEZ (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fk_evento INT,
    FOREIGN KEY (fk_evento) REFERENCES EVENTO(id)
);

CREATE TABLE IF NOT EXISTS JUEZ_EVENT (
    fk_juez INT NOT NULL,
    fk_evento INT NOT NULL,
    PRIMARY KEY (fk_juez, fk_evento),
    FOREIGN KEY (fk_juez) REFERENCES JUEZ(id),
    FOREIGN KEY (fk_evento) REFERENCES EVENTO(id)
);

CREATE TABLE IF NOT EXISTS DETALLE_FACTURA (
    id INT PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario FLOAT NOT NULL,
    fk_venta INT NOT NULL,
    fk_cerveza INT NOT NULL,
    fk_presentacion INT NOT NULL,
    FOREIGN KEY (fk_venta) REFERENCES VENTA(id),
    FOREIGN KEY (fk_cerveza) REFERENCES CERVEZA(id),
    FOREIGN KEY (fk_presentacion) REFERENCES PRESENTACION(id)
);

CREATE TABLE IF NOT EXISTS PAGO_AFILIACION (
    numero INT PRIMARY KEY,
    fecha DATE NOT NULL,
    total FLOAT NOT NULL,
    mes_pagado DATE NOT NULL,
    fk_afiliacion INT NOT NULL,
    fk_metodo_pago INT NOT NULL,
    fk_tasa_cambio INT NOT NULL,
    FOREIGN KEY (fk_afiliacion) REFERENCES AFILIACION(numero),
    FOREIGN KEY (fk_metodo_pago) REFERENCES METODO_PAGO(id),
    FOREIGN KEY (fk_tasa_cambio) REFERENCES TASA_CAMBIO(id)
);

CREATE TABLE IF NOT EXISTS VACACION (
    id INT PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    fk_cargo INT NOT NULL,
    fk_empleado INT NOT NULL,
    FOREIGN KEY (fk_cargo) REFERENCES CARGO(id),
    FOREIGN KEY (fk_empleado) REFERENCES EMPLEADO(id)
);