package com.consultora.sistema.service.impl;

import com.consultora.sistema.dao.ProyectoDAO;
import com.consultora.sistema.dao.impl.ProyectoDAOImpl;
import com.consultora.sistema.domain.Proyecto;
import com.consultora.sistema.service.ProyectoService;

import java.util.List;

public class ProyectoServiceImpl implements ProyectoService {

    private final ProyectoDAO proyectoDAO;

    public ProyectoServiceImpl() {
        this.proyectoDAO = new ProyectoDAOImpl();
    }

    @Override
    public List<Proyecto> listarProyectos() {
        return proyectoDAO.listar();
    }

    @Override
    public Proyecto buscarPorId(int id) {
        return proyectoDAO.obtenerPorId(id);
    }

    @Override
    public boolean guardar(Proyecto proyecto) {
        if (proyecto.getNombre() == null || proyecto.getNombre().trim().isEmpty()) {
            return false;
        }
        return proyectoDAO.insertar(proyecto);
    }

    @Override
    public boolean modificar(Proyecto proyecto) {
        if (proyecto.getId() <= 0) {
            return false;
        }
        return proyectoDAO.actualizar(proyecto);
    }

    @Override
    public boolean borrar(int id) {
        if (id <= 0) {
            return false;
        }
        return proyectoDAO.eliminar(id);
    }
}