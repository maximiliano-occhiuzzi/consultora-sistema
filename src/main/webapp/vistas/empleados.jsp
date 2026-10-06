<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.consultora.sistema.domain.Empleado" %>

<%
    List<Empleado> empleados = (List<Empleado>) request.getAttribute("empleados");
    Empleado empEditar = (Empleado) request.getAttribute("empleadoEditar");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empleados | TechConsult</title>
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
            color: var(--text);
            flex-shrink: 0;
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

        .btn.primary {
            background: var(--primary);
            color: #ffffff;
        }

        .btn.primary:hover {
            background: var(--primary-hover);
        }

        .btn.secondary {
            background: transparent;
            border-color: var(--border);
            color: var(--text);
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

        /* TABLE */
        .section-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            padding: 0.75rem 1rem;
            color: var(--muted);
            font-size: 0.8rem;
            text-transform: uppercase;
            border-bottom: 1px solid var(--border);
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.9rem;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .person {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .person small {
            display: block;
            color: var(--muted);
        }

        .btn-action {
            color: var(--danger);
            text-decoration: none;
            padding: 0.4rem 0.6rem;
            border-radius: 4px;
            transition: background 0.2s;
        }

        .btn-action:hover {
            background: rgba(239, 68, 68, 0.15);
        }

        /* FORMULARIO */
        .form-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 1.5rem;
        }

        .form-card h2 {
            font-size: 1.2rem;
            margin-bottom: 0.25rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.25rem;
            margin-top: 1.25rem;
        }

        .form-grid label {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
        }

        input[type="text"], input[type="email"], select {
            width: 100%;
            padding: 0.75rem 1rem;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 6px;
            color: var(--text);
            outline: none;
        }

        input:focus, select:focus {
            border-color: var(--primary);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border);
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
            <a href="${pageContext.request.contextPath}/Empleado" class="active"><i class="fa-solid fa-users"></i> <span>Empleados</span></a>
            <a href="${pageContext.request.contextPath}/Proyecto"><i class="fa-solid fa-diagram-project"></i> <span>Proyectos</span></a>
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
                <p class="eyebrow">Personal técnico</p>
                <h1>Empleados</h1>
                <p style="color: var(--muted); font-size: 0.875rem;">Administrá los integrantes de la consultora.</p>
            </div>
            <a class="btn primary" href="#registrar">
                <i class="fa-solid fa-user-plus"></i> Registrar empleado
            </a>
        </header>

        <section class="toolbar">
            <div class="search">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input id="employeeSearch" type="text" placeholder="Buscar empleado...">
            </div>
        </section>

        <!-- TABLA DE EMPLEADOS -->
        <section class="section-card">
            <div class="table-wrap">
                <table id="employeesTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Empleado</th>
                            <th>Puesto / Rol</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (empleados != null && !empleados.isEmpty()) {
                            for (Empleado e : empleados) { 
                                String iniciales = "";
                                if (e.getNombre() != null && !e.getNombre().isEmpty()) iniciales += e.getNombre().substring(0, 1);
                                if (e.getApellido() != null && !e.getApellido().isEmpty()) iniciales += e.getApellido().substring(0, 1);
                        %>
                            <tr>
                                <td>#<%= e.getId() %></td>
                                <td>
                                    <div class="person">
                                        <div class="avatar"><%= iniciales.toUpperCase() %></div>
                                        <div>
                                            <strong><%= e.getNombre() %> <%= e.getApellido() %></strong>
                                            <small><%= e.getEmail() != null ? e.getEmail() : "-" %></small>
                                        </div>
                                    </div>
                                </td>
                                <td><%= e.getPuesto() != null ? e.getPuesto() : "Sin especificar" %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/Empleado?accion=eliminar&id=<%= e.getId() %>" 
                                       class="btn-action" 
                                       onclick="return confirm('¿Eliminar empleado?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        <%  }
                        } else { %>
                            <tr>
                                <td colspan="4" style="color: var(--muted); text-align: center;">No hay empleados registrados en el sistema.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- FORMULARIO DE REGISTRO / EDICIÓN -->
        <section class="form-card" id="registrar">
            <div>
                <h2><%= (empEditar != null) ? "Editar empleado" : "Registrar nuevo empleado" %></h2>
                <p style="color: var(--muted); font-size: 0.875rem;">Ingresá los datos correspondientes para guardar el empleado.</p>
            </div>

            <form action="${pageContext.request.contextPath}/Empleado" method="post">
                <!-- CAMPO OCULTO DE ID -->
                <input type="hidden" name="id" value="<%= (empEditar != null) ? empEditar.getId() : "0" %>">

                <div class="form-grid">
                    <label>
                        Nombre *
                        <input type="text" name="nombre" value="<%= (empEditar != null && empEditar.getNombre() != null) ? empEditar.getNombre() : "" %>" placeholder="Ej. Martín" required>
                    </label>

                    <label>
                        Apellido *
                        <input type="text" name="apellido" value="<%= (empEditar != null && empEditar.getApellido() != null) ? empEditar.getApellido() : "" %>" placeholder="Ej. Díaz" required>
                    </label>

                    <label>
                        Correo Electrónico *
                        <input type="email" name="email" value="<%= (empEditar != null && empEditar.getEmail() != null) ? empEditar.getEmail() : "" %>" placeholder="correo@consultora.com" required>
                    </label>

                    <label>
                        Puesto / Rol *
                        <% String puestoSel = (empEditar != null && empEditar.getPuesto() != null) ? empEditar.getPuesto() : ""; %>
                        <select name="puesto" required>
                            <option value="">Seleccionar rol</option>
                            <option value="Backend" <%= "Backend".equals(puestoSel) ? "selected" : "" %>>Backend</option>
                            <option value="Frontend" <%= "Frontend".equals(puestoSel) ? "selected" : "" %>>Frontend</option>
                            <option value="Diseñador" <%= "Diseñador".equals(puestoSel) ? "selected" : "" %>>Diseñador</option>
                            <option value="DevOps" <%= "DevOps".equals(puestoSel) ? "selected" : "" %>>DevOps</option>
                            <option value="QA / Tester" <%= "QA / Tester".equals(puestoSel) ? "selected" : "" %>>QA / Tester</option>
                        </select>
                    </label>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/Empleado" class="btn secondary">Limpiar</a>
                    <button type="submit" class="btn primary">
                        <i class="fa-solid fa-floppy-disk"></i> Guardar empleado
                    </button>
                </div>
            </form>
        </section>
    </main>
</div>
<script src="${pageContext.request.contextPath}/scripts/script.js"></script>
</body>
</html>