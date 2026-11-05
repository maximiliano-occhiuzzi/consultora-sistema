package com.consultora.sistema.service;

import com.consultora.sistema.domain.AsignacionProyecto;
import java.util.List;

public interface AsignacionProyectoService {
    List<AsignacionProyecto> listarAsignaciones();
    List<AsignacionProyecto> listarPorProyecto(int idProyecto);
    boolean asignar(AsignacionProyecto ap);
    boolean desasignar(int id);
}
