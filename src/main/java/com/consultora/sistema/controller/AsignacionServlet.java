package com.consultora.sistema.controller;

import com.consultora.sistema.domain.AsignacionProyecto;
import com.consultora.sistema.domain.AsignacionTarea;
import com.consultora.sistema.domain.Tarea;
import com.consultora.sistema.service.*;
import com.consultora.sistema.service.impl.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/Asignaciones")
public class AsignacionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final AsignacionProyectoService asignacionProyectoService = new AsignacionProyectoServiceImpl();
    private final AsignacionTareaService asignacionTareaService = new AsignacionTareaServiceImpl();
    private final EmpleadoService empleadoService = new EmpleadoServiceImpl();
    private final ProyectoService proyectoService = new ProyectoServiceImpl();
    private final TareaService tareaService = new TareaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminarProyecto".equals(accion)) {
            int id = parseId(request.getParameter("id"));
            boolean ok = id > 0 && asignacionProyectoService.desasignar(id);
            response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=" + (ok ? "removido" : "error"));
            return;
        }

        if ("eliminarTarea".equals(accion)) {
            int id = parseId(request.getParameter("id"));
            boolean ok = id > 0 && asignacionTareaService.desasignar(id);
            response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=" + (ok ? "removido" : "error"));
            return;
        }

        request.setAttribute("asignacionesProyectos", asignacionProyectoService.listarAsignaciones());
        request.setAttribute("asignacionesTareas", asignacionTareaService.listarAsignaciones());
        request.setAttribute("empleados", empleadoService.listarEmpleados());
        request.setAttribute("proyectos", proyectoService.listarProyectos());
        request.setAttribute("tareas", tareaService.listarTareas());

        request.getRequestDispatcher("/vistas/asignaciones.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String tipo = request.getParameter("tipo");
        int idEmpleado = parseId(request.getParameter("idEmpleado"));

        if (idEmpleado <= 0) {
            response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=error");
            return;
        }

        if ("proyecto".equals(tipo)) {
            int idProyecto = parseId(request.getParameter("idProyecto"));
            if (idProyecto <= 0) {
                response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=error");
                return;
            }
            boolean ok = asignacionProyectoService.asignar(new AsignacionProyecto(0, idEmpleado, idProyecto));
            response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=" + (ok ? "asignado" : "duplicado"));
            return;
        }

        if ("tarea".equals(tipo)) {
            int idTarea = parseId(request.getParameter("idTarea"));
            if (idTarea <= 0) {
                response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=error");
                return;
            }
            Tarea tarea = tareaService.buscarPorId(idTarea);

            if (tarea == null) {
                response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=error");
                return;
            }

            // Para asignar una tarea, el empleado debe pertenecer al proyecto de la tarea.
            if (tarea.getIdProyecto() > 0) {
                List<AsignacionProyecto> equipo = asignacionProyectoService.listarPorProyecto(tarea.getIdProyecto());
                boolean pertenece = equipo.stream().anyMatch(a -> a.getIdEmpleado() == idEmpleado);
                if (!pertenece) {
                    response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=sin-proyecto");
                    return;
                }
            }

            boolean ok = asignacionTareaService.asignar(new AsignacionTarea(0, idEmpleado, idTarea));
            response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=" + (ok ? "asignado" : "duplicado"));
            return;
        }

        response.sendRedirect(request.getContextPath() + "/Asignaciones?ok=error");
    }

    private int parseId(String value) {
        try {
            return value == null ? 0 : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
