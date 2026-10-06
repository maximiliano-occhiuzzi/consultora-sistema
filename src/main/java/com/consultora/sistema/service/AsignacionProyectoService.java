package com.consultora.sistema.service;

import com.consultora.sistema.domain.AsignacionProyecto;
import java.util.List;

public interface AsignacionProyectoService {
    List<AsignacionProyecto> listarAsignaciones();
    boolean asignar(AsignacionProyecto ap);
    boolean desasignar(int id);
}