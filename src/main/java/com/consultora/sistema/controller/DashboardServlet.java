package com.consultora.sistema.controller;

import com.consultora.sistema.service.EmpleadoService;
import com.consultora.sistema.service.ProyectoService;
import com.consultora.sistema.service.TareaService;
import com.consultora.sistema.service.impl.EmpleadoServiceImpl;
import com.consultora.sistema.service.impl.ProyectoServiceImpl;
import com.consultora.sistema.service.impl.TareaServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Dashboard")
public class DashboardServlet extends HttpServlet {

    private final ProyectoService proyectoService = new ProyectoServiceImpl();
    private final EmpleadoService empleadoService = new EmpleadoServiceImpl();
    private final TareaService tareaService = new TareaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("proyectos", proyectoService.listarProyectos());
        request.setAttribute("cantEmpleados", empleadoService.listarEmpleados().size());
        request.setAttribute("cantTareas", tareaService.listarTareas().size());
        
        request.getRequestDispatcher("/vistas/index.jsp").forward(request, response);
    }
}