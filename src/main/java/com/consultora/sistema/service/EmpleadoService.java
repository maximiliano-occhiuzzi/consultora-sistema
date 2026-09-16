package com.consultora.sistema.service;


import java.util.List;

import com.consultora.sistema.domain.Empleado;

public interface EmpleadoService {
    List<Empleado> listarEmpleados();
    Empleado buscarPorId(int id);
    boolean guardar(Empleado empleado);
    boolean modificar(Empleado empleado);
    boolean borrar(int id);
}