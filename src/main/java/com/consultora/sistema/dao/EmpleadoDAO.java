package com.consultora.sistema.dao;


import java.util.List;

import com.consultora.sistema.domain.Empleado;

public interface EmpleadoDAO {
    List<Empleado> listar();
    Empleado obtenerPorId(int id);
    boolean insertar(Empleado empleado);
    boolean actualizar(Empleado empleado);
    boolean eliminar(int id);
}