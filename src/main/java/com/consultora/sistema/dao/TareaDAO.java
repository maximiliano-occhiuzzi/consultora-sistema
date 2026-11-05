package com.consultora.sistema.dao;

import com.consultora.sistema.domain.Tarea;
import java.util.List;

public interface TareaDAO {
    List<Tarea> listar();
    List<Tarea> listarPorProyecto(int idProyecto);
    Tarea obtenerPorId(int id);
    boolean insertar(Tarea tarea);
    boolean actualizar(Tarea tarea);
    boolean eliminar(int id);
}
