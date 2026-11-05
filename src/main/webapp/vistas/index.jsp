<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.ProyectoResumen" %>
<%
    @SuppressWarnings("unchecked")
    List<ProyectoResumen> proyectosResumen = (List<ProyectoResumen>) request.getAttribute("proyectosResumen");
    if (proyectosResumen == null) {
        response.sendRedirect(request.getContextPath() + "/Dashboard");
        return;
    }

    Integer cantEmpleados = (Integer) request.getAttribute("cantEmpleados");
    Integer cantProyectos = (Integer) request.getAttribute("cantProyectos");
    Integer cantTareas = (Integer) request.getAttribute("cantTareas");
    Integer cantTareasCompletadas = (Integer) request.getAttribute("cantTareasCompletadas");
    Integer cantTareasEnProgreso = (Integer) request.getAttribute("cantTareasEnProgreso");
    Integer cantTareasPendientes = (Integer) request.getAttribute("cantTareasPendientes");
    Integer cantAsignaciones = (Integer) request.getAttribute("cantAsignaciones");

    request.setAttribute("activeNav", "inicio");
    request.setAttribute("pageTitle", "Inicio");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Panel de control</p>
        <h1>Bienvenido, <%= usuarioHeader %></h1>
        <p class="muted">Resumen real del estado de la consultora.</p>
    </div>
    <a class="btn primary" href="<%= ctxPath %>/Proyecto?accion=nuevo">
        <i class="fa-solid fa-plus"></i> Nuevo proyecto
    </a>
</header>

<section class="stats-grid">
    <div class="stat-card">
        <span class="stat-icon blue"><i class="fa-solid fa-users"></i></span>
        <div>
            <span class="stat-label">Empleados</span>
            <strong><%= cantEmpleados != null ? cantEmpleados : 0 %></strong>
            <span class="stat-hint"><%= cantAsignaciones != null ? cantAsignaciones : 0 %> asignaciones a proyectos</span>
        </div>
    </div>

    <div class="stat-card">
        <span class="stat-icon purple"><i class="fa-solid fa-diagram-project"></i></span>
        <div>
            <span class="stat-label">Proyectos</span>
            <strong><%= cantProyectos != null ? cantProyectos : 0 %></strong>
            <span class="stat-hint">En seguimiento</span>
        </div>
    </div>

    <div class="stat-card">
        <span class="stat-icon orange"><i class="fa-solid fa-tasks"></i></span>
        <div>
            <span class="stat-label">Tareas</span>
            <strong><%= cantTareas != null ? cantTareas : 0 %></strong>
            <span class="stat-hint"><%= cantTareasEnProgreso != null ? cantTareasEnProgreso : 0 %> en progreso</span>
        </div>
    </div>

    <div class="stat-card">
        <span class="stat-icon green"><i class="fa-solid fa-circle-check"></i></span>
        <div>
            <span class="stat-label">Tareas completadas</span>
            <strong><%= cantTareasCompletadas != null ? cantTareasCompletadas : 0 %></strong>
            <span class="stat-hint"><%= cantTareasPendientes != null ? cantTareasPendientes : 0 %> pendientes</span>
        </div>
    </div>
</section>

<section class="section-card">
    <div class="section-heading">
        <div>
            <h2>Proyectos y avance</h2>
            <p>El progreso se calcula según las tareas completadas de cada proyecto.</p>
        </div>
        <a class="action-link" href="<%= ctxPath %>/Proyecto">Ver todos <i class="fa-solid fa-arrow-right"></i></a>
    </div>

    <% if (!proyectosResumen.isEmpty()) { %>
    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th>Proyecto</th>
                <th>Estado</th>
                <th>Equipo</th>
                <th>Tareas</th>
                <th>Progreso</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <% for (ProyectoResumen resumen : proyectosResumen) {
                String estado = resumen.getProyecto().getEstado() != null ? resumen.getProyecto().getEstado() : "Planificado";
                String badgeClass = "info";
                if ("En curso".equalsIgnoreCase(estado)) badgeClass = "success";
                else if ("Pausado".equalsIgnoreCase(estado)) badgeClass = "warning";
                else if ("Finalizado".equalsIgnoreCase(estado)) badgeClass = "neutral";
            %>
            <tr>
                <td>
                    <strong><%= resumen.getProyecto().getNombre() %></strong>
                    <small><%= resumen.getProyecto().getDescripcion() != null ? resumen.getProyecto().getDescripcion() : "Sin descripción" %></small>
                </td>
                <td><span class="badge <%= badgeClass %>"><%= estado %></span></td>
                <td><%= resumen.getIntegrantes() %> integrante<%= resumen.getIntegrantes() == 1 ? "" : "s" %></td>
                <td>
                    <%= resumen.getTareasCompletadas() %> / <%= resumen.getTotalTareas() %>
                    <small>completadas</small>
                </td>
                <td>
                    <div class="progress-container">
                        <div class="progress"><i style="width: <%= resumen.getProgreso() %>%"></i></div>
                        <small><%= resumen.getProgreso() %>%</small>
                    </div>
                </td>
                <td>
                    <a class="action-link" href="<%= ctxPath %>/Proyecto?accion=detalle&id=<%= resumen.getProyecto().getId() %>">
                        Ver detalle <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } else { %>
    <div class="empty-state">
        <i class="fa-regular fa-folder-open"></i>
        Todavía no hay proyectos. Creá el primero para empezar a organizar el trabajo.
    </div>
    <% } %>
</section>

<section class="two-columns">
    <div class="section-card">
        <div class="section-heading">
            <div>
                <h2>Estado de tareas</h2>
                <p>Distribución global de las tareas cargadas.</p>
            </div>
        </div>

        <div class="activity-list">
            <div class="activity">
                <span class="activity-dot green"></span>
                <div>
                    <strong>Completadas</strong>
                    <small><%= cantTareasCompletadas != null ? cantTareasCompletadas : 0 %> tareas finalizadas</small>
                </div>
            </div>
            <div class="activity">
                <span class="activity-dot blue"></span>
                <div>
                    <strong>En progreso</strong>
                    <small><%= cantTareasEnProgreso != null ? cantTareasEnProgreso : 0 %> tareas en ejecución</small>
                </div>
            </div>
            <div class="activity">
                <span class="activity-dot purple"></span>
                <div>
                    <strong>Pendientes</strong>
                    <small><%= cantTareasPendientes != null ? cantTareasPendientes : 0 %> tareas por iniciar</small>
                </div>
            </div>
        </div>
    </div>

    <div class="section-card">
        <div class="section-heading">
            <div>
                <h2>Acciones rápidas</h2>
                <p>Atajos a las tareas más frecuentes.</p>
            </div>
        </div>

        <div class="quick-actions">
            <a href="<%= ctxPath %>/Empleado" class="quick"><i class="fa-solid fa-user-plus"></i> Registrar empleado</a>
            <a href="<%= ctxPath %>/Proyecto?accion=nuevo" class="quick"><i class="fa-solid fa-folder-plus"></i> Crear proyecto</a>
            <a href="<%= ctxPath %>/Asignaciones" class="quick"><i class="fa-solid fa-list-check"></i> Gestionar asignaciones</a>
            <a href="<%= ctxPath %>/Tarea" class="quick"><i class="fa-solid fa-tasks"></i> Ver tareas</a>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
