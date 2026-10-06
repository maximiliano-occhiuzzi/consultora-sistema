package com.consultora.sistema.dao;

import com.consultora.sistema.domain.AsignacionProyecto;
import java.util.List;

public interface AsignacionProyectoDAO {
    List<AsignacionProyecto> listar();
    boolean insertar(AsignacionProyecto ap);
    boolean eliminar(int id);
}