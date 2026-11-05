package com.consultora.sistema.controller;

import com.consultora.sistema.domain.Proyecto;
import com.consultora.sistema.service.AsignacionProyectoService;
import com.consultora.sistema.service.ProyectoService;
import com.consultora.sistema.service.TareaService;
import com.consultora.sistema.service.impl.AsignacionProyectoServiceImpl;
import com.consultora.sistema.service.impl.ProyectoServiceImpl;
import com.consultora.sistema.service.impl.TareaServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Proyecto")
public class ProyectoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProyectoService proyectoService = new ProyectoServiceImpl();
    private final TareaService tareaService = new TareaServiceImpl();
    private final AsignacionProyectoService asignacionProyectoService = new AsignacionProyectoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("detalle".equals(accion)) {
            int id = parseId(request.getParameter("id"));
            Proyecto proyecto = proyectoService.buscarPorId(id);
            if (proyecto == null) {
                response.sendRedirect(request.getContextPath() + "/Proyecto?error=no-encontrado");
                return;
            }
            request.setAttribute("proyecto", proyecto);
            request.setAttribute("asignacionesProyecto", asignacionProyectoService.listarPorProyecto(id));
            request.setAttribute("tareasProyecto", tareaService.listarTareasPorProyecto(id));
            request.getRequestDispatcher("/vistas/proyecto-detalle.jsp").forward(request, response);
            return;
        }

        if ("nuevo".equals(accion)) {
            request.getRequestDispatcher("/vistas/crear-proyecto.jsp").forward(request, response);
            return;
        }

        if ("configuracion".equals(accion)) {
            request.setAttribute("proyectos", proyectoService.listarProyectos());
            request.getRequestDispatcher("/vistas/configuracion.jsp").forward(request, response);
            return;
        }

        if ("eliminar".equals(accion)) {
            int id = parseId(request.getParameter("id"));
            if (id > 0) {
                proyectoService.borrar(id);
            }
            response.sendRedirect(request.getContextPath() + "/Proyecto");
            return;
        }

        request.setAttribute("proyectos", proyectoService.listarProyectos());
        request.getRequestDispatcher("/vistas/proyectos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int id = parseId(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String estado = request.getParameter("estado");

        Proyecto p = new Proyecto(id, nombre, descripcion, estado);

        if (id == 0) {
            proyectoService.guardar(p);
        } else {
            proyectoService.modificar(p);
        }

        response.sendRedirect(request.getContextPath() + "/Proyecto");
    }

    private int parseId(String value) {
        try {
            return value == null ? 0 : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
