package com.consultora.sistema.controller;

import com.consultora.sistema.domain.Empleado;
import com.consultora.sistema.service.EmpleadoService;
import com.consultora.sistema.service.impl.EmpleadoServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Empleado")
public class EmpleadoServlet extends HttpServlet {

    private final EmpleadoService empleadoService = new EmpleadoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            empleadoService.borrar(id);
            response.sendRedirect(request.getContextPath() + "/Empleado");
            return;
        } else if ("disponibilidad".equals(accion)) {
            request.setAttribute("empleados", empleadoService.listarEmpleados());
            request.getRequestDispatcher("/vistas/disponibilidad.jsp").forward(request, response);
            return;
        }

        request.setAttribute("empleados", empleadoService.listarEmpleados());
        request.getRequestDispatcher("/vistas/empleados.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String puesto = request.getParameter("puesto");

        int id = (idStr != null && !idStr.trim().isEmpty()) ? Integer.parseInt(idStr) : 0;
        Empleado emp = new Empleado(id, nombre, apellido, email, puesto);

        if (id == 0) {
            empleadoService.guardar(emp);
        } else {
            empleadoService.modificar(emp);
        }

        response.sendRedirect(request.getContextPath() + "/Empleado");
    }
}