<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Iniciar Sesión — Padrón Electoral</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
<style>
    body {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #eef2f7;
        margin: 0;
    }
    .login-card {
        background: #ffffff;
        border-radius: 16px;
        box-shadow: 0 4px 32px rgba(0,0,0,0.10);
        padding: 2.5rem 2rem;
        width: 100%;
        max-width: 420px;
    }
    .login-logo {
        font-size: 2.8rem;
        text-align: center;
        margin-bottom: 0.25rem;
    }
    .login-titulo {
        text-align: center;
        font-size: 1.3rem;
        font-weight: 700;
        color: #1a2f5e;
        margin-bottom: 0.2rem;
    }
    .login-sub {
        text-align: center;
        font-size: 0.85rem;
        color: #718096;
        margin-bottom: 2rem;
    }
    .login-label {
        font-size: 0.85rem;
        font-weight: 600;
        color: #374151;
        margin-bottom: 0.3rem;
        display: block;
    }
    .login-input {
        width: 100%;
        padding: 0.65rem 1rem;
        border: 1.5px solid #cbd5e0;
        border-radius: 10px;
        font-size: 1rem;
        outline: none;
        box-sizing: border-box;
        transition: border-color 0.2s;
        margin-bottom: 1rem;
    }
    .login-input:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37,99,235,0.12);
    }
    .btn-login {
        width: 100%;
        background: #1a2f5e;
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 0.75rem;
        font-size: 1rem;
        font-weight: 700;
        cursor: pointer;
        margin-top: 0.5rem;
        transition: background 0.2s;
        letter-spacing: 0.03em;
    }
    .btn-login:hover    { background: #2563eb; }
    .btn-login:disabled { background: #9ca3af; cursor: not-allowed; }

    .alerta-error {
        background: #fef2f2;
        border: 1.5px solid #fca5a5;
        border-radius: 10px;
        padding: 0.75rem 1rem;
        color: #dc2626;
        font-size: 0.9rem;
        font-weight: 600;
        margin-top: 1rem;
        display: none;
    }
    .link-ciudadano {
        display: block;
        text-align: center;
        margin-top: 1.5rem;
        font-size: 0.85rem;
        color: #718096;
        text-decoration: none;
    }
    .link-ciudadano:hover { color: #2563eb; }
</style>
</head>
<body>

    <div class="login-card">

        <div class="login-logo">🗳️</div>
        <div class="login-titulo">Padrón Electoral</div>
        <div class="login-sub">Sistema de Gestión Electoral — Acceso Administrador</div>

        <label class="login-label" for="input-user">Usuario</label>
        <input type="text"
               id="input-user"
               class="login-input"
               placeholder="Ingresá tu usuario"
               autocomplete="username"
               autofocus>

        <label class="login-label" for="input-pass">Contraseña</label>
        <input type="password"
               id="input-pass"
               class="login-input"
               placeholder="Ingresá tu contraseña"
               autocomplete="current-password">

        <button class="btn-login" id="btn-login">
            🔐 Ingresar al sistema
        </button>

        <div class="alerta-error" id="alerta-error"></div>

        <a href="${pageContext.request.contextPath}/vistas/Busqueda.jsp"
           class="link-ciudadano">
            ¿Sos ciudadano? Consultá tu habilitación →
        </a>

    </div>

    <script src="${pageContext.request.contextPath}/assets/jquery/jquery.min.js"></script>
    <script>
        const ctx = "${pageContext.request.contextPath}";

        function login() {
            const user = $("#input-user").val().trim();
            const pass = $("#input-pass").val().trim();

            if (!user || !pass) {
                mostrarError("Completá usuario y contraseña.");
                return;
            }

            $("#btn-login").prop("disabled", true).text("⏳ Verificando...");
            $("#alerta-error").hide();

            $.ajax({
                url:  ctx + "/Login",
                type: "POST",
                data: { username: user, password: pass },
                dataType: "json",

                success: function(data) {
                    if (data.ok) {
                        window.location.href = ctx + "/vistas/listar.jsp";
                    } else {
                        mostrarError(data.error || "Credenciales incorrectas.");
                        resetBtn();
                    }
                },

                error: function(xhr) {
                    var msg = "Error al conectar con el servidor.";
                    if (xhr.responseJSON && xhr.responseJSON.error) {
                        msg = xhr.responseJSON.error;
                    }
                    mostrarError(msg);
                    resetBtn();
                }
            });
        }

        function mostrarError(msg) {
            $("#alerta-error").text("⚠️ " + msg).show();
        }

        function resetBtn() {
            $("#btn-login").prop("disabled", false).text("🔐 Ingresar al sistema");
        }

        $("#btn-login").on("click", login);

        // Enter en cualquiera de los dos inputs
        $("#input-user, #input-pass").on("keypress", function(e) {
            if (e.which === 13) login();
        });
    </script>

</body>
</html>
