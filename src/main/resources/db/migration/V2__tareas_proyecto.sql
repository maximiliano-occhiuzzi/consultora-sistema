-- Migración: vincular tareas con proyectos y evitar asignaciones duplicadas.
-- Aplicar una sola vez sobre la base existente de Supabase/PostgreSQL.

ALTER TABLE tareas
    ADD COLUMN IF NOT EXISTS id_proyecto INTEGER;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'fk_tareas_proyecto'
    ) THEN
        ALTER TABLE tareas
            ADD CONSTRAINT fk_tareas_proyecto
            FOREIGN KEY (id_proyecto) REFERENCES proyectos(id) ON DELETE CASCADE;
    END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_tareas_proyecto ON tareas(id_proyecto);

-- Elimina duplicados históricos antes de crear los índices únicos.
DELETE FROM asignaciones_proyecto a
USING asignaciones_proyecto b
WHERE a.id > b.id
  AND a.id_empleado = b.id_empleado
  AND a.id_proyecto = b.id_proyecto;

DELETE FROM asignaciones_tarea a
USING asignaciones_tarea b
WHERE a.id > b.id
  AND a.id_empleado = b.id_empleado
  AND a.id_tarea = b.id_tarea;

CREATE UNIQUE INDEX IF NOT EXISTS uq_asignacion_proyecto
    ON asignaciones_proyecto(id_empleado, id_proyecto);

CREATE UNIQUE INDEX IF NOT EXISTS uq_asignacion_tarea
    ON asignaciones_tarea(id_empleado, id_tarea);
