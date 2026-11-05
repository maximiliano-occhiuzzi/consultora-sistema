-- Esquema PostgreSQL/Supabase del sistema TechConsult.
-- Este archivo refleja el modelo actual. Para una base ya creada,
-- aplicar también src/main/resources/db/migration/V2__tareas_proyecto.sql.

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS proyectos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(30) NOT NULL DEFAULT 'Planificado'
);

CREATE TABLE IF NOT EXISTS tareas (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(30) NOT NULL DEFAULT 'Pendiente',
    id_proyecto INTEGER REFERENCES proyectos(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS asignaciones_proyecto (
    id SERIAL PRIMARY KEY,
    id_empleado INTEGER NOT NULL REFERENCES empleados(id) ON DELETE CASCADE,
    id_proyecto INTEGER NOT NULL REFERENCES proyectos(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS asignaciones_tarea (
    id SERIAL PRIMARY KEY,
    id_empleado INTEGER NOT NULL REFERENCES empleados(id) ON DELETE CASCADE,
    id_tarea INTEGER NOT NULL REFERENCES tareas(id) ON DELETE CASCADE
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_asignacion_proyecto
    ON asignaciones_proyecto(id_empleado, id_proyecto);

CREATE UNIQUE INDEX IF NOT EXISTS uq_asignacion_tarea
    ON asignaciones_tarea(id_empleado, id_tarea);

CREATE INDEX IF NOT EXISTS idx_tareas_proyecto ON tareas(id_proyecto);

-- Usuario inicial: admin / admin123
INSERT INTO usuarios (username, password)
VALUES ('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9')
ON CONFLICT (username) DO NOTHING;
