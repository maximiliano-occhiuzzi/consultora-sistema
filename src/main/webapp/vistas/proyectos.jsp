<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>

<%
    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proyectos | TechConsult</title>
    <!-- FontAwesome para Íconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --bg: #0f172a;
            --sidebar-bg: #020617;
            --card: #1e293b;
            --border: #334155;
            --text: #f8fafc;
            --muted: #94a3b8;
            --primary: #3b82f6;
            --primary-hover: #2563eb;
            --danger: #ef4444;
            --success: #10b981;
            --warning: #f59e0b;
            --info: #06b6d4;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }

        body {
            background-color: var(--bg);
            color: var(--text);
        }

        .app {
            display: flex;
            min-height: 100vh;
        }

        /* SIDEBAR */
        aside {
            width: 240px;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--border);
            padding: 1.5rem 1rem;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 2rem;
            padding: 0 0.5rem;
        }

        .brand-dot {
            background: var(--primary);
            width: 38px;
            height: 38px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: #fff;
        }

        .brand small {
            display: block;
            color: var(--muted);
            font-size: 0.75rem;
        }

        aside nav {
            display: flex;
            flex-direction: column;
            gap: 0.35rem;
            flex: 1;
        }

        aside nav a {
            color: var(--muted);
            text-decoration: none;
            padding: 0.75rem 1rem;
            border-radius: 6px;
            display: flex;
            align-items: center;
            gap: 0.85rem;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        aside nav a:hover, aside nav a.active {
            background: var(--card);
            color: var(--text);
        }

        aside nav a.active {
            border-left: 3px solid var(--primary);
        }

        aside nav a i {
            width: 18px;
            text-align: center;
        }

        .user-box {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border);
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.85rem;
        }

        /* MAIN CONTENT */
        main {
            flex: 1;
            padding: 2rem;
            overflow-y: auto;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .eyebrow {
            text-transform: uppercase;
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--primary);
            letter-spacing: 0.05em;
        }

        .topbar h1 {
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0.2rem 0;
        }

        .muted {
            color: var(--muted);
            font-size: 0.875rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.65rem 1.25rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s;
            cursor: pointer;
            border: none;
        }

        .btn.primary {
            background: var(--primary);
            color: #ffffff;
        }

        .btn.primary:hover {
            background: var(--primary-hover);
        }

        /* TOOLBAR */
        .toolbar {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .search {
            position: relative;
            flex: 1;
        }

        .search i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted);
        }

        .search input {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 6px;
            color: var(--text);
            outline: none;
        }

        .search input:focus {
            border-color: var(--primary);
        }

        .toolbar select {
            padding: 0.75rem 1rem;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 6px;
            color: var(--text);
            outline: none;
        }

        /* GRID DE PROYECTOS */
        .project-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .project-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform 0.2s, border-color 0.2s;
        }

        .project-card:hover {
            transform: translateY(-2px);
            border-color: var(--primary);
        }

        .project-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .project-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #0f172a;
            color: var(--primary);
            font-size: 1.1rem;
        }

        .badge {
            padding: 0.25rem 0.65rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge.success { background: rgba(16, 185, 129, 0.15); color: var(--success); }
        .badge.info { background: rgba(6, 182, 212, 0.15); color: var(--info); }
        .badge.warning { background: rgba(245, 158, 11, 0.15); color: var(--warning); }

        .project-card h3 {
            font-size: 1.1rem;
            margin-bottom: 0.4rem;
        }

        .project-card h3 a {
            color: var(--text);
            text-decoration: none;
        }

        .project-card h3 a:hover {
            color: var(--primary);
        }

        .project-card p {
            color: var(--muted);
            font-size: 0.85rem;
            line-height: 1.4;
            margin-bottom: 1.25rem;
            flex-grow: 1;
        }

        .card-actions {
            display: flex;
            justify-content: flex-end;
            gap: 0.75rem;
            padding-top: 0.75rem;
            border-top: 1px solid var(--border);
        }

        .action-link {
            color: var(--muted);
            text-decoration: none;
            font-size: 0.85rem;
            transition: color 0.2s;
        }

        .action-link:hover {
            color: var(--text);
        }

        .action-link.delete:hover {
            color: var(--danger);
        }
    </style>
</head>
<body>
<div class="app">
    <!-- BARRA LATERAL (NAVEGACIÓN) -->
    <aside>
        <div class="brand">
            <span class="brand-dot">TC</span>
            <div>
                <strong>TechConsult</strong>
                <small>Administración</small>
            </div>
        </div>
        
        <nav>
            <a href="${pageContext.request.contextPath}/Dashboard"><i class="fa-solid fa-house"></i> <span>Inicio</span></a>
            <a href="${pageContext.request.contextPath}/Empleado"><i class="fa-solid fa-users"></i> <span>Empleados</span></a>
            <a href="${pageContext.request.contextPath}/Proyecto" class="active"><i class="fa-solid fa-diagram-project"></i> <span>Proyectos</span></a>
            <a href="${pageContext.request.contextPath}/Asignaciones"><i class="fa-solid fa-list-check"></i> <span>Asignaciones</span></a>
            <a href="${pageContext.request.contextPath}/Tarea"><i class="fa-solid fa-tasks"></i> <span>Tareas</span></a>
            <a href="${pageContext.request.contextPath}/Chat"><i class="fa-solid fa-comments"></i> <span>Chat</span></a>
        </nav>
        
        <div class="user-box">
            <div class="avatar">AD</div>
            <div>
                <strong>${sessionScope.username != null ? sessionScope.username : 'Admin'}</strong>
                <small>Administrador</small>
            </div>
        </div>
    </aside>

    <!-- CONTENIDO PRINCIPAL -->
    <main>
        <header class="topbar">
            <div>
                <p class="eyebrow">Gestión de proyectos</p>
                <h1>Proyectos</h1>
                <p class="muted">Creá, configurá y controlá todos los proyectos.</p>
            </div>
            <a href="${pageContext.request.contextPath}/Proyecto?accion=nuevo" class="btn primary">
                <i class="fa-solid fa-plus"></i> Crear proyecto
            </a>
        </header>

        <section class="toolbar">
            <div class="search">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Buscar proyecto...">
            </div>
            <select>
                <option value="">Todos los estados</option>
                <option value="En curso">En curso</option>
                <option value="Planificado">Planificado</option>
                <option value="Pausado">Pausado</option>
                <option value="Finalizado">Finalizado</option>
            </select>
        </section>

        <!-- TARJETAS DINÁMICAS DE PROYECTOS -->
        <section class="project-grid">
            <% if (proyectos != null && !proyectos.isEmpty()) {
                for (Proyecto p : proyectos) { 
                    String badgeClass = "info";
                    if ("En curso".equalsIgnoreCase(p.getEstado())) badgeClass = "success";
                    else if ("Pausado".equalsIgnoreCase(p.getEstado())) badgeClass = "warning";
            %>
                <div class="project-card">
                    <div>
                        <div class="project-head">
                            <div class="project-icon">
                                <i class="fa-solid fa-diagram-project"></i>
                            </div>
                            <span class="badge <%= badgeClass %>"><%= p.getEstado() != null ? p.getEstado() : "En curso" %></span>
                        </div>
                        <h3>
                            <a href="${pageContext.request.contextPath}/Proyecto?accion=detalle&id=<%= p.getId() %>">
                                <%= p.getNombre() %>
                            </a>
                        </h3>
                        <p><%= p.getDescripcion() != null ? p.getDescripcion() : "Sin descripción disponible." %></p>
                    </div>

                    <div class="card-actions">
                        <a href="${pageContext.request.contextPath}/Proyecto?accion=detalle&id=<%= p.getId() %>" class="action-link">
                            <i class="fa-solid fa-eye"></i> Detalle
                        </a>
                        <a href="${pageContext.request.contextPath}/Proyecto?accion=eliminar&id=<%= p.getId() %>" 
                           class="action-link delete" 
                           onclick="return confirm('¿Eliminar proyecto?')">
                            <i class="fa-solid fa-trash"></i> Eliminar
                        </a>
                    </div>
                </div>
            <%  }
            } else { %>
                <p style="color: var(--muted); grid-column: 1 / -1;">No hay proyectos registrados en el sistema.</p>
            <% } %>
        </section>
    </main>
</div>
<script src="${pageContext.request.contextPath}/scripts/script.js"></script>
</body>
</html>