<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Empleado" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>
<%@ page import="com.consultora.sistema.domain.Tarea" %>
<%@ page import="com.consultora.sistema.domain.AsignacionProyecto" %>
<%@ page import="com.consultora.sistema.domain.AsignacionTarea" %>
<%
    @SuppressWarnings("unchecked")
    List<Empleado> empleados = (List<Empleado>) request.getAttribute("empleados");
    @SuppressWarnings("unchecked")
    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");
    @SuppressWarnings("unchecked")
    List<Tarea> tareas = (List<Tarea>) request.getAttribute("tareas");
    @SuppressWarnings("unchecked")
    List<AsignacionProyecto> asignacionesProyectos = (List<AsignacionProyecto>) request.getAttribute("asignacionesProyectos");
    @SuppressWarnings("unchecked")
    List<AsignacionTarea> asignacionesTareas = (List<AsignacionTarea>) request.getAttribute("asignacionesTareas");

    if (empleados == null || proyectos == null || tareas == null
            || asignacionesProyectos == null || asignacionesTareas == null) {
        response.sendRedirect(request.getContextPath() + "/Asignaciones");
        return;
    }

    String ok = request.getParameter("ok");
    String alertClass = null;
    String alertMessage = null;
    if ("asignado".equals(ok)) {
        alertClass = "success";
        alertMessage = "Asignación guardada correctamente.";
    } else if ("removido".equals(ok)) {
        alertClass = "success";
        alertMessage = "Asignación removida correctamente.";
    } else if ("duplicado".equals(ok)) {
        alertClass = "warning";
        alertMessage = "Esa asignación ya existe. No se generó un duplicado.";
    } else if ("sin-proyecto".equals(ok)) {
        alertClass = "warning";
        alertMessage = "Primero asigná al empleado al proyecto de la tarea seleccionada.";
    } else if ("error".equals(ok)) {
        alertClass = "danger";
        alertMessage = "No se pudo completar la operación. Revisá los datos e intentá de nuevo.";
    }

    request.setAttribute("activeNav", "asignaciones");
    request.setAttribute("pageTitle", "Asignaciones");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Coordinación de equipos</p>
        <h1>Asignaciones</h1>
        <p class="muted">Vinculá empleados con proyectos y tareas, sin duplicados.</p>
    </div>
</header>

<% if (alertMessage != null) { %>
<div class="alert <%= alertClass %>">
    <i class="fa-solid <%= "success".equals(alertClass) ? "fa-circle-check" : ("danger".equals(alertClass) ? "fa-circle-exclamation" : "fa-triangle-exclamation") %>"></i>
    <span><%= alertMessage %></span>
</div>
<% } %>

<section class="grid-2">
    <div class="section-card">
        <div class="section-heading">
            <div>
                <h2>Asignar empleado a proyecto</h2>
                <p>Sumá un integrante al equipo de un proyecto.</p>
            </div>
        </div>

        <form action="<%= ctxPath %>/Asignaciones" method="post">
            <input type="hidden" name="tipo" value="proyecto">

            <div class="form-grid">
                <label class="full">
                    Empleado
                    <select name="idEmpleado" required>
                        <option value="">-- Seleccionar empleado --</option>
                        <% for (Empleado e : empleados) { %>
                        <option value="<%= e.getId() %>"><%= e.getNombre() %> <%= e.getApellido() %> · <%= e.getPuesto() %></option>
                        <% } %>
                    </select>
                </label>

                <label class="full">
                    Proyecto
                    <select name="idProyecto" required>
                        <option value="">-- Seleccionar proyecto --</option>
                        <% for (Proyecto p : proyectos) { %>
                        <option value="<%= p.getId() %>"><%= p.getNombre() %></option>
                        <% } %>
                    </select>
                </label>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn primary">
                    <i class="fa-solid fa-plus"></i> Guardar asignación
                </button>
            </div>
        </form>
    </div>

    <div class="section-card">
        <div class="section-heading">
            <div>
                <h2>Asignar empleado a tarea</h2>
                <p>El empleado debe pertenecer al proyecto de la tarea.</p>
            </div>
        </div>

        <form action="<%= ctxPath %>/Asignaciones" method="post">
            <input type="hidden" name="tipo" value="tarea">

            <div class="form-grid">
                <label class="full">
                    Empleado
                    <select name="idEmpleado" required>
                        <option value="">-- Seleccionar empleado --</option>
                        <% for (Empleado e : empleados) { %>
                        <option value="<%= e.getId() %>"><%= e.getNombre() %> <%= e.getApellido() %> · <%= e.getPuesto() %></option>
                        <% } %>
                    </select>
                </label>

                <label>
                    Proyecto
                    <select id="assignTaskProject" required>
                        <option value="">-- Seleccionar proyecto --</option>
                        <% for (Proyecto p : proyectos) { %>
                        <option value="<%= p.getId() %>"><%= p.getNombre() %></option>
                        <% } %>
                    </select>
                </label>

                <label>
                    Tarea
                    <select id="idTarea" name="idTarea" required>
                        <option value="">-- Seleccionar proyecto primero --</option>
                        <% for (Tarea t : tareas) { %>
                        <option value="<%= t.getId() %>" data-project="<%= t.getIdProyecto() %>">
                            <%= t.getTitulo() %><%= t.getNombreProyecto() != null ? " · " + t.getNombreProyecto() : "" %>
                        </option>
                        <% } %>
                    </select>
                </label>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn primary">
                    <i class="fa-solid fa-plus"></i> Asignar tarea
                </button>
            </div>
        </form>
    </div>
</section>

<section class="section-card">
    <div class="section-heading">
        <div>
            <h2>Equipos por proyecto</h2>
            <p><%= asignacionesProyectos.size() %> asignaciones activas.</p>
        </div>
    </div>

    <% if (!asignacionesProyectos.isEmpty()) { %>
    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th>Empleado</th>
                <th>Proyecto</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (AsignacionProyecto ap : asignacionesProyectos) { %>
            <tr>
                <td><strong><%= ap.getNombreEmpleado() %></strong></td>
                <td>
                    <a class="action-link" href="<%= ctxPath %>/Proyecto?accion=detalle&id=<%= ap.getIdProyecto() %>">
                        <i class="fa-solid fa-diagram-project"></i> <%= ap.getNombreProyecto() %>
                    </a>
                </td>
                <td>
                    <a class="icon-link danger"
                       href="<%= ctxPath %>/Asignaciones?accion=eliminarProyecto&id=<%= ap.getId() %>"
                       data-confirm="¿Remover a <%= ap.getNombreEmpleado() %> del proyecto?"
                       title="Remover">
                        <i class="fa-solid fa-user-minus"></i>
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } else { %>
    <div class="empty-state">
        <i class="fa-solid fa-user-group"></i>
        No hay empleados asignados a proyectos todavía.
    </div>
    <% } %>
</section>

<section class="section-card">
    <div class="section-heading">
        <div>
            <h2>Tareas asignadas</h2>
            <p><%= asignacionesTareas.size() %> tareas con responsable.</p>
        </div>
    </div>

    <% if (!asignacionesTareas.isEmpty()) { %>
    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th>Empleado</th>
                <th>Tarea</th>
                <th>Proyecto</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% for (AsignacionTarea at : asignacionesTareas) {
                String tareaBadge = "warning";
                if ("En Progreso".equalsIgnoreCase(at.getEstadoTarea()) || "En curso".equalsIgnoreCase(at.getEstadoTarea())) tareaBadge = "info";
                else if ("Completada".equalsIgnoreCase(at.getEstadoTarea()) || "Finalizada".equalsIgnoreCase(at.getEstadoTarea())) tareaBadge = "success";
            %>
            <tr>
                <td><strong><%= at.getNombreEmpleado() %></strong></td>
                <td><%= at.getTituloTarea() %></td>
                <td>
                    <% if (at.getIdProyecto() > 0) { %>
                    <a class="action-link" href="<%= ctxPath %>/Proyecto?accion=detalle&id=<%= at.getIdProyecto() %>">
                        <i class="fa-solid fa-diagram-project"></i> <%= at.getNombreProyecto() %>
                    </a>
                    <% } else { %>
                    <span class="badge neutral">Sin proyecto</span>
                    <% } %>
                </td>
                <td><span class="badge <%= tareaBadge %>"><%= at.getEstadoTarea() != null ? at.getEstadoTarea() : "Pendiente" %></span></td>
                <td>
                    <a class="icon-link danger"
                       href="<%= ctxPath %>/Asignaciones?accion=eliminarTarea&id=<%= at.getId() %>"
                       data-confirm="¿Remover esta tarea de <%= at.getNombreEmpleado() %>?"
                       title="Remover">
                        <i class="fa-solid fa-user-minus"></i>
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } else { %>
    <div class="empty-state">
        <i class="fa-regular fa-square-check"></i>
        No hay tareas asignadas a empleados todavía.
    </div>
    <% } %>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
