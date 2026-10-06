package com.consultora.sistema.service;

import com.consultora.sistema.domain.Proyecto;
import java.util.List;

public interface ProyectoService {
    List<Proyecto> listarProyectos();
    Proyecto buscarPorId(int id);
    boolean guardar(Proyecto proyecto);
    boolean modificar(Proyecto proyecto);
    boolean borrar(int id);
}