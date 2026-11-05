package com.consultora.sistema.dao;

import com.consultora.sistema.domain.AsignacionProyecto;
import java.util.List;

public interface AsignacionProyectoDAO {
    List<AsignacionProyecto> listar();
    List<AsignacionProyecto> listarPorProyecto(int idProyecto);
    boolean existe(int idEmpleado, int idProyecto);
    boolean insertar(AsignacionProyecto ap);
    boolean eliminar(int id);
}
