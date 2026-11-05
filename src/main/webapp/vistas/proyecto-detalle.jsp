<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>
<%@ page import="com.consultora.sistema.domain.Tarea" %>
<%@ page import="com.consultora.sistema.domain.AsignacionProyecto" %>
<%
    Proyecto p = (Proyecto) request.getAttribute("proyecto");
    if (p == null) {
        response.sendRedirect(request.getContextPath() + "/Proyecto");
        return;
    }

    @SuppressWarnings("unchecked")
    List<AsignacionProyecto> equipo = (List<AsignacionProyecto>) request.getAttribute("asignacionesProyecto");
    @SuppressWarnings("unchecked")
    List<Tarea> tareas = (List<Tarea>) request.getAttribute("tareasProyecto");

    int totalTareas = tareas != null ? tareas.size() : 0;
    int completadas = 0;
    if (tareas != null) {
        for (Tarea t : tareas) {
            if (t.isCompletada()) completadas++;
        }
    }
    int progreso = totalTareas == 0 ? 0 : (completadas * 100) / totalTareas;
    int integrantes = equipo != null ? equipo.size() : 0;

    String estado = p.getEstado() != null ? p.getEstado() : "Planificado";
    String badgeClass = "info";
    if ("En curso".equalsIgnoreCase(estado)) badgeClass = "success";
    else if ("Pausado".equalsIgnoreCase(estado)) badgeClass = "warning";
    else if ("Finalizado".equalsIgnoreCase(estado)) badgeClass = "neutral";

    request.setAttribute("activeNav", "proyectos");
    request.setAttribute("pageTitle", p.getNombre());
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<a class="action-link" href="<%= ctxPath %>/Proyecto">
    <i class="fa-solid fa-arrow-left"></i> Volver a proyectos
</a>

<header class="topbar" style="margin-top: 1rem;">
    <div>
        <p class="eyebrow">Detalle del proyecto</p>
        <div style="display: flex; align-items: center; gap: 0.75rem; flex-wrap: wrap;">
            <h1><%= p.getNombre() %></h1>
            <span class="badge <%= badgeClass %>"><%= estado %></span>
        </div>
        <p class="muted"><%= p.getDescripcion() != null && !p.getDescripcion().trim().isEmpty() ? p.getDescripcion() : "Sin descripción." %></p>
    </div>
    <div style="display: flex; gap: 0.6rem; flex-wrap: wrap;">
        <a class="btn secondary" href="<%= ctxPath %>/Asignaciones">
            <i class="fa-solid fa-list-check"></i> Gestionar equipo
        </a>
        <a class="btn danger-outline"
           href="<%= ctxPath %>/Proyecto?accion=eliminar&id=<%= p.getId() %>"
           data-confirm="¿Eliminar el proyecto '<%= p.getNombre() %>'? Se eliminarán también sus tareas y asignaciones.">
            <i class="fa-solid fa-trash"></i> Eliminar
        </a>
    </div>
</header>

<section class="stats-grid">
    <div class="stat-card">
        <span class="stat-icon blue"><i class="fa-solid fa-users"></i></span>
        <div>
            <span class="stat-label">Integrantes</span>
            <strong><%= integrantes %></strong>
            <span class="stat-hint">Asignados al proyecto</span>
        </div>
    </div>
    <div class="stat-card">
        <span class="stat-icon orange"><i class="fa-solid fa-tasks"></i></span>
        <div>
            <span class="stat-label">Tareas</span>
            <strong><%= totalTareas %></strong>
            <span class="stat-hint"><%= completadas %> completadas</span>
        </div>
    </div>
    <div class="stat-card">
        <span class="stat-icon green"><i class="fa-solid fa-chart-line"></i></span>
        <div>
            <span class="stat-label">Progreso</span>
            <strong><%= progreso %>%</strong>
            <span class="stat-hint">Según tareas completadas</span>
        </div>
    </div>
</section>

<section class="two-columns">
    <div class="section-card">
        <div class="section-heading">
            <div>
                <h2>Equipo del proyecto</h2>
                <p>Empleados actualmente asignados.</p>
            </div>
        </div>

        <% if (equipo != null && !equipo.isEmpty()) { %>
        <div class="activity-list">
            <% for (AsignacionProyecto a : equipo) {
                String nombre = a.getNombreEmpleado() != null ? a.getNombreEmpleado() : "Empleado";
                String iniciales = nombre.length() >= 2 ? nombre.substring(0, 2).toUpperCase() : nombre.toUpperCase();
            %>
            <div class="activity" style="justify-content: space-between;">
                <div class="person">
                    <div class="avatar"><%= iniciales %></div>
                    <div>
                        <strong><%= nombre %></strong>
                        <small>Asignado al proyecto</small>
                    </div>
                </div>
                <a class="icon-link danger"
                   href="<%= ctxPath %>/Asignaciones?accion=eliminarProyecto&id=<%= a.getId() %>"
                   data-confirm="¿Remover a <%= nombre %> del proyecto?"
                   title="Remover">
                    <i class="fa-solid fa-user-minus"></i>
                </a>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="empty-state">
            <i class="fa-solid fa-user-group"></i>
            Todavía no hay integrantes asignados.
        </div>
        <% } %>
    </div>

    <div class="section-card">
        <div class="section-heading">
            <div>
                <h2>Avance de tareas</h2>
                <p>Seguimiento de las tareas del proyecto.</p>
            </div>
            <a class="action-link" href="<%= ctxPath %>/Tarea?idProyecto=<%= p.getId() %>">Ver tareas</a>
        </div>

        <div class="progress-container" style="margin-bottom: 1.1rem;">
            <div class="progress"><i style="width: <%= progreso %>%"></i></div>
            <small><%= progreso %>%</small>
        </div>

        <% if (tareas != null && !tareas.isEmpty()) { %>
        <div class="activity-list">
            <% for (Tarea t : tareas) {
                String tareaBadge = "warning";
                if (t.isEnProgreso()) tareaBadge = "info";
                else if (t.isCompletada()) tareaBadge = "success";
            %>
            <div class="activity" style="justify-content: space-between;">
                <div>
                    <strong><%= t.getTitulo() %></strong>
                    <small><%= t.getDescripcion() != null ? t.getDescripcion() : "Sin descripción" %></small>
                </div>
                <span class="badge <%= tareaBadge %>"><%= t.getEstado() != null ? t.getEstado() : "Pendiente" %></span>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="empty-state">
            <i class="fa-regular fa-square-check"></i>
            Este proyecto todavía no tiene tareas.
        </div>
        <% } %>
    </div>
</section>

<section class="form-card">
    <div class="section-heading">
        <div>
            <h2>Información del proyecto</h2>
            <p>Modificá los datos y guardá los cambios.</p>
        </div>
    </div>

    <form action="<%= ctxPath %>/Proyecto" method="post">
        <input type="hidden" name="id" value="<%= p.getId() %>">

        <div class="form-grid">
            <label class="full">
                Nombre del proyecto
                <input type="text" name="nombre" value="<%= p.getNombre() %>" required>
            </label>

            <label>
                Estado
                <select name="estado" required>
                    <option value="Planificado" <%= "Planificado".equalsIgnoreCase(p.getEstado()) ? "selected" : "" %>>Planificado</option>
                    <option value="En curso" <%= "En curso".equalsIgnoreCase(p.getEstado()) ? "selected" : "" %>>En curso</option>
                    <option value="Pausado" <%= "Pausado".equalsIgnoreCase(p.getEstado()) ? "selected" : "" %>>Pausado</option>
                    <option value="Finalizado" <%= "Finalizado".equalsIgnoreCase(p.getEstado()) ? "selected" : "" %>>Finalizado</option>
                </select>
            </label>

            <label class="full">
                Descripción
                <textarea name="descripcion"><%= p.getDescripcion() != null ? p.getDescripcion() : "" %></textarea>
            </label>
        </div>

        <div class="form-actions">
            <a href="<%= ctxPath %>/Proyecto" class="btn secondary">Cancelar</a>
            <button type="submit" class="btn primary">
                <i class="fa-solid fa-floppy-disk"></i> Guardar cambios
            </button>
        </div>
    </form>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
