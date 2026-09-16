package com.consultora.sistema.service.impl;



import java.util.List;

import com.consultora.sistema.dao.EmpleadoDAO;
import com.consultora.sistema.dao.impl.EmpleadoDAOImpl;
import com.consultora.sistema.domain.Empleado;
import com.consultora.sistema.service.EmpleadoService;

public class EmpleadoServiceImpl implements EmpleadoService {

    private final EmpleadoDAO empleadoDAO;

    public EmpleadoServiceImpl() {
        this.empleadoDAO = new EmpleadoDAOImpl();
    }

    @Override
    public List<Empleado> listarEmpleados() {
        return empleadoDAO.listar();
    }

    @Override
    public Empleado buscarPorId(int id) {
        return empleadoDAO.obtenerPorId(id);
    }

    @Override
    public boolean guardar(Empleado empleado) {
        if (empleado.getNombre() == null || empleado.getNombre().trim().isEmpty()) {
            return false;
        }
        return empleadoDAO.insertar(empleado);
    }

    @Override
    public boolean modificar(Empleado empleado) {
        if (empleado.getId() <= 0) {
            return false;
        }
        return empleadoDAO.actualizar(empleado);
    }

    @Override
    public boolean borrar(int id) {
        if (id <= 0) {
            return false;
        }
        return empleadoDAO.eliminar(id);
    }
}