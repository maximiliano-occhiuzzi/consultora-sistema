<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat | TechConsult</title>
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
        aside.sidebar {
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
        main.content {
            flex: 1;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            height: 100vh;
            overflow: hidden;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
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

        .muted { color: var(--muted); }

        .badge {
            display: inline-block;
            padding: 0.25rem 0.6rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .badge.success { background: rgba(16, 185, 129, 0.15); color: var(--success); }

        /* CHAT LAYOUT */
        .chat-layout {
            display: flex;
            gap: 1.5rem;
            flex: 1;
            min-height: 0;
        }

        .chat-members {
            width: 260px;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
            overflow-y: auto;
        }

        .chat-members h3 {
            font-size: 1rem;
        }

        .member {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .member small.online { color: var(--success); }
        .member small.offline { color: var(--muted); }

        .chat-window {
            flex: 1;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            min-height: 0;
        }

        .chat-header {
            padding: 1rem 1.25rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chat-header small {
            display: block;
            color: var(--muted);
        }

        .messages {
            flex: 1;
            padding: 1.25rem;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .message {
            display: flex;
            gap: 0.75rem;
            max-width: 70%;
        }

        .message strong small {
            color: var(--muted);
            font-weight: normal;
            margin-left: 0.3rem;
        }

        .message p {
            background: var(--input-bg);
            border: 1px solid var(--border);
            padding: 0.75rem 1rem;
            border-radius: 8px;
            margin-top: 0.25rem;
            font-size: 0.9rem;
            line-height: 1.4;
        }

        .message.own {
            align-self: flex-end;
            flex-direction: row-reverse;
            text-align: right;
        }

        .message.own p {
            background: var(--primary);
            border-color: var(--primary);
            color: #fff;
        }

        .chat-input {
            padding: 1rem;
            border-top: 1px solid var(--border);
            display: flex;
            gap: 0.75rem;
        }

        .chat-input input {
            flex: 1;
            padding: 0.75rem 1rem;
            background: var(--input-bg);
            border: 1px solid var(--border);
            border-radius: 6px;
            color: var(--text);
            outline: none;
        }

        .chat-input input:focus {
            border-color: var(--primary);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.65rem 1.25rem;
            border-radius: 6px;
            font-size: 0.875rem;
            font-weight: 600;
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
    </style>
</head>
<body>
<div class="app">
    <!-- BARRA LATERAL (NAVEGACIÓN) -->
    <aside class="sidebar">
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
            <a href="${pageContext.request.contextPath}/Proyecto"><i class="fa-solid fa-diagram-project"></i> <span>Proyectos</span></a>
            <a href="${pageContext.request.contextPath}/Asignaciones"><i class="fa-solid fa-list-check"></i> <span>Asignaciones</span></a>
            <a href="${pageContext.request.contextPath}/Tarea"><i class="fa-solid fa-tasks"></i> <span>Tareas</span></a>
            <a href="${pageContext.request.contextPath}/Chat" class="active"><i class="fa-solid fa-comments"></i> <span>Chat</span></a>
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
    <main class="content">
        <header class="topbar">
            <div>
                <p class="eyebrow">Comunicación</p>
                <h1>Chat del proyecto</h1>
                <p class="muted">Conversación interna de Proyecto Consultora.</p>
            </div>
            <span class="badge success">5 integrantes</span>
        </header>

        <section class="chat-layout">
            <!-- LISTA DE INTEGRANTES -->
            <aside class="chat-members">
                <div>
                    <h3>Proyecto Consultora</h3>
                    <small class="muted">Integrantes</small>
                </div>

                <div class="member">
                    <div class="avatar">JP</div>
                    <div>
                        <strong>Juan Pérez</strong>
                        <small class="online"><i class="fa-solid fa-circle" style="font-size: 8px;"></i> En línea</small>
                    </div>
                </div>

                <div class="member">
                    <div class="avatar">AG</div>
                    <div>
                        <strong>Ana Gómez</strong>
                        <small class="online"><i class="fa-solid fa-circle" style="font-size: 8px;"></i> En línea</small>
                    </div>
                </div>

                <div class="member">
                    <div class="avatar">DF</div>
                    <div>
                        <strong>Diego Fernández</strong>
                        <small class="online"><i class="fa-solid fa-circle" style="font-size: 8px;"></i> En línea</small>
                    </div>
                </div>

                <div class="member">
                    <div class="avatar">LM</div>
                    <div>
                        <strong>Luis Martínez</strong>
                        <small class="offline"><i class="fa-solid fa-circle" style="font-size: 8px;"></i> Offline</small>
                    </div>
                </div>
            </aside>

            <!-- VENTANA DE CHAT -->
            <div class="chat-window">
                <div class="chat-header">
                    <div>
                        <strong>Equipo de Proyecto Consultora</strong>
                        <small>Chat interno del proyecto</small>
                    </div>
                    <span class="badge success">En curso</span>
                </div>

                <div class="messages" id="messages">
                    <div class="message">
                        <div class="avatar">JP</div>
                        <div>
                            <strong>Juan Pérez <small>10:24</small></strong>
                            <p>¿Alguien puede revisar el módulo de usuarios?</p>
                        </div>
                    </div>

                    <div class="message">
                        <div class="avatar">AG</div>
                        <div>
                            <strong>Ana Gómez <small>10:26</small></strong>
                            <p>Sí, lo reviso ahora. También voy a actualizar el diseño.</p>
                        </div>
                    </div>

                    <div class="message own">
                        <div>
                            <strong>Admin <small>10:31</small></strong>
                            <p>Perfecto. Recordemos que la fecha límite es el 30/09.</p>
                        </div>
                        <div class="avatar">AD</div>
                    </div>
                </div>

                <form class="chat-input" onsubmit="sendMessage(event)">
                    <input id="messageInput" type="text" placeholder="Escribí un mensaje..." required autocomplete="off">
                    <button type="submit" class="btn primary">
                        <i class="fa-solid fa-paper-plane"></i>
                    </button>
                </form>
            </div>
        </section>
    </main>
</div>

<script>
    function sendMessage(event) {
        event.preventDefault();
        const input = document.getElementById('messageInput');
        const text = input.value.trim();
        
        if (text !== '') {
            const messagesContainer = document.getElementById('messages');
            const now = new Date();
            const timeStr = now.getHours().toString().padStart(2, '0') + ':' + now.getMinutes().toString().padStart(2, '0');
            
            const msgDiv = document.createElement('div');
            msgDiv.className = 'message own';
            msgDiv.innerHTML = `
                <div>
                    <strong>Admin <small>\${timeStr}</small></strong>
                    <p>\${text}</p>
                </div>
                <div class="avatar">AD</div>
            `;
            
            messagesContainer.appendChild(msgDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
            input.value = '';
        }
    }
</script>
<script src="${pageContext.request.contextPath}/scripts/script.js"></script>
</body>
</html>