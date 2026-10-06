package com.consultora.sistema.service.impl;

import com.consultora.sistema.dao.AsignacionProyectoDAO;
import com.consultora.sistema.dao.impl.AsignacionProyectoDAOImpl;
import com.consultora.sistema.domain.AsignacionProyecto;
import com.consultora.sistema.service.AsignacionProyectoService;

import java.util.List;

public class AsignacionProyectoServiceImpl implements AsignacionProyectoService {

    private final AsignacionProyectoDAO dao = new AsignacionProyectoDAOImpl();

    @Override
    public List<AsignacionProyecto> listarAsignaciones() {
        return dao.listar();
    }

    @Override
    public boolean asignar(AsignacionProyecto ap) {
        return dao.insertar(ap);
    }

    @Override
    public boolean desasignar(int id) {
        return dao.eliminar(id);
    }
}