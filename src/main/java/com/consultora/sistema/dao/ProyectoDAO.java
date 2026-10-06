package com.consultora.sistema.dao;

import com.consultora.sistema.domain.Proyecto;
import java.util.List;

public interface ProyectoDAO {
    List<Proyecto> listar();
    Proyecto obtenerPorId(int id);
    boolean insertar(Proyecto proyecto);
    boolean actualizar(Proyecto proyecto);
    boolean eliminar(int id);
}