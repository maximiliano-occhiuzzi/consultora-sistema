<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>
<%
    @SuppressWarnings("unchecked")
    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");

    String javaVersion = System.getProperty("java.version");
    String servidor = application.getServerInfo();

    request.setAttribute("activeNav", "configuracion");
    request.setAttribute("pageTitle", "Configuración");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Sistema</p>
        <h1>Configuración</h1>
        <p class="muted">Información general de la aplicación y accesos rápidos.</p>
    </div>
</header>

<section class="stats-grid">
    <div class="stat-card">
        <span class="stat-icon blue"><i class="fa-brands fa-java"></i></span>
        <div>
            <span class="stat-label">Java</span>
            <strong><%= javaVersion %></strong>
            <span class="stat-hint">JDK 17</span>
        </div>
    </div>
    <div class="stat-card">
        <span class="stat-icon purple"><i class="fa-solid fa-server"></i></span>
        <div>
            <span class="stat-label">Servidor</span>
            <strong style="font-size: 1rem;"><%= servidor %></strong>
            <span class="stat-hint">Tomcat 10.1 · Jakarta EE</span>
        </div>
    </div>
    <div class="stat-card">
        <span class="stat-icon green"><i class="fa-solid fa-database"></i></span>
        <div>
            <span class="stat-label">Base de datos</span>
            <strong style="font-size: 1rem;">Supabase · PostgreSQL</strong>
            <span class="stat-hint">Conexión configurada en ConexionDB</span>
        </div>
    </div>
</section>

<section class="two-columns">
    <div class="section-card">
        <div class="section-heading">
            <div>
                <h2>Sesión actual</h2>
                <p>Datos del administrador conectado.</p>
            </div>
        </div>

        <div class="activity-list">
            <div class="activity">
                <div class="avatar primary"><%= inicialesUsuario %></div>
                <div>
                    <strong><%= usuarioHeader %></strong>
                    <small>Rol: Administrador</small>
                </div>
            </div>
            <div class="activity">
                <span class="activity-dot green"></span>
                <div>
                    <strong>Sesión activa</strong>
                    <small>La sesión expira después de 30 minutos de inactividad.</small>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <a class="btn danger-outline" href="<%= ctxPath %>/Logout">
                <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesión
            </a>
        </div>
    </div>

    <div class="section-card">
        <div class="section-heading">
            <div>
                <h2>Proyectos registrados</h2>
                <p>Accedé directamente a la configuración de cada proyecto.</p>
            </div>
        </div>

        <% if (proyectos != null && !proyectos.isEmpty()) { %>
        <div class="activity-list">
            <% for (Proyecto p : proyectos) { %>
            <div class="activity" style="justify-content: space-between;">
                <div>
                    <strong><%= p.getNombre() %></strong>
                    <small><%= p.getEstado() != null ? p.getEstado() : "Planificado" %></small>
                </div>
                <a class="action-link" href="<%= ctxPath %>/Proyecto?accion=detalle&id=<%= p.getId() %>">
                    <i class="fa-solid fa-pen"></i> Configurar
                </a>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="empty-state">
            <i class="fa-regular fa-folder-open"></i>
            No hay proyectos registrados.
        </div>
        <% } %>
    </div>
</section>

<section class="section-card">
    <div class="section-heading">
        <div>
            <h2>Conexión y despliegue</h2>
            <p>Parámetros técnicos usados por la aplicación.</p>
        </div>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th>Componente</th>
                <th>Configuración</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><strong>Persistencia</strong></td>
                <td>JDBC nativo con driver PostgreSQL 42.7.2</td>
            </tr>
            <tr>
                <td><strong>Connection pooler</strong></td>
                <td>Supabase Transaction Pooler · puerto 6543 · prepared statements desactivados</td>
            </tr>
            <tr>
                <td><strong>Servidor de aplicación</strong></td>
                <td>Tomcat 10.1 (Jakarta Servlet 6.0)</td>
            </tr>
            <tr>
                <td><strong>Empaquetado</strong></td>
                <td>WAR generado por Maven con Java 17</td>
            </tr>
            </tbody>
        </table>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
