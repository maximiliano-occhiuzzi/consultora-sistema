<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.consultora.sistema.domain.Empleado" %>
<%
    @SuppressWarnings("unchecked")
    List<Empleado> empleados = (List<Empleado>) request.getAttribute("empleados");
    @SuppressWarnings("unchecked")
    Map<Integer, Integer> proyectosPorEmpleado = (Map<Integer, Integer>) request.getAttribute("proyectosPorEmpleado");
    @SuppressWarnings("unchecked")
    Map<Integer, Integer> tareasPorEmpleado = (Map<Integer, Integer>) request.getAttribute("tareasPorEmpleado");

    if (empleados == null || proyectosPorEmpleado == null || tareasPorEmpleado == null) {
        response.sendRedirect(request.getContextPath() + "/Empleado?accion=disponibilidad");
        return;
    }

    int disponibles = 0;
    int asignados = 0;
    int cargaAlta = 0;
    int totalTareasAsignadas = 0;

    for (Empleado e : empleados) {
        int proyectos = proyectosPorEmpleado.getOrDefault(e.getId(), 0);
        totalTareasAsignadas += tareasPorEmpleado.getOrDefault(e.getId(), 0);
        if (proyectos == 0) disponibles++;
        else if (proyectos == 1) asignados++;
        else cargaAlta++;
    }

    request.setAttribute("activeNav", "disponibilidad");
    request.setAttribute("pageTitle", "Disponibilidad");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Personal</p>
        <h1>Disponibilidad</h1>
        <p class="muted">Carga real de cada empleado según sus proyectos y tareas asignadas.</p>
    </div>
    <a class="btn secondary" href="<%= ctxPath %>/Empleado">
        <i class="fa-solid fa-users"></i> Ver empleados
    </a>
</header>

<section class="stats-grid">
    <div class="stat-card">
        <span class="stat-icon green"><i class="fa-solid fa-circle-check"></i></span>
        <div>
            <span class="stat-label">Disponibles</span>
            <strong><%= disponibles %></strong>
            <span class="stat-hint">Sin proyectos asignados</span>
        </div>
    </div>
    <div class="stat-card">
        <span class="stat-icon blue"><i class="fa-solid fa-user-check"></i></span>
        <div>
            <span class="stat-label">Con un proyecto</span>
            <strong><%= asignados %></strong>
            <span class="stat-hint">Carga normal</span>
        </div>
    </div>
    <div class="stat-card">
        <span class="stat-icon orange"><i class="fa-solid fa-triangle-exclamation"></i></span>
        <div>
            <span class="stat-label">Carga alta</span>
            <strong><%= cargaAlta %></strong>
            <span class="stat-hint">Dos o más proyectos</span>
        </div>
    </div>
    <div class="stat-card">
        <span class="stat-icon purple"><i class="fa-solid fa-tasks"></i></span>
        <div>
            <span class="stat-label">Tareas asignadas</span>
            <strong><%= totalTareasAsignadas %></strong>
            <span class="stat-hint">En todos los empleados</span>
        </div>
    </div>
</section>

<section class="toolbar">
    <div class="search">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input id="employeeSearch" type="text" placeholder="Buscar empleado por nombre, rol o disponibilidad...">
    </div>
</section>

<section class="section-card">
    <div class="table-wrap">
        <table id="employeesTable">
            <thead>
            <tr>
                <th>Empleado</th>
                <th>Rol</th>
                <th>Proyectos activos</th>
                <th>Tareas asignadas</th>
                <th>Disponibilidad</th>
            </tr>
            </thead>
            <tbody>
            <% if (!empleados.isEmpty()) {
                for (Empleado e : empleados) {
                    int proyectos = proyectosPorEmpleado.getOrDefault(e.getId(), 0);
                    int tareasEmpleado = tareasPorEmpleado.getOrDefault(e.getId(), 0);
                    String iniciales = (e.getNombre() != null && !e.getNombre().isEmpty() ? e.getNombre().substring(0, 1) : "")
                            + (e.getApellido() != null && !e.getApellido().isEmpty() ? e.getApellido().substring(0, 1) : "");

                    String disponibilidad;
                    String badgeClass;
                    if (proyectos == 0) {
                        disponibilidad = "Disponible";
                        badgeClass = "success";
                    } else if (proyectos == 1) {
                        disponibilidad = "Asignado";
                        badgeClass = "info";
                    } else {
                        disponibilidad = "Carga alta";
                        badgeClass = "warning";
                    }
            %>
            <tr>
                <td>
                    <div class="person">
                        <div class="avatar"><%= iniciales.toUpperCase() %></div>
                        <div>
                            <strong><%= e.getNombre() %> <%= e.getApellido() %></strong>
                            <small><%= e.getEmail() != null ? e.getEmail() : "-" %></small>
                        </div>
                    </div>
                </td>
                <td><span class="badge neutral"><%= e.getPuesto() != null ? e.getPuesto() : "Sin rol" %></span></td>
                <td><%= proyectos %></td>
                <td><%= tareasEmpleado %></td>
                <td><span class="badge <%= badgeClass %>"><%= disponibilidad %></span></td>
            </tr>
            <%  }
            } else { %>
            <tr>
                <td colspan="5">
                    <div class="empty-state">
                        <i class="fa-regular fa-user"></i>
                        No hay empleados registrados.
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
