package com.consultora.sistema.dao;

import com.consultora.sistema.domain.AsignacionTarea;
import java.util.List;

public interface AsignacionTareaDAO {
    List<AsignacionTarea> listar();
    boolean existe(int idEmpleado, int idTarea);
    boolean insertar(AsignacionTarea at);
    boolean eliminar(int id);
}
