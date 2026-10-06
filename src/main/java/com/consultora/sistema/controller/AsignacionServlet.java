package com.consultora.sistema.controller;

import com.consultora.sistema.domain.AsignacionProyecto;
import com.consultora.sistema.domain.AsignacionTarea;
import com.consultora.sistema.service.*;
import com.consultora.sistema.service.impl.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Asignaciones")
public class AsignacionServlet extends HttpServlet {

    private final AsignacionProyectoService asignacionProyectoService = new AsignacionProyectoServiceImpl();
    private final AsignacionTareaService asignacionTareaService = new AsignacionTareaServiceImpl();
    private final EmpleadoService empleadoService = new EmpleadoServiceImpl();
    private final ProyectoService proyectoService = new ProyectoServiceImpl();
    private final TareaService tareaService = new TareaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String tipo = request.getParameter("tipo");
        String accion = request.getParameter("accion");

        if ("eliminarProyecto".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            asignacionProyectoService.desasignar(id);
            response.sendRedirect(request.getContextPath() + "/Asignaciones");
            return;
        } else if ("eliminarTarea".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            asignacionTareaService.desasignar(id);
            response.sendRedirect(request.getContextPath() + "/Asignaciones");
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
        
        String tipo = request.getParameter("tipo");
        int idEmpleado = Integer.parseInt(request.getParameter("idEmpleado"));

        if ("proyecto".equals(tipo)) {
            int idProyecto = Integer.parseInt(request.getParameter("idProyecto"));
            asignacionProyectoService.asignar(new AsignacionProyecto(0, idEmpleado, idProyecto));
        } else if ("tarea".equals(tipo)) {
            int idTarea = Integer.parseInt(request.getParameter("idTarea"));
            asignacionTareaService.asignar(new AsignacionTarea(0, idEmpleado, idTarea));
        }

        response.sendRedirect(request.getContextPath() + "/Asignaciones");
    }
}