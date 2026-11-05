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
    public List<AsignacionProyecto> listarPorProyecto(int idProyecto) {
        if (idProyecto <= 0) {
            return dao.listar();
        }
        return dao.listarPorProyecto(idProyecto);
    }

    @Override
    public boolean asignar(AsignacionProyecto ap) {
        if (ap == null || ap.getIdEmpleado() <= 0 || ap.getIdProyecto() <= 0) {
            return false;
        }
        if (dao.existe(ap.getIdEmpleado(), ap.getIdProyecto())) {
            return false;
        }
        return dao.insertar(ap);
    }

    @Override
    public boolean desasignar(int id) {
        return id > 0 && dao.eliminar(id);
    }
}
