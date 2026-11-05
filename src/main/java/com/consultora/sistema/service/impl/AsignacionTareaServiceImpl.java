package com.consultora.sistema.service.impl;

import com.consultora.sistema.dao.AsignacionTareaDAO;
import com.consultora.sistema.dao.impl.AsignacionTareaDAOImpl;
import com.consultora.sistema.domain.AsignacionTarea;
import com.consultora.sistema.service.AsignacionTareaService;

import java.util.List;

public class AsignacionTareaServiceImpl implements AsignacionTareaService {

    private final AsignacionTareaDAO dao = new AsignacionTareaDAOImpl();

    @Override
    public List<AsignacionTarea> listarAsignaciones() {
        return dao.listar();
    }

    @Override
    public boolean asignar(AsignacionTarea at) {
        if (at == null || at.getIdEmpleado() <= 0 || at.getIdTarea() <= 0) {
            return false;
        }
        if (dao.existe(at.getIdEmpleado(), at.getIdTarea())) {
            return false;
        }
        return dao.insertar(at);
    }

    @Override
    public boolean desasignar(int id) {
        return id > 0 && dao.eliminar(id);
    }
}
