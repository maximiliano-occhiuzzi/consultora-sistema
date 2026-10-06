package com.consultora.sistema.service.impl;

import com.consultora.sistema.dao.TareaDAO;
import com.consultora.sistema.dao.impl.TareaDAOImpl;
import com.consultora.sistema.domain.Tarea;
import com.consultora.sistema.service.TareaService;

import java.util.List;

public class TareaServiceImpl implements TareaService {

    private final TareaDAO tareaDAO;

    public TareaServiceImpl() {
        this.tareaDAO = new TareaDAOImpl();
    }

    @Override
    public List<Tarea> listarTareas() {
        return tareaDAO.listar();
    }

    @Override
    public Tarea buscarPorId(int id) {
        return tareaDAO.obtenerPorId(id);
    }

    @Override
    public boolean guardar(Tarea tarea) {
        if (tarea.getTitulo() == null || tarea.getTitulo().trim().isEmpty()) {
            return false;
        }
        return tareaDAO.insertar(tarea);
    }

    @Override
    public boolean modificar(Tarea tarea) {
        if (tarea.getId() <= 0) {
            return false;
        }
        return tareaDAO.actualizar(tarea);
    }

    @Override
    public boolean borrar(int id) {
        if (id <= 0) {
            return false;
        }
        return tareaDAO.eliminar(id);
    }
}