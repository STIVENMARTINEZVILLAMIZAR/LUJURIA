CREATE DATABASE IF NOT EXISTS lujuria;
USE lujuria;

-- Tabla: usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    edad INT,
    correo_electronico VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    pais VARCHAR(50),
    ciudad VARCHAR(100),
    verificado_edad BOOLEAN DEFAULT FALSE,
    INDEX idx_correo (correo_electronico)
);

-- Tabla: creadores
CREATE TABLE creadores (
    id_creador INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    nombre_creador VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    categoria VARCHAR(50),
    foto_perfil VARCHAR(255),
    estado_online BOOLEAN DEFAULT FALSE,
    rating DECIMAL(3,2),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verificado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    INDEX idx_usuario (id_usuario),
    INDEX idx_nombre_creador (nombre_creador)
);

-- Tabla: categorias
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    INDEX idx_nombre (nombre_categoria)
);

-- Tabla: transmisiones
CREATE TABLE transmisiones (
    id_transmision INT PRIMARY KEY AUTO_INCREMENT,
    id_creador INT NOT NULL,
    titulo VARCHAR(200),
    descripcion TEXT,
    categoria_id INT,
    url_stream VARCHAR(255),
    estado ENUM('activa', 'pausada', 'finalizada') DEFAULT 'activa',
    espectadores_actuales INT DEFAULT 0,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_fin TIMESTAMP NULL,
    duracion_minutos INT,
    precio_acceso DECIMAL(10,2),
    FOREIGN KEY (id_creador) REFERENCES creadores(id_creador) ON DELETE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria),
    INDEX idx_creador (id_creador),
    INDEX idx_estado (estado),
    INDEX idx_fecha (fecha_inicio)
);

-- Tabla: servicios_personalizados
CREATE TABLE servicios_personalizados (
    id_servicio INT PRIMARY KEY AUTO_INCREMENT,
    id_creador INT NOT NULL,
    nombre_servicio VARCHAR(200),
    descripcion TEXT,
    precio DECIMAL(10,2),
    duracion_minutos INT,
    disponible BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_creador) REFERENCES creadores(id_creador) ON DELETE CASCADE,
    INDEX idx_creador (id_creador)
);

-- Tabla: solicitudes_servicio
CREATE TABLE solicitudes_servicio (
    id_solicitud INT PRIMARY KEY AUTO_INCREMENT,
    id_servicio INT NOT NULL,
    id_usuario INT NOT NULL,
    id_creador INT NOT NULL,
    estado ENUM('pendiente', 'aceptado', 'rechazado', 'completado') DEFAULT 'pendiente',
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_programada DATETIME,
    FOREIGN KEY (id_servicio) REFERENCES servicios_personalizados(id_servicio) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_creador) REFERENCES creadores(id_creador) ON DELETE CASCADE,
    INDEX idx_usuario (id_usuario),
    INDEX idx_creador (id_creador),
    INDEX idx_estado (estado)
);

-- Tabla: contenido_digital
CREATE TABLE contenido_digital (
    id_contenido INT PRIMARY KEY AUTO_INCREMENT,
    id_creador INT NOT NULL,
    titulo VARCHAR(200),
    descripcion TEXT,
    tipo ENUM('video', 'foto', 'membresía') DEFAULT 'video',
    url_contenido VARCHAR(255),
    precio DECIMAL(10,2),
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    categoria_id INT,
    FOREIGN KEY (id_creador) REFERENCES creadores(id_creador) ON DELETE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria),
    INDEX idx_creador (id_creador),
    INDEX idx_fecha (fecha_subida)
);

-- Tabla: compras
CREATE TABLE compras (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_contenido INT,
    id_transmision INT,
    monto DECIMAL(10,2),
    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(50),
    estado ENUM('completada', 'pendiente', 'fallida') DEFAULT 'pendiente',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_contenido) REFERENCES contenido_digital(id_contenido),
    FOREIGN KEY (id_transmision) REFERENCES transmisiones(id_transmision),
    INDEX idx_usuario (id_usuario),
    INDEX idx_fecha (fecha_compra),
    INDEX idx_estado (estado)
);

-- Tabla: suscripciones
CREATE TABLE suscripciones (
    id_suscripcion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_creador INT NOT NULL,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento DATETIME,
    estado ENUM('activa', 'cancelada', 'vencida') DEFAULT 'activa',
    precio_mensual DECIMAL(10,2),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_creador) REFERENCES creadores(id_creador) ON DELETE CASCADE,
    INDEX idx_usuario (id_usuario),
    INDEX idx_creador (id_creador),
    INDEX idx_estado (estado)
);

-- Tabla: mensajes
CREATE TABLE mensajes (
    id_mensaje INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_creador INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_creador) REFERENCES creadores(id_creador) ON DELETE CASCADE,
    INDEX idx_usuario (id_usuario),
    INDEX idx_creador (id_creador),
    INDEX idx_leido (leido)
);

-- Tabla: facturas
CREATE TABLE facturas (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    id_compra INT NOT NULL,
    numero_factura VARCHAR(50) UNIQUE,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto_total DECIMAL(10,2),
    impuestos DECIMAL(10,2),
    estado ENUM('pagada', 'pendiente', 'cancelada') DEFAULT 'pendiente',
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra) ON DELETE CASCADE,
    INDEX idx_estado (estado),
    INDEX idx_fecha (fecha_emision)
);

-- Tabla: configuracion_usuario
CREATE TABLE configuracion_usuario (
    id_config INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL UNIQUE,
    notificaciones_email BOOLEAN DEFAULT TRUE,
    privacidad_perfil ENUM('publico', 'privado') DEFAULT 'publico',
    mostrar_edad BOOLEAN DEFAULT FALSE,
    idioma VARCHAR(20) DEFAULT 'es',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    INDEX idx_usuario (id_usuario)
);