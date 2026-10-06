<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TechConsult | Inicio</title>
  <!-- Íconos FontAwesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <style>
    :root {
      --bg-color: #f1f5f9;
      --sidebar-bg: #0f172a;
      --card-bg: #ffffff;
      --text-primary: #0f172a;
      --text-muted: #64748b;
      --primary: #2563eb;
      --primary-hover: #1d4ed8;
      --border: #e2e8f0;
      
      --blue: #2563eb;
      --purple: #7c3aed;
      --green: #10b981;
      --red: #ef4444;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    }

    body {
      background-color: var(--bg-color);
      color: var(--text-primary);
    }

    .app {
      display: flex;
      min-height: 100vh;
    }

    /* SIDEBAR */
    .sidebar {
      width: 260px;
      background-color: var(--sidebar-bg);
      color: #ffffff;
      display: flex;
      flex-direction: column;
      padding: 1.5rem 1rem;
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
      width: 40px;
      height: 40px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      font-size: 0.95rem;
      color: #ffffff;
    }

    .brand small {
      display: block;
      color: #94a3b8;
      font-size: 0.75rem;
    }

    .sidebar nav {
      display: flex;
      flex-direction: column;
      gap: 0.35rem;
      flex: 1;
    }

    .sidebar nav a {
      color: #94a3b8;
      text-decoration: none;
      padding: 0.75rem 1rem;
      border-radius: 8px;
      display: flex;
      align-items: center;
      gap: 0.85rem;
      font-size: 0.9rem;
      font-weight: 500;
      transition: all 0.2s ease;
    }

    .sidebar nav a:hover {
      background: rgba(255, 255, 255, 0.05);
      color: #ffffff;
    }

    .sidebar nav a.active {
      background: var(--primary);
      color: #ffffff;
    }

    .sidebar nav a i {
      width: 18px;
      text-align: center;
    }

    .user-box {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      padding-top: 1rem;
      border-top: 1px solid #1e293b;
    }

    .avatar {
      width: 38px;
      height: 38px;
      border-radius: 50%;
      background: #334155;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      font-size: 0.85rem;
      color: #ffffff;
    }

    /* CONTENIDO PRINCIPAL */
    .content {
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
      color: var(--text-primary);
      margin: 0.1rem 0;
    }

    .muted {
      color: var(--text-muted);
      font-size: 0.875rem;
    }

    .top-actions {
      display: flex;
      align-items: center;
      gap: 1.25rem;
    }

    .notification {
      position: relative;
      cursor: pointer;
      color: var(--text-muted);
      font-size: 1.1rem;
    }

    .notification b {
      position: absolute;
      top: -2px;
      right: -2px;
      width: 8px;
      height: 8px;
      background: var(--red);
      border-radius: 50%;
    }

    .logout-btn {
      color: var(--text-muted);
      font-size: 1.1rem;
      text-decoration: none;
      transition: color 0.2s;
    }

    .logout-btn:hover {
      color: var(--red);
    }

    /* TARJETAS METRICAS */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 1.25rem;
      margin-bottom: 2rem;
    }

    .stat-card {
      background: var(--card-bg);
      padding: 1.25rem;
      border-radius: 12px;
      border: 1px solid var(--border);
      display: flex;
      align-items: center;
      gap: 1rem;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
    }

    .stat-icon {
      width: 48px;
      height: 48px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.2rem;
      flex-shrink: 0;
    }

    .stat-icon.blue { background: #eff6ff; color: var(--blue); }
    .stat-icon.purple { background: #f5f3ff; color: var(--purple); }
    .stat-icon.green { background: #ecfdf5; color: var(--green); }
    .stat-icon.red { background: #fef2f2; color: var(--red); }

    .stat-card span { font-size: 0.85rem; color: var(--text-muted); display: block; }
    .stat-card strong { font-size: 1.5rem; color: var(--text-primary); font-weight: 700; line-height: 1.2; }
    .stat-card small { color: var(--text-muted); font-size: 0.75rem; }
    .stat-card small.positive { color: var(--green); font-weight: 600; }

    /* SECCIONES Y TABLAS */
    .section-card {
      background: var(--card-bg);
      border-radius: 12px;
      border: 1px solid var(--border);
      padding: 1.5rem;
      margin-bottom: 2rem;
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
    }

    .section-heading {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.25rem;
    }

    .section-heading h2 {
      font-size: 1.15rem;
      font-weight: 600;
      color: var(--text-primary);
    }

    .text-link {
      color: var(--primary);
      text-decoration: none;
      font-size: 0.875rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.4rem;
    }

    .text-link:hover {
      text-decoration: underline;
    }

    .table-wrap {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      text-align: left;
    }

    th {
      background: #f8fafc;
      color: var(--text-muted);
      font-size: 0.75rem;
      text-transform: uppercase;
      letter-spacing: 0.05em;
      font-weight: 600;
      padding: 0.75rem 1rem;
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

    td strong {
      display: block;
      color: var(--text-primary);
    }

    td small {
      color: var(--text-muted);
      font-size: 0.8rem;
    }

    .badge {
      padding: 0.25rem 0.65rem;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 600;
      display: inline-block;
    }

    .badge.success { background: #d1fae5; color: #065f46; }
    .badge.info { background: #e0f2fe; color: #075985; }

    .progress-container {
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .progress {
      flex: 1;
      height: 6px;
      background: #e2e8f0;
      border-radius: 4px;
      overflow: hidden;
    }

    .progress i {
      display: block;
      height: 100%;
      background: var(--primary);
      border-radius: 4px;
    }

    /* DOS COLUMNAS */
    .two-columns {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.5rem;
    }

    .activity-list {
      display: flex;
      flex-direction: column;
      gap: 1.1rem;
    }

    .activity {
      display: flex;
      align-items: flex-start;
      gap: 0.75rem;
      font-size: 0.875rem;
    }

    .activity-dot {
      width: 8px;
      height: 8px;
      border-radius: 50%;
      margin-top: 0.4rem;
      flex-shrink: 0;
    }

    .activity-dot.green { background: var(--green); }
    .activity-dot.blue { background: var(--blue); }
    .activity-dot.purple { background: var(--purple); }

    .activity strong {
      color: var(--text-primary);
    }

    .activity small {
      display: block;
      color: var(--text-muted);
      font-size: 0.75rem;
      margin-top: 0.1rem;
    }

    .quick-actions {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 0.75rem;
    }

    .quick {
      background: #f8fafc;
      border: 1px solid var(--border);
      color: var(--text-primary);
      text-decoration: none;
      padding: 0.85rem 1rem;
      border-radius: 8px;
      font-size: 0.85rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.6rem;
      transition: all 0.2s ease;
    }

    .quick:hover {
      background: #ffffff;
      border-color: var(--primary);
      color: var(--primary);
      box-shadow: 0 2px 4px rgba(37, 99, 235, 0.05);
    }

    .quick i {
      color: var(--primary);
    }
  </style>
</head>
<body>
  <div class="app">
    <!-- BARRA LATERAL -->
    <aside class="sidebar">
      <div class="brand">
        <span class="brand-dot">TC</span>
        <div>
          <strong>TechConsult</strong>
          <small>Administración</small>
        </div>
      </div>
      
      <nav>
  <a class="active" href="${pageContext.request.contextPath}/dashboard"><i class="fa-solid fa-house"></i> <span>Inicio</span></a>
  <a href="${pageContext.request.contextPath}/Empleado"><i class="fa-solid fa-users"></i> <span>Empleados</span></a>
  <a href="${pageContext.request.contextPath}/Proyecto"><i class="fa-solid fa-diagram-project"></i> <span>Proyectos</span></a>
  <a href="${pageContext.request.contextPath}/Asignaciones"><i class="fa-solid fa-list-check"></i> <span>Asignaciones</span></a>
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
    <main class="content">
      <header class="topbar">
        <div>
          <p class="eyebrow">Panel de control</p>
          <h1>Bienvenido, ${sessionScope.username != null ? sessionScope.username : 'Admin'}</h1>
          <p class="muted">Resumen del estado actual de la consultora.</p>
        </div>
        <div class="top-actions">
          <span class="notification"><i class="fa-regular fa-bell"></i><b></b></span>
          <a href="${pageContext.request.contextPath}/Logout" class="logout-btn" title="Cerrar Sesión">
            <i class="fa-solid fa-right-from-bracket"></i>
          </a>
        </div>
      </header>

      <!-- TARJETAS DE ESTADÍSTICAS -->
      <section class="stats-grid">
        <div class="stat-card">
          <span class="stat-icon blue"><i class="fa-solid fa-users"></i></span>
          <div>
            <span>Empleados</span>
            <strong>24</strong>
            <small class="positive">+2 esta semana</small>
          </div>
        </div>
        <div class="stat-card">
          <span class="stat-icon purple"><i class="fa-solid fa-folder-open"></i></span>
          <div>
            <span>Proyectos activos</span>
            <strong>8</strong>
            <small class="positive">+1 esta semana</small>
          </div>
        </div>
        <div class="stat-card">
          <span class="stat-icon green"><i class="fa-solid fa-circle-check"></i></span>
          <div>
            <span>En línea</span>
            <strong>17</strong>
            <small>de 24 empleados</small>
          </div>
        </div>
        <div class="stat-card">
          <span class="stat-icon red"><i class="fa-solid fa-circle-minus"></i></span>
          <div>
            <span>Desconectados</span>
            <strong>7</strong>
            <small>de 24 empleados</small>
          </div>
        </div>
      </section>

      <!-- TABLA DE PROYECTOS -->
      <section class="section-card">
        <div class="section-heading">
          <div>
            <h2>Proyectos recientes</h2>
            <p class="muted">Vista general de los proyectos en seguimiento.</p>
          </div>
          <a class="text-link" href="${pageContext.request.contextPath}/Proyecto">Ver todos <i class="fa-solid fa-arrow-right"></i></a>
        </div>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Proyecto</th>
                <th>Estado</th>
                <th>Fecha límite</th>
                <th>Equipo</th>
                <th>Progreso</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <strong>Proyecto Consultora</strong>
                  <small>Sistema de gestión interna</small>
                </td>
                <td><span class="badge success">En curso</span></td>
                <td>30/09/2026</td>
                <td>5 integrantes</td>
                <td>
                  <div class="progress-container">
                    <div class="progress"><i style="width:62%"></i></div>
                    <small>62%</small>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <strong>Aplicación Móvil</strong>
                  <small>App para clientes</small>
                </td>
                <td><span class="badge success">En curso</span></td>
                <td>15/10/2026</td>
                <td>4 integrantes</td>
                <td>
                  <div class="progress-container">
                    <div class="progress"><i style="width:40%"></i></div>
                    <small>40%</small>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <strong>Portal Web</strong>
                  <small>Portal institucional</small>
                </td>
                <td><span class="badge info">Planificado</span></td>
                <td>01/11/2026</td>
                <td>3 integrantes</td>
                <td>
                  <div class="progress-container">
                    <div class="progress"><i style="width:20%"></i></div>
                    <small>20%</small>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <!-- SECCIÓN DOS COLUMNAS -->
      <section class="two-columns">
        <div class="section-card">
          <div class="section-heading">
            <div>
              <h2>Actividad reciente</h2>
              <p class="muted">Últimos movimientos del sistema.</p>
            </div>
          </div>
          <div class="activity-list">
            <div class="activity">
              <span class="activity-dot green"></span>
              <div>
                <strong>Juan Pérez</strong> completó una tarea
                <small>Hace 12 minutos</small>
              </div>
            </div>
            <div class="activity">
              <span class="activity-dot blue"></span>
              <div>
                <strong>Admin</strong> creó un nuevo proyecto
                <small>Hace 35 minutos</small>
              </div>
            </div>
            <div class="activity">
              <span class="activity-dot purple"></span>
              <div>
                <strong>Ana Gómez</strong> fue asignada a Proyecto Consultora
                <small>Hace 1 hora</small>
              </div>
            </div>
          </div>
        </div>

        <div class="section-card">
          <div class="section-heading">
            <div>
              <h2>Acciones rápidas</h2>
            </div>
          </div>
          <div class="quick-actions">
           <a href="${pageContext.request.contextPath}/Empleado" class="quick"><i class="fa-solid fa-user-plus"></i> Registrar empleado</a>
            <a href="${pageContext.request.contextPath}/Proyecto" class="quick"><i class="fa-solid fa-folder-plus"></i> Crear proyecto</a>
            <a href="${pageContext.request.contextPath}/Asignaciones" class="quick"><i class="fa-solid fa-list-check"></i> Gestionar asignaciones</a>
            <a href="${pageContext.request.contextPath}/Tarea" class="quick"><i class="fa-solid fa-tasks"></i> Ver tareas</a>
          </div>
        </div>
      </section>
    </main>
  </div>
</body>
</html>