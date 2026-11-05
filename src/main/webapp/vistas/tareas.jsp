<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Tarea" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>
<%
    @SuppressWarnings("unchecked")
    List<Tarea> tareas = (List<Tarea>) request.getAttribute("tareas");
    @SuppressWarnings("unchecked")
    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");
    if (tareas == null || proyectos == null) {
        response.sendRedirect(request.getContextPath() + "/Tarea");
        return;
    }
    Tarea tareaEditar = (Tarea) request.getAttribute("tareaEditar");
    Integer filtroProyecto = (Integer) request.getAttribute("filtroProyecto");

    request.setAttribute("activeNav", "tareas");
    request.setAttribute("pageTitle", "Tareas");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Gestión operativa</p>
        <h1>Tareas</h1>
        <p class="muted">Creá tareas, asignalas a un proyecto y seguí su estado.</p>
    </div>
    <a class="btn primary" href="#registrar">
        <i class="fa-solid fa-plus"></i> Nueva tarea
    </a>
</header>

<section class="toolbar">
    <div class="search">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input id="taskSearch" type="text" placeholder="Buscar tarea por título, proyecto o descripción...">
    </div>
    <select id="taskProjectFilter">
        <option value="">Todos los proyectos</option>
        <% for (Proyecto p : proyectos) { %>
        <option value="<%= p.getId() %>" <%= filtroProyecto != null && filtroProyecto == p.getId() ? "selected" : "" %>>
            <%= p.getNombre() %>
        </option>
        <% } %>
    </select>
</section>

<section class="section-card">
    <div class="table-wrap">
        <table id="tasksTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tarea</th>
                <th>Proyecto</th>
                <th>Estado</th>
                <th>Descripción</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% if (!tareas.isEmpty()) {
                for (Tarea t : tareas) {
                    String estadoClass = "warning";
                    if (t.isEnProgreso()) estadoClass = "info";
                    else if (t.isCompletada()) estadoClass = "success";
            %>
            <tr data-project="<%= t.getIdProyecto() %>">
                <td>#<%= t.getId() %></td>
                <td><strong><%= t.getTitulo() %></strong></td>
                <td>
                    <% if (t.getIdProyecto() > 0 && t.getNombreProyecto() != null) { %>
                    <a class="action-link" href="<%= ctxPath %>/Proyecto?accion=detalle&id=<%= t.getIdProyecto() %>">
                        <i class="fa-solid fa-diagram-project"></i> <%= t.getNombreProyecto() %>
                    </a>
                    <% } else { %>
                    <span class="badge neutral">Sin proyecto</span>
                    <% } %>
                </td>
                <td><span class="badge <%= estadoClass %>"><%= t.getEstado() != null ? t.getEstado() : "Pendiente" %></span></td>
                <td><span class="muted"><%= t.getDescripcion() != null ? t.getDescripcion() : "-" %></span></td>
                <td>
                    <div class="row-actions">
                        <a class="icon-link" href="<%= ctxPath %>/Tarea?accion=editar&id=<%= t.getId() %>" title="Editar">
                            <i class="fa-solid fa-pen"></i>
                        </a>
                        <a class="icon-link danger"
                           href="<%= ctxPath %>/Tarea?accion=eliminar&id=<%= t.getId() %>"
                           data-confirm="¿Eliminar la tarea '<%= t.getTitulo() %>'?"
                           title="Eliminar">
                            <i class="fa-solid fa-trash"></i>
                        </a>
                    </div>
                </td>
            </tr>
            <%  }
            } else { %>
            <tr>
                <td colspan="6">
                    <div class="empty-state">
                        <i class="fa-regular fa-square-check"></i>
                        No hay tareas registradas. Creá una y asignala a un proyecto.
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
            <h2><%= tareaEditar != null ? "Editar tarea" : "Crear nueva tarea" %></h2>
            <p>La tarea queda vinculada al proyecto seleccionado.</p>
        </div>
        <% if (tareaEditar != null) { %>
        <a class="btn secondary small" href="<%= ctxPath %>/Tarea">
            <i class="fa-solid fa-xmark"></i> Cancelar edición
        </a>
        <% } %>
    </div>

    <form action="<%= ctxPath %>/Tarea" method="post">
        <input type="hidden" name="id" value="<%= tareaEditar != null ? tareaEditar.getId() : 0 %>">

        <div class="form-grid">
            <label>
                Título de la tarea *
                <input type="text" name="titulo" value="<%= tareaEditar != null && tareaEditar.getTitulo() != null ? tareaEditar.getTitulo() : "" %>" placeholder="Ej. Diseñar interfaz principal" required>
            </label>

            <label>
                Proyecto *
                <% int proyectoSeleccionado = tareaEditar != null ? tareaEditar.getIdProyecto() : (filtroProyecto != null ? filtroProyecto : 0); %>
                <select name="idProyecto" required>
                    <option value="">Seleccionar proyecto</option>
                    <% for (Proyecto p : proyectos) { %>
                    <option value="<%= p.getId() %>" <%= proyectoSeleccionado == p.getId() ? "selected" : "" %>>
                        <%= p.getNombre() %>
                    </option>
                    <% } %>
                </select>
            </label>

            <label>
                Estado *
                <% String est = tareaEditar != null && tareaEditar.getEstado() != null ? tareaEditar.getEstado() : "Pendiente"; %>
                <select name="estado" required>
                    <option value="Pendiente" <%= "Pendiente".equalsIgnoreCase(est) ? "selected" : "" %>>Pendiente</option>
                    <option value="En Progreso" <%= "En Progreso".equalsIgnoreCase(est) || "En curso".equalsIgnoreCase(est) ? "selected" : "" %>>En Progreso</option>
                    <option value="Completada" <%= "Completada".equalsIgnoreCase(est) || "Finalizada".equalsIgnoreCase(est) ? "selected" : "" %>>Completada</option>
                </select>
            </label>

            <label class="full">
                Descripción
                <textarea name="descripcion" placeholder="Detalles o especificaciones adicionales de la tarea..."><%= tareaEditar != null && tareaEditar.getDescripcion() != null ? tareaEditar.getDescripcion() : "" %></textarea>
            </label>
        </div>

        <div class="form-actions">
            <a href="<%= ctxPath %>/Tarea" class="btn secondary">Limpiar</a>
            <button type="submit" class="btn primary">
                <i class="fa-solid fa-floppy-disk"></i> <%= tareaEditar != null ? "Guardar cambios" : "Guardar tarea" %>
            </button>
        </div>
    </form>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
