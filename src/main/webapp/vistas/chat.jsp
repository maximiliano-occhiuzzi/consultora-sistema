<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Empleado" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>
<%
    @SuppressWarnings("unchecked")
    List<Empleado> empleados = (List<Empleado>) request.getAttribute("empleados");
    @SuppressWarnings("unchecked")
    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");
    if (empleados == null || proyectos == null) {
        response.sendRedirect(request.getContextPath() + "/Chat");
        return;
    }

    String nombreProyectoChat = proyectos.isEmpty() ? "Equipo general" : proyectos.get(0).getNombre();
    request.setAttribute("activeNav", "chat");
    request.setAttribute("pageTitle", "Chat");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Comunicación interna</p>
        <h1>Chat del equipo</h1>
        <p class="muted">Vista de demostración: los mensajes no se persisten en la base de datos.</p>
    </div>
    <span class="badge info"><%= empleados.size() %> integrantes</span>
</header>

<section class="chat-layout">
    <aside class="chat-members">
        <div>
            <h3><%= nombreProyectoChat %></h3>
            <small class="muted">Integrantes del equipo</small>
        </div>

        <% if (!empleados.isEmpty()) {
            for (int i = 0; i < empleados.size(); i++) {
                Empleado e = empleados.get(i);
                String nombre = e.getNombre() + " " + e.getApellido();
                String iniciales = (e.getNombre() != null && !e.getNombre().isEmpty() ? e.getNombre().substring(0, 1) : "")
                        + (e.getApellido() != null && !e.getApellido().isEmpty() ? e.getApellido().substring(0, 1) : "");
        %>
        <div class="member">
            <div class="avatar"><%= iniciales.toUpperCase() %></div>
            <div>
                <strong><%= nombre %></strong>
                <small class="<%= i < 3 ? "online" : "" %>">
                    <i class="fa-solid fa-circle" style="font-size: 7px;"></i>
                    <%= i < 3 ? "En línea" : "Disponible" %>
                </small>
            </div>
        </div>
        <%  }
        } else { %>
        <p class="muted">No hay empleados cargados.</p>
        <% } %>
    </aside>

    <div class="chat-window">
        <div class="chat-header">
            <div>
                <strong>Conversación de <%= nombreProyectoChat %></strong>
                <small>Canal interno de coordinación</small>
            </div>
            <span class="badge neutral">Demo</span>
        </div>

        <div class="messages" id="messages">
            <% if (empleados.size() > 0) {
                Empleado primero = empleados.get(0);
                String nombrePrimero = primero.getNombre() + " " + primero.getApellido();
                String inicialesPrimero = (primero.getNombre() != null && !primero.getNombre().isEmpty() ? primero.getNombre().substring(0, 1) : "")
                        + (primero.getApellido() != null && !primero.getApellido().isEmpty() ? primero.getApellido().substring(0, 1) : "");
            %>
            <div class="message">
                <div class="avatar"><%= inicialesPrimero.toUpperCase() %></div>
                <div>
                    <strong><%= nombrePrimero %> <small>10:24</small></strong>
                    <p>¿Alguien puede revisar el avance de las tareas del proyecto?</p>
                </div>
            </div>
            <% } %>

            <% if (empleados.size() > 1) {
                Empleado segundo = empleados.get(1);
                String nombreSegundo = segundo.getNombre() + " " + segundo.getApellido();
                String inicialesSegundo = (segundo.getNombre() != null && !segundo.getNombre().isEmpty() ? segundo.getNombre().substring(0, 1) : "")
                        + (segundo.getApellido() != null && !segundo.getApellido().isEmpty() ? segundo.getApellido().substring(0, 1) : "");
            %>
            <div class="message">
                <div class="avatar"><%= inicialesSegundo.toUpperCase() %></div>
                <div>
                    <strong><%= nombreSegundo %> <small>10:26</small></strong>
                    <p>Sí, actualizo el estado en el módulo de tareas y aviso por acá.</p>
                </div>
            </div>
            <% } %>

            <div class="message own">
                <div>
                    <strong><%= usuarioHeader %> <small>10:31</small></strong>
                    <p>Perfecto. Recordemos revisar el avance antes de la próxima reunión.</p>
                </div>
                <div class="avatar primary"><%= inicialesUsuario %></div>
            </div>
        </div>

        <form class="chat-input" id="chatForm"
              data-username="<%= usuarioHeader %>"
              data-avatar="<%= inicialesUsuario %>">
            <input id="messageInput" type="text" placeholder="Escribí un mensaje..." autocomplete="off" required>
            <button type="submit" class="btn primary" title="Enviar">
                <i class="fa-solid fa-paper-plane"></i>
            </button>
        </form>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
