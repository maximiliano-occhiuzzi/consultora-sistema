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
        return dao.insertar(at);
    }

    @Override
    public boolean desasignar(int id) {
        return dao.eliminar(id);
    }
}