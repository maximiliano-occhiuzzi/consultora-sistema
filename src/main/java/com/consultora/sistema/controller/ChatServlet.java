package com.consultora.sistema.controller;

import com.consultora.sistema.service.EmpleadoService;
import com.consultora.sistema.service.ProyectoService;
import com.consultora.sistema.service.impl.EmpleadoServiceImpl;
import com.consultora.sistema.service.impl.ProyectoServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Chat")
public class ChatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final EmpleadoService empleadoService = new EmpleadoServiceImpl();
    private final ProyectoService proyectoService = new ProyectoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("empleados", empleadoService.listarEmpleados());
        request.setAttribute("proyectos", proyectoService.listarProyectos());
        request.getRequestDispatcher("/vistas/chat.jsp").forward(request, response);
    }
}
