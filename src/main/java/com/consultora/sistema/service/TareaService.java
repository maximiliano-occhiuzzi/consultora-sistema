package com.consultora.sistema.service;

import com.consultora.sistema.domain.Tarea;
import java.util.List;

public interface TareaService {
    List<Tarea> listarTareas();
    Tarea buscarPorId(int id);
    boolean guardar(Tarea tarea);
    boolean modificar(Tarea tarea);
    boolean borrar(int id);
}