package com.consultora.sistema.controller;

import com.consultora.sistema.domain.Tarea;
import com.consultora.sistema.service.TareaService;
import com.consultora.sistema.service.impl.TareaServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Tarea")
public class TareaServlet extends HttpServlet {

    private final TareaService tareaService = new TareaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            tareaService.borrar(id);
            response.sendRedirect(request.getContextPath() + "/Tarea");
            return;
        } else if ("editar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("tareaEditar", tareaService.buscarPorId(id));
        }

        request.setAttribute("tareas", tareaService.listarTareas());
        request.getRequestDispatcher("/vistas/tareas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("id");
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String estado = request.getParameter("estado");

        int id = (idStr != null && !idStr.trim().isEmpty()) ? Integer.parseInt(idStr) : 0;
        Tarea t = new Tarea(id, titulo, descripcion, estado);

        if (id == 0) {
            tareaService.guardar(t);
        } else {
            tareaService.modificar(t);
        }

        response.sendRedirect(request.getContextPath() + "/Tarea");
    }
}