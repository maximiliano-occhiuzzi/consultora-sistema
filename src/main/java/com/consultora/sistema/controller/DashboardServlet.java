package com.consultora.sistema.controller;

import com.consultora.sistema.domain.AsignacionProyecto;
import com.consultora.sistema.domain.Proyecto;
import com.consultora.sistema.domain.ProyectoResumen;
import com.consultora.sistema.domain.Tarea;
import com.consultora.sistema.service.AsignacionProyectoService;
import com.consultora.sistema.service.EmpleadoService;
import com.consultora.sistema.service.ProyectoService;
import com.consultora.sistema.service.TareaService;
import com.consultora.sistema.service.impl.AsignacionProyectoServiceImpl;
import com.consultora.sistema.service.impl.EmpleadoServiceImpl;
import com.consultora.sistema.service.impl.ProyectoServiceImpl;
import com.consultora.sistema.service.impl.TareaServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/Dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProyectoService proyectoService = new ProyectoServiceImpl();
    private final EmpleadoService empleadoService = new EmpleadoServiceImpl();
    private final TareaService tareaService = new TareaServiceImpl();
    private final AsignacionProyectoService asignacionProyectoService = new AsignacionProyectoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Proyecto> proyectos = proyectoService.listarProyectos();
        List<Tarea> tareas = tareaService.listarTareas();
        List<AsignacionProyecto> asignaciones = asignacionProyectoService.listarAsignaciones();

        Map<Integer, Integer> integrantesPorProyecto = new HashMap<>();
        for (AsignacionProyecto asignacion : asignaciones) {
            integrantesPorProyecto.merge(asignacion.getIdProyecto(), 1, Integer::sum);
        }

        Map<Integer, Integer> tareasPorProyecto = new HashMap<>();
        Map<Integer, Integer> completadasPorProyecto = new HashMap<>();
        int tareasCompletadas = 0;
        int tareasEnProgreso = 0;
        int tareasPendientes = 0;

        for (Tarea tarea : tareas) {
            if (tarea.getIdProyecto() > 0) {
                tareasPorProyecto.merge(tarea.getIdProyecto(), 1, Integer::sum);
                if (tarea.isCompletada()) {
                    completadasPorProyecto.merge(tarea.getIdProyecto(), 1, Integer::sum);
                }
            }
            if (tarea.isCompletada()) {
                tareasCompletadas++;
            } else if (tarea.isEnProgreso()) {
                tareasEnProgreso++;
            } else {
                tareasPendientes++;
            }
        }

        List<ProyectoResumen> resumenes = new ArrayList<>();
        for (Proyecto proyecto : proyectos) {
            int total = tareasPorProyecto.getOrDefault(proyecto.getId(), 0);
            int completadas = completadasPorProyecto.getOrDefault(proyecto.getId(), 0);
            int integrantes = integrantesPorProyecto.getOrDefault(proyecto.getId(), 0);
            resumenes.add(new ProyectoResumen(proyecto, integrantes, total, completadas));
        }

        request.setAttribute("proyectosResumen", resumenes);
        request.setAttribute("cantEmpleados", empleadoService.listarEmpleados().size());
        request.setAttribute("cantProyectos", proyectos.size());
        request.setAttribute("cantTareas", tareas.size());
        request.setAttribute("cantTareasCompletadas", tareasCompletadas);
        request.setAttribute("cantTareasEnProgreso", tareasEnProgreso);
        request.setAttribute("cantTareasPendientes", tareasPendientes);
        request.setAttribute("cantAsignaciones", asignaciones.size());

        request.getRequestDispatcher("/vistas/index.jsp").forward(request, response);
    }
}
