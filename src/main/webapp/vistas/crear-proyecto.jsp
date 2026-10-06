<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear proyecto | TechConsult</title>
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

        .btn.secondary:hover {
            background: var(--border);
        }

        /* FORMULARIO */
        .form-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 2rem;
            max-width: 900px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
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
            min-height: 100px;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
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
                <p class="eyebrow">Nuevo proyecto</p>
                <h1>Crear proyecto</h1>
                <p class="muted">Ingresá los datos del nuevo proyecto para darlo de alta en el sistema.</p>
            </div>
            <a href="${pageContext.request.contextPath}/Proyecto" class="btn secondary">
                <i class="fa-solid fa-arrow-left"></i> Volver
            </a>
        </header>

        <section class="form-card">
            <form action="${pageContext.request.contextPath}/Proyecto" method="post">
                <div class="form-grid">
                    <label class="full">
                        Nombre del proyecto *
                        <input type="text" name="nombre" placeholder="Ej. Aplicación Móvil" required>
                    </label>

                    <label class="full">
                        Estado inicial
                        <select name="estado" required>
                            <option value="Planificado">Planificado</option>
                            <option value="En curso" selected>En curso</option>
                            <option value="Pausado">Pausado</option>
                            <option value="Finalizado">Finalizado</option>
                        </select>
                    </label>

                    <label class="full">
                        Descripción
                        <textarea name="descripcion" placeholder="Describí brevemente los objetivos del proyecto..."></textarea>
                    </label>
                </div>

                <div class="form-actions">
                    <a class="btn secondary" href="${pageContext.request.contextPath}/Proyecto">Cancelar</a>
                    <button type="submit" class="btn primary">
                        <i class="fa-solid fa-floppy-disk"></i> Guardar proyecto
                    </button>
                </div>
            </form>
        </section>
    </main>
</div>
<script src="${pageContext.request.contextPath}/scripts/script.js"></script>
</body>
</html>