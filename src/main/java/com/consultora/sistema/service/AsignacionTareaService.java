package com.consultora.sistema.service;

import com.consultora.sistema.domain.AsignacionTarea;
import java.util.List;

public interface AsignacionTareaService {
    List<AsignacionTarea> listarAsignaciones();
    boolean asignar(AsignacionTarea at);
    boolean desasignar(int id);
}	