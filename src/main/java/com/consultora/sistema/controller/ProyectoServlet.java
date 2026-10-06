package com.consultora.sistema.controller;

import com.consultora.sistema.domain.Proyecto;
import com.consultora.sistema.service.ProyectoService;
import com.consultora.sistema.service.impl.ProyectoServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Proyecto")
public class ProyectoServlet extends HttpServlet {

    private final ProyectoService proyectoService = new ProyectoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("detalle".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("proyecto", proyectoService.buscarPorId(id));
            request.getRequestDispatcher("/vistas/proyecto-detalle.jsp").forward(request, response);
            return;
        } else if ("nuevo".equals(accion)) {
            request.getRequestDispatcher("/vistas/crear-proyecto.jsp").forward(request, response);
            return;
        } else if ("configuracion".equals(accion)) {
            request.getRequestDispatcher("/vistas/configuracion.jsp").forward(request, response);
            return;
        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            proyectoService.borrar(id);
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
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String estado = request.getParameter("estado");

        int id = (idStr != null && !idStr.trim().isEmpty()) ? Integer.parseInt(idStr) : 0;
        Proyecto p = new Proyecto(id, nombre, descripcion, estado);

        if (id == 0) {
            proyectoService.guardar(p);
        } else {
            proyectoService.modificar(p);
        }

        response.sendRedirect(request.getContextPath() + "/Proyecto");
    }
}