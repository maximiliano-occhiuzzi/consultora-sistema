<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.consultora.sistema.domain.Proyecto" %>

<%
    Proyecto p = (Proyecto) request.getAttribute("proyecto");
    if (p == null) {
        // En caso de ingresar directamente o no encontrar el objeto
        p = new Proyecto(0, "Proyecto no encontrado", "Sin descripción", "Desconocido");
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= p.getNombre() %> | TechConsult</title>
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
            --input-bg: #0f172a;
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

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--muted);
            text-decoration: none;
            font-size: 0.875rem;
            margin-bottom: 1rem;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--text);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 2rem;
        }

        .title-line {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .project-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            background: rgba(59, 130, 246, 0.15);
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .badge {
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .badge.success { background: rgba(16, 185, 129, 0.15); color: var(--success); }
        .badge.info { background: rgba(6, 182, 212, 0.15); color: var(--info); }
        .badge.warning { background: rgba(245, 158, 11, 0.15); color: var(--warning); }

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
            border: 1px solid transparent;
        }

        .btn.danger-outline {
            background: transparent;
            border-color: var(--danger);
            color: var(--danger);
        }

        .btn.danger-outline:hover {
            background: var(--danger);
            color: #ffffff;
        }

        .btn.primary {
            background: var(--primary);
            color: #ffffff;
        }

        .btn.primary:hover {
            background: var(--primary-hover);
        }

        /* SECTION CARDS & EDIT FORM */
        .section-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .section-heading {
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--border);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
        }

        .form-grid label {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
        }

        .form-grid label.full {
            grid-column: 1 / -1;
        }

        input[type="text"], select, textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 6px;
            color: var(--text);
            outline: none;
            font-size: 0.9rem;
        }

        input[type="text"]:focus, select:focus, textarea:focus {
            border-color: var(--primary);
        }

        textarea {
            resize: vertical;
            min-height: 90px;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 1.5rem;
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
        <a class="back-link" href="${pageContext.request.contextPath}/Proyecto">
            <i class="fa-solid fa-arrow-left"></i> Volver a Proyectos
        </a>

        <header class="header-content">
            <div class="title-line">
                <div class="project-icon">
                    <i class="fa-solid fa-diagram-project"></i>
                </div>
                <div>
                    <h1><%= p.getNombre() %></h1>
                    <p style="color: var(--muted);"><%= p.getDescripcion() != null ? p.getDescripcion() : "Sin descripción." %></p>
                </div>
                <% 
                    String badgeClass = "info";
                    if ("En curso".equalsIgnoreCase(p.getEstado())) badgeClass = "success";
                    else if ("Pausado".equalsIgnoreCase(p.getEstado())) badgeClass = "warning";
                %>
                <span class="badge <%= badgeClass %>"><%= p.getEstado() != null ? p.getEstado() : "En curso" %></span>
            </div>

            <a href="${pageContext.request.contextPath}/Proyecto?accion=eliminar&id=<%= p.getId() %>" 
               class="btn danger-outline" 
               onclick="return confirm('¿Confirma eliminar este proyecto?')">
                <i class="fa-solid fa-trash"></i> Eliminar Proyecto
            </a>
        </header>

        <!-- FORMULARIO DE EDICIÓN DEL PROYECTO -->
        <section class="section-card">
            <div class="section-heading">
                <h2>Información del Proyecto</h2>
                <p style="color: var(--muted); font-size: 0.875rem;">Podés modificar la información del proyecto y guardar los cambios.</p>
            </div>

            <form action="${pageContext.request.contextPath}/Proyecto" method="post">
                <!-- ID oculto para edición -->
                <input type="hidden" name="id" value="<%= p.getId() %>">

                <div class="form-grid">
                    <label class="full">
                        Nombre del proyecto
                        <input type="text" name="nombre" value="<%= p.getNombre() %>" required>
                    </label>

                    <label class="full">
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
                    <button type="submit" class="btn primary">
                        <i class="fa-solid fa-floppy-disk"></i> Guardar Cambios
                    </button>
                </div>
            </form>
        </section>
    </main>
</div>
<script src="${pageContext.request.contextPath}/scripts/script.js"></script>
</body>
</html>