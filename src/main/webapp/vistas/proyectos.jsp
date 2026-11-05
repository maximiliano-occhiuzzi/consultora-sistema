<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>
<%
    @SuppressWarnings("unchecked")
    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");
    if (proyectos == null) {
        response.sendRedirect(request.getContextPath() + "/Proyecto");
        return;
    }

    request.setAttribute("activeNav", "proyectos");
    request.setAttribute("pageTitle", "Proyectos");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Gestión de proyectos</p>
        <h1>Proyectos</h1>
        <p class="muted">Creá, configurá y controlá todos los proyectos de la consultora.</p>
    </div>
    <a href="<%= ctxPath %>/Proyecto?accion=nuevo" class="btn primary">
        <i class="fa-solid fa-plus"></i> Crear proyecto
    </a>
</header>

<section class="toolbar">
    <div class="search">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input id="projectSearch" type="text" placeholder="Buscar proyecto por nombre o descripción...">
    </div>
</section>

<section class="project-grid">
    <% if (!proyectos.isEmpty()) {
        for (Proyecto p : proyectos) {
            String estado = p.getEstado() != null ? p.getEstado() : "Planificado";
            String badgeClass = "info";
            if ("En curso".equalsIgnoreCase(estado)) badgeClass = "success";
            else if ("Pausado".equalsIgnoreCase(estado)) badgeClass = "warning";
            else if ("Finalizado".equalsIgnoreCase(estado)) badgeClass = "neutral";
    %>
    <article class="project-card">
        <div>
            <div class="project-head">
                <div class="project-icon">
                    <i class="fa-solid fa-diagram-project"></i>
                </div>
                <span class="badge <%= badgeClass %>"><%= estado %></span>
            </div>

            <h3>
                <a href="<%= ctxPath %>/Proyecto?accion=detalle&id=<%= p.getId() %>">
                    <%= p.getNombre() %>
                </a>
            </h3>
            <p><%= p.getDescripcion() != null && !p.getDescripcion().trim().isEmpty() ? p.getDescripcion() : "Sin descripción disponible." %></p>

            <div class="project-meta">
                <span><i class="fa-solid fa-hashtag"></i> Proyecto #<%= p.getId() %></span>
                <span><i class="fa-solid fa-circle-dot"></i> <%= estado %></span>
            </div>
        </div>

        <div class="card-actions">
            <a href="<%= ctxPath %>/Proyecto?accion=detalle&id=<%= p.getId() %>" class="action-link">
                <i class="fa-solid fa-eye"></i> Ver detalle
            </a>
            <a href="<%= ctxPath %>/Proyecto?accion=eliminar&id=<%= p.getId() %>"
               class="action-link danger"
               data-confirm="¿Eliminar el proyecto '<%= p.getNombre() %>'? Se eliminarán también sus tareas y asignaciones."
               title="Eliminar">
                <i class="fa-solid fa-trash"></i> Eliminar
            </a>
        </div>
    </article>
    <%  }
    } else { %>
    <div class="empty-state" style="grid-column: 1 / -1;">
        <i class="fa-regular fa-folder-open"></i>
        No hay proyectos registrados. Creá el primero para empezar a organizar el trabajo.
    </div>
    <% } %>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
