<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Empleado" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>
<%@ page import="com.consultora.sistema.domain.AsignacionProyecto" %>

<%
    List<Empleado> empleados = (List<Empleado>) request.getAttribute("empleados");
    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");
    List<AsignacionProyecto> asignacionesProyectos = (List<AsignacionProyecto>) request.getAttribute("asignacionesProyectos");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asignaciones | TechConsult</title>
    <style>
        :root {
            --bg: #0f172a;
            --card: #1e293b;
            --border: #334155;
            --text: #f8fafc;
            --muted: #94a3b8;
            --primary: #3b82f6;
            --danger: #ef4444;
        }
        body { margin: 0; font-family: system-ui, -apple-system, sans-serif; background: var(--bg); color: var(--text); }
        .app { display: flex; min-height: 100vh; }
        aside { width: 240px; background: #020617; border-right: 1px solid var(--border); padding: 1.5rem; }
        aside nav a { display: block; color: var(--muted); text-decoration: none; padding: 0.75rem 1rem; border-radius: 6px; margin-bottom: 0.25rem; }
        aside nav a.active, aside nav a:hover { background: var(--card); color: var(--text); }
        main { flex: 1; padding: 2rem; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 1.5rem; }
        .card { background: var(--card); border: 1px solid var(--border); border-radius: 8px; padding: 1.5rem; }
        form { display: flex; flex-direction: column; gap: 1rem; margin-bottom: 1.5rem; }
        select, button { padding: 0.75rem; border-radius: 6px; border: 1px solid var(--border); background: #0f172a; color: var(--text); }
        button.btn-primary { background: var(--primary); border: none; cursor: pointer; font-weight: 600; }
        .item-list { display: flex; flex-direction: column; gap: 0.5rem; }
        .item-row { display: flex; justify-content: space-between; align-items: center; background: #0f172a; padding: 0.75rem 1rem; border-radius: 6px; border: 1px solid var(--border); }
        .btn-delete { color: var(--danger); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
<div class="app">
    <aside>
        <h2>TechConsult</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/Dashboard">Inicio</a>
            <a href="${pageContext.request.contextPath}/Empleado">Empleados</a>
            <a href="${pageContext.request.contextPath}/Proyecto">Proyectos</a>
            <a href="${pageContext.request.contextPath}/Tarea">Tareas</a>
            <a href="${pageContext.request.contextPath}/Asignaciones" class="active">Asignaciones</a>
        </nav>
    </aside>

    <main>
        <h1>Asignaciones de Equipo</h1>
        <p style="color: var(--muted)">Vincular empleados a proyectos del sistema.</p>

        <div class="grid">
            <!-- Formulario de Asignación -->
            <div class="card">
                <h2>Asignar Empleado a Proyecto</h2>
                <form action="${pageContext.request.contextPath}/Asignaciones" method="post">
                    <input type="hidden" name="tipo" value="proyecto">
                    
                    <label>Empleado:</label>
                    <select name="idEmpleado" required>
                        <option value="">-- Seleccionar Empleado --</option>
                        <% if (empleados != null) {
                            for (Empleado e : empleados) { %>
                                <option value="<%= e.getId() %>"><%= e.getNombre() %> <%= e.getApellido() %> (<%= e.getPuesto() %>)</option>
                        <%  }
                        } %>
                    </select>

                    <label>Proyecto:</label>
                    <select name="idProyecto" required>
                        <option value="">-- Seleccionar Proyecto --</option>
                        <% if (proyectos != null) {
                            for (Proyecto p : proyectos) { %>
                                <option value="<%= p.getId() %>"><%= p.getNombre() %></option>
                        <%  }
                        } %>
                    </select>

                    <button type="submit" class="btn-primary">+ Guardar Asignación</button>
                </form>
            </div>

            <!-- Listado de Asignaciones Actuales -->
            <div class="card">
                <h2>Asignaciones Activas</h2>
                <div class="item-list">
                    <% if (asignacionesProyectos != null && !asignacionesProyectos.isEmpty()) {
                        for (AsignacionProyecto ap : asignacionesProyectos) { %>
                            <div class="item-row">
                                <div>
                                    <strong><%= ap.getNombreEmpleado() %></strong><br>
                                    <small style="color: var(--muted)"><%= ap.getNombreProyecto() %></small>
                                </div>
                                <a href="${pageContext.request.contextPath}/Asignaciones?accion=eliminarProyecto&id=<%= ap.getId() %>" 
                                   class="btn-delete" onclick="return confirm('¿Remover asignación?')">✕</a>
                            </div>
                    <%  }
                    } else { %>
                        <p style="color: var(--muted)">No hay asignaciones cargadas actualmente.</p>
                    <% } %>
                </div>
            </div>
        </div>
    </main>
</div>
<script src="${pageContext.request.contextPath}/scripts/script.js"></script>
</body>
</html>