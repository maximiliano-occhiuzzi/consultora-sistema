package com.consultora.sistema.controller;

import com.consultora.sistema.domain.AsignacionProyecto;
import com.consultora.sistema.domain.AsignacionTarea;
import com.consultora.sistema.domain.Empleado;
import com.consultora.sistema.service.AsignacionProyectoService;
import com.consultora.sistema.service.AsignacionTareaService;
import com.consultora.sistema.service.EmpleadoService;
import com.consultora.sistema.service.impl.AsignacionProyectoServiceImpl;
import com.consultora.sistema.service.impl.AsignacionTareaServiceImpl;
import com.consultora.sistema.service.impl.EmpleadoServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/Empleado")
public class EmpleadoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final EmpleadoService empleadoService = new EmpleadoServiceImpl();
    private final AsignacionProyectoService asignacionProyectoService = new AsignacionProyectoServiceImpl();
    private final AsignacionTareaService asignacionTareaService = new AsignacionTareaServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            int id = parseId(request.getParameter("id"));
            if (id > 0) {
                empleadoService.borrar(id);
            }
            response.sendRedirect(request.getContextPath() + "/Empleado");
            return;
        }

        if ("editar".equals(accion)) {
            int id = parseId(request.getParameter("id"));
            request.setAttribute("empleadoEditar", empleadoService.buscarPorId(id));
            request.setAttribute("empleados", empleadoService.listarEmpleados());
            request.getRequestDispatcher("/vistas/empleados.jsp").forward(request, response);
            return;
        }

        if ("disponibilidad".equals(accion)) {
            List<Empleado> empleados = empleadoService.listarEmpleados();
            Map<Integer, Integer> proyectosPorEmpleado = new HashMap<>();
            Map<Integer, Integer> tareasPorEmpleado = new HashMap<>();

            for (AsignacionProyecto asignacion : asignacionProyectoService.listarAsignaciones()) {
                proyectosPorEmpleado.merge(asignacion.getIdEmpleado(), 1, Integer::sum);
            }
            for (AsignacionTarea asignacion : asignacionTareaService.listarAsignaciones()) {
                tareasPorEmpleado.merge(asignacion.getIdEmpleado(), 1, Integer::sum);
            }

            request.setAttribute("empleados", empleados);
            request.setAttribute("proyectosPorEmpleado", proyectosPorEmpleado);
            request.setAttribute("tareasPorEmpleado", tareasPorEmpleado);
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

        int id = parseId(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String puesto = request.getParameter("puesto");

        Empleado emp = new Empleado(id, nombre, apellido, email, puesto);

        if (id == 0) {
            empleadoService.guardar(emp);
        } else {
            empleadoService.modificar(emp);
        }

        response.sendRedirect(request.getContextPath() + "/Empleado");
    }

    private int parseId(String value) {
        try {
            return value == null ? 0 : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
