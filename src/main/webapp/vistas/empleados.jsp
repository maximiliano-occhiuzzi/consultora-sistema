<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Empleado" %>
<%
    @SuppressWarnings("unchecked")
    List<Empleado> empleados = (List<Empleado>) request.getAttribute("empleados");
    if (empleados == null) {
        response.sendRedirect(request.getContextPath() + "/Empleado");
        return;
    }
    Empleado empEditar = (Empleado) request.getAttribute("empleadoEditar");

    request.setAttribute("activeNav", "empleados");
    request.setAttribute("pageTitle", "Empleados");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Personal técnico</p>
        <h1>Empleados</h1>
        <p class="muted">Administrá los integrantes de la consultora y sus roles.</p>
    </div>
    <a class="btn primary" href="#registrar">
        <i class="fa-solid fa-user-plus"></i> Registrar empleado
    </a>
</header>

<section class="toolbar">
    <div class="search">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input id="employeeSearch" type="text" placeholder="Buscar empleado por nombre, email o puesto...">
    </div>
    <a class="btn secondary" href="<%= ctxPath %>/Empleado?accion=disponibilidad">
        <i class="fa-solid fa-user-clock"></i> Ver disponibilidad
    </a>
</section>

<section class="section-card">
    <div class="table-wrap">
        <table id="employeesTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Empleado</th>
                <th>Puesto / Rol</th>
                <th>Email</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% if (!empleados.isEmpty()) {
                for (Empleado e : empleados) {
                    String iniciales = "";
                    if (e.getNombre() != null && !e.getNombre().isEmpty()) iniciales += e.getNombre().substring(0, 1);
                    if (e.getApellido() != null && !e.getApellido().isEmpty()) iniciales += e.getApellido().substring(0, 1);
            %>
            <tr>
                <td>#<%= e.getId() %></td>
                <td>
                    <div class="person">
                        <div class="avatar"><%= iniciales.toUpperCase() %></div>
                        <div>
                            <strong><%= e.getNombre() %> <%= e.getApellido() %></strong>
                            <small><%= e.getEmail() != null ? e.getEmail() : "-" %></small>
                        </div>
                    </div>
                </td>
                <td><span class="badge info"><%= e.getPuesto() != null ? e.getPuesto() : "Sin especificar" %></span></td>
                <td><%= e.getEmail() != null ? e.getEmail() : "-" %></td>
                <td>
                    <div class="row-actions">
                        <a class="icon-link" href="<%= ctxPath %>/Empleado?accion=editar&id=<%= e.getId() %>" title="Editar">
                            <i class="fa-solid fa-pen"></i>
                        </a>
                        <a class="icon-link danger"
                           href="<%= ctxPath %>/Empleado?accion=eliminar&id=<%= e.getId() %>"
                           data-confirm="¿Eliminar a <%= e.getNombre() %> <%= e.getApellido() %>? También se borrarán sus asignaciones."
                           title="Eliminar">
                            <i class="fa-solid fa-trash"></i>
                        </a>
                    </div>
                </td>
            </tr>
            <%  }
            } else { %>
            <tr>
                <td colspan="5">
                    <div class="empty-state">
                        <i class="fa-regular fa-user"></i>
                        No hay empleados registrados. Usá el formulario de abajo para crear el primero.
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</section>

<section class="form-card" id="registrar">
    <div class="section-heading">
        <div>
            <h2><%= empEditar != null ? "Editar empleado" : "Registrar nuevo empleado" %></h2>
            <p>Completá los datos del integrante del equipo.</p>
        </div>
        <% if (empEditar != null) { %>
        <a class="btn secondary small" href="<%= ctxPath %>/Empleado">
            <i class="fa-solid fa-xmark"></i> Cancelar edición
        </a>
        <% } %>
    </div>

    <form action="<%= ctxPath %>/Empleado" method="post">
        <input type="hidden" name="id" value="<%= empEditar != null ? empEditar.getId() : 0 %>">

        <div class="form-grid">
            <label>
                Nombre *
                <input type="text" name="nombre" value="<%= empEditar != null && empEditar.getNombre() != null ? empEditar.getNombre() : "" %>" placeholder="Ej. Martín" required>
            </label>

            <label>
                Apellido *
                <input type="text" name="apellido" value="<%= empEditar != null && empEditar.getApellido() != null ? empEditar.getApellido() : "" %>" placeholder="Ej. Díaz" required>
            </label>

            <label>
                Correo electrónico *
                <input type="email" name="email" value="<%= empEditar != null && empEditar.getEmail() != null ? empEditar.getEmail() : "" %>" placeholder="correo@consultora.com" required>
            </label>

            <label>
                Puesto / Rol *
                <% String puestoSel = empEditar != null && empEditar.getPuesto() != null ? empEditar.getPuesto() : ""; %>
                <select name="puesto" required>
                    <option value="">Seleccionar rol</option>
                    <option value="Backend" <%= "Backend".equals(puestoSel) ? "selected" : "" %>>Backend</option>
                    <option value="Frontend" <%= "Frontend".equals(puestoSel) ? "selected" : "" %>>Frontend</option>
                    <option value="Diseñador" <%= "Diseñador".equals(puestoSel) ? "selected" : "" %>>Diseñador</option>
                    <option value="DevOps" <%= "DevOps".equals(puestoSel) ? "selected" : "" %>>DevOps</option>
                    <option value="QA / Tester" <%= "QA / Tester".equals(puestoSel) ? "selected" : "" %>>QA / Tester</option>
                    <option value="Analista Funcional" <%= "Analista Funcional".equals(puestoSel) ? "selected" : "" %>>Analista Funcional</option>
                    <option value="Desarrollador Senior" <%= "Desarrollador Senior".equals(puestoSel) ? "selected" : "" %>>Desarrollador Senior</option>
                </select>
            </label>
        </div>

        <div class="form-actions">
            <a href="<%= ctxPath %>/Empleado" class="btn secondary">Limpiar</a>
            <button type="submit" class="btn primary">
                <i class="fa-solid fa-floppy-disk"></i> <%= empEditar != null ? "Guardar cambios" : "Guardar empleado" %>
            </button>
        </div>
    </form>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
