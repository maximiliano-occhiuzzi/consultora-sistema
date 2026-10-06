package com.consultora.sistema.dao;

import com.consultora.sistema.domain.AsignacionTarea;
import java.util.List;

public interface AsignacionTareaDAO {
    List<AsignacionTarea> listar();
    boolean insertar(AsignacionTarea at);
    boolean eliminar(int id);
}