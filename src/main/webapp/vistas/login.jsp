<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    if (session != null && session.getAttribute("usuarioId") != null) {
        response.sendRedirect(request.getContextPath() + "/Dashboard");
        return;
    }
    String ctxLogin = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión | TechConsult</title>
    <link rel="stylesheet" href="<%= ctxLogin %>/styles/estilos.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="login-page">
    <div class="login-shell">
        <section class="login-brand-panel">
            <div>
                <div class="brand">
                    <span class="brand-dot">TC</span>
                    <span>
                        <strong>TechConsult</strong>
                        <small>Administración de proyectos</small>
                    </span>
                </div>
            </div>

            <div>
                <p class="eyebrow">TechConsult</p>
                <h1>Tu consultora, organizada de punta a punta.</h1>
                <p>Gestioná empleados, proyectos, tareas y asignaciones desde un único panel.</p>

                <div class="login-features">
                    <span><i class="fa-solid fa-users"></i> Equipos y disponibilidad</span>
                    <span><i class="fa-solid fa-diagram-project"></i> Proyectos y avance real</span>
                    <span><i class="fa-solid fa-list-check"></i> Tareas por proyecto</span>
                </div>
            </div>

            <small class="muted">Acceso exclusivo para administradores.</small>
        </section>

        <section class="login-form-panel">
            <p class="eyebrow">Bienvenido</p>
            <h2>Iniciar sesión</h2>
            <p>Ingresá tus credenciales para acceder al panel.</p>

            <form id="loginForm" class="login-form" novalidate>
                <label>
                    Usuario
                    <input type="text" id="username" name="username" placeholder="Tu usuario" autocomplete="username" required autofocus>
                </label>

                <label>
                    Contraseña
                    <input type="password" id="password" name="password" placeholder="Tu contraseña" autocomplete="current-password" required>
                </label>

                <div id="mensajeError" class="login-error" role="alert"></div>

                <button type="submit" class="btn primary btn-block" id="btnLogin">
                    <i class="fa-solid fa-right-to-bracket"></i> Ingresar
                </button>
            </form>

            <p class="login-footer">Sistema interno de gestión · TechConsult</p>
        </section>
    </div>
</div>

<script>
    const baseUrl = '<%= ctxLogin %>';

    document.getElementById('loginForm').addEventListener('submit', async (event) => {
        event.preventDefault();

        const errorBox = document.getElementById('mensajeError');
        const boton = document.getElementById('btnLogin');
        errorBox.textContent = '';

        const formData = new URLSearchParams(new FormData(event.target));

        boton.disabled = true;
        boton.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Ingresando...';

        try {
            const res = await fetch(baseUrl + '/Login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: formData
            });

            const contentType = res.headers.get('content-type') || '';
            if (!contentType.includes('application/json')) {
                errorBox.textContent = 'El servidor no respondió correctamente. Intentá nuevamente.';
                return;
            }

            const data = await res.json();
            if (res.ok && data.ok) {
                window.location.href = baseUrl + '/Dashboard';
            } else {
                errorBox.textContent = data.error || 'Usuario o contraseña incorrectos.';
            }
        } catch (error) {
            console.error('Error de login:', error);
            errorBox.textContent = 'No se pudo conectar con el servidor.';
        } finally {
            boton.disabled = false;
            boton.innerHTML = '<i class="fa-solid fa-right-to-bracket"></i> Ingresar';
        }
    });
</script>
</body>
</html>
