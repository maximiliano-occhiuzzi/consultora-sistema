package com.consultora.sistema.controller;

import com.consultora.sistema.domain.Tarea;
import com.consultora.sistema.service.ProyectoService;
import com.consultora.sistema.service.TareaService;
import com.consultora.sistema.service.impl.ProyectoServiceImpl;
import com.consultora.sistema.service.impl.TareaServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Tarea")
public class TareaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final TareaService tareaService = new TareaServiceImpl();
    private final ProyectoService proyectoService = new ProyectoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            int id = parseId(request.getParameter("id"));
            if (id > 0) {
                tareaService.borrar(id);
            }
            response.sendRedirect(request.getContextPath() + "/Tarea");
            return;
        }

        if ("editar".equals(accion)) {
            int id = parseId(request.getParameter("id"));
            request.setAttribute("tareaEditar", tareaService.buscarPorId(id));
        }

        int idProyecto = parseId(request.getParameter("idProyecto"));
        if (idProyecto > 0) {
            request.setAttribute("tareas", tareaService.listarTareasPorProyecto(idProyecto));
            request.setAttribute("filtroProyecto", idProyecto);
        } else {
            request.setAttribute("tareas", tareaService.listarTareas());
        }
        request.setAttribute("proyectos", proyectoService.listarProyectos());

        request.getRequestDispatcher("/vistas/tareas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int id = parseId(request.getParameter("id"));
        int idProyecto = parseId(request.getParameter("idProyecto"));
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String estado = request.getParameter("estado");

        Tarea t = new Tarea(id, titulo, descripcion, estado, idProyecto);

        if (id == 0) {
            tareaService.guardar(t);
        } else {
            tareaService.modificar(t);
        }

        String destino = request.getContextPath() + "/Tarea";
        if (idProyecto > 0) {
            destino += "?idProyecto=" + idProyecto;
        }
        response.sendRedirect(destino);
    }

    private int parseId(String value) {
        try {
            return value == null ? 0 : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
