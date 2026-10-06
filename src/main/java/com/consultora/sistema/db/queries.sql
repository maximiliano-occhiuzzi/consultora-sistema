CREATE DATABASE IF NOT EXISTS consultora_db;
USE consultora_db;

-- Tabla de Usuarios (para Autenticación)
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL
);

-- Tabla de Empleados
CREATE TABLE IF NOT EXISTS empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    puesto VARCHAR(50) NOT NULL
);

-- Tabla de Proyectos
CREATE TABLE IF NOT EXISTS proyectos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE'
);

-- Tabla de Tareas
CREATE TABLE IF NOT EXISTS tareas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE'
);

-- Tabla de Asignaciones de Proyectos
CREATE TABLE IF NOT EXISTS asignaciones_proyecto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    id_proyecto INT NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id) ON DELETE CASCADE,
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id) ON DELETE CASCADE
);

-- Tabla de Asignaciones de Tareas
CREATE TABLE IF NOT EXISTS asignaciones_tarea (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    id_tarea INT NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id) ON DELETE CASCADE,
    FOREIGN KEY (id_tarea) REFERENCES tareas(id) ON DELETE CASCADE
);

-- Datos Semilla (Usuario admin / pass: admin123)
INSERT INTO usuarios (username, password) VALUES 
('admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918');

INSERT INTO empleados (nombre, apellido, email, puesto) VALUES 
('Carlos', 'Gómez', 'carlos.gomez@consultora.com', 'Desarrollador Senior'),
('Laura', 'Martínez', 'laura.martinez@consultora.com', 'Analista Funcional');

INSERT INTO proyectos (nombre, descripcion, estado) VALUES 
('Sistema de Gestión', 'Desarrollo de plataforma web interna', 'EN_PROGRESO');

INSERT INTO tareas (titulo, descripcion, estado) VALUES 
('Diseño de Base de Datos', 'Creación de tablas y relaciones SQL', 'COMPLETADA');