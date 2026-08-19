<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Consulta Electoral — Padrón Nacional</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
        min-height: 100vh;
        background: #eef2f7;
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        display: flex;
        flex-direction: column;
    }

    /* ── HEADER ── */
    .pub-header {
        background: #1a2f5e;
        padding: 0 2rem;
        height: 64px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-shadow: 0 2px 12px rgba(0,0,0,0.18);
    }
    .pub-header-left {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }
    .pub-header-icon { font-size: 1.8rem; }
    .pub-header-title {
        color: #ffffff;
        font-size: 1.1rem;
        font-weight: 700;
        letter-spacing: 0.02em;
    }
    .pub-header-sub {
        color: #93c5fd;
        font-size: 0.75rem;
        font-weight: 400;
    }
    .pub-header-badge {
        background: rgba(255,255,255,0.12);
        color: #bfdbfe;
        border-radius: 20px;
        padding: 0.3rem 0.9rem;
        font-size: 0.78rem;
        font-weight: 600;
        border: 1px solid rgba(255,255,255,0.2);
    }

    /* ── HERO BANNER ── */
    .pub-hero {
        background: linear-gradient(135deg, #1a2f5e 0%, #2563eb 100%);
        padding: 3rem 2rem 2.5rem;
        text-align: center;
        color: white;
    }
    .pub-hero-icon { font-size: 3.5rem; margin-bottom: 0.75rem; }
    .pub-hero-title {
        font-size: 1.8rem;
        font-weight: 800;
        margin-bottom: 0.5rem;
        letter-spacing: -0.01em;
    }
    .pub-hero-sub {
        font-size: 1rem;
        color: #bfdbfe;
        max-width: 500px;
        margin: 0 auto;
    }

    /* ── CONTENIDO ── */
    .pub-content {
        flex: 1;
        display: flex;
        align-items: flex-start;
        justify-content: center;
        padding: 2.5rem 1rem;
    }

    .consulta-card {
        background: #ffffff;
        border-radius: 16px;
        box-shadow: 0 4px 32px rgba(0,0,0,0.10);
        padding: 2rem;
        width: 100%;
        max-width: 520px;
    }

    .consulta-card-titulo {
        font-size: 1rem;
        font-weight: 700;
        color: #1a2f5e;
        margin-bottom: 1.2rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        border-bottom: 2px solid #eef2f7;
        padding-bottom: 0.75rem;
    }

    .input-wrap {
        display: flex;
        gap: 0.75rem;
        margin-bottom: 1rem;
    }
    .consulta-input {
        flex: 1;
        font-size: 1rem;
        border-radius: 10px;
        border: 1.5px solid #cbd5e0;
        padding: 0.65rem 1rem;
        outline: none;
        transition: border-color 0.2s;
    }
    .consulta-input:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37,99,235,0.12);
    }
    .btn-consultar {
        background: #1a2f5e;
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 0.65rem 1.25rem;
        font-size: 0.95rem;
        font-weight: 700;
        cursor: pointer;
        transition: background 0.2s;
        white-space: nowrap;
    }
    .btn-consultar:hover    { background: #2563eb; }
    .btn-consultar:disabled { background: #9ca3af; cursor: not-allowed; }

    .input-hint {
        font-size: 0.8rem;
        color: #9ca3af;
        margin-bottom: 1.2rem;
    }

    /* ── RESULTADO ── */
    .resultado-box {
        border-radius: 12px;
        padding: 1.5rem;
        text-align: center;
        margin-top: 0.5rem;
    }
    .resultado-box.habilitado {
        background: #f0fdf4;
        border: 1.5px solid #86efac;
    }
    .resultado-box.inhabilitado {
        background: #fff1f2;
        border: 1.5px solid #fca5a5;
    }
    .resultado-icono  { font-size: 3rem; margin-bottom: 0.5rem; }
    .resultado-nombre { font-size: 1.15rem; font-weight: 700; color: #1a202c; margin-bottom: 0.2rem; }
    .resultado-dni    { font-size: 0.85rem; color: #718096; margin-bottom: 0.75rem; }
    .resultado-estado { font-size: 1.05rem; font-weight: 700; }
    .resultado-box.habilitado   .resultado-estado { color: #16a34a; }
    .resultado-box.inhabilitado .resultado-estado { color: #dc2626; }

    .resultado-error {
        background: #fff7ed;
        border: 1.5px solid #fed7aa;
        border-radius: 12px;
        padding: 1rem 1.5rem;
        text-align: center;
        color: #c2410c;
        font-weight: 600;
        margin-top: 0.5rem;
    }

    /* ── FOOTER ── */
    .pub-footer {
        background: #1a2f5e;
        color: #93c5fd;
        text-align: center;
        padding: 1rem;
        font-size: 0.8rem;
    }
    .pub-footer a {
        color: #bfdbfe;
        text-decoration: none;
        font-weight: 600;
    }
    .pub-footer a:hover { color: #fff; }
</style>
</head>
<body>

    <!-- HEADER -->
    <header class="pub-header">
        <div class="pub-header-left">
            <span class="pub-header-icon">🗳️</span>
            <div>
                <div class="pub-header-title">Padrón Nacional Electoral</div>
                <div class="pub-header-sub">Sistema de Gestión Electoral</div>
            </div>
        </div>
        <div class="pub-header-badge">🌐 Consulta Pública</div>
    </header>

    <!-- HERO -->
    <div class="pub-hero">
        <div class="pub-hero-icon">📋</div>
        <div class="pub-hero-title">Consulta de Habilitación Electoral</div>
        <div class="pub-hero-sub">Verificá si estás habilitado para participar en el proceso electoral ingresando tu número de documento</div>
    </div>

    <!-- CONTENIDO -->
    <div class="pub-content">
        <div class="consulta-card">

            <div class="consulta-card-titulo">
                🔍 Ingresar número de documento
            </div>

            <div class="input-wrap">
                <input type="text"
                       id="input-dni"
                       class="consulta-input"
                       placeholder="Ej: 12345678"
                       maxlength="20"
                       autofocus>
                <button class="btn-consultar" id="btn-consultar">
                    Verificar
                </button>
            </div>
            <div class="input-hint">Ingresá solo números, sin puntos ni espacios.</div>

            <div id="resultado"></div>

        </div>
    </div>

    <!-- FOOTER -->
    <footer class="pub-footer">
        Sistema de Gestión Electoral &nbsp;·&nbsp;
        ¿Sos administrador?
        <a href="${pageContext.request.contextPath}/vistas/login.jsp">Iniciar sesión →</a>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/jquery/jquery.min.js"></script>
    <script>
        const ctx = "${pageContext.request.contextPath}";

        function consultar() {
            const dni = $("#input-dni").val().trim();

            if (!dni) {
                $("#resultado").html('<div class="resultado-error">⚠️ Ingresá un número de documento.</div>');
                return;
            }

            $("#btn-consultar").prop("disabled", true).text("⏳");
            $("#resultado").html("");

            $.ajax({
                url: ctx + "/Busqueda",
                type: "GET",
                data: { dni: dni },
                dataType: "json",

                success: function(data) {
                    if (data.ok) {
                        var clase  = data.habilitado ? "habilitado"            : "inhabilitado";
                        var icono  = data.habilitado ? "✅"                    : "🚫";
                        var estado = data.habilitado ? "Habilitado para votar" : "No habilitado para votar";

                        $("#resultado").html(
                            '<div class="resultado-box ' + clase + '">' +
                                '<div class="resultado-icono">' + icono + '</div>' +
                                '<div class="resultado-nombre">' + data.apellido + ', ' + data.nombre + '</div>' +
                                '<div class="resultado-dni">DNI: ' + data.dni + '</div>' +
                                '<div class="resultado-estado">' + estado + '</div>' +
                            '</div>'
                        );
                    } else {
                        $("#resultado").html('<div class="resultado-error">⚠️ ' + data.error + '</div>');
                    }
                },

                error: function(xhr) {
                    var msg = "Error al conectar con el servidor.";
                    if (xhr.responseJSON && xhr.responseJSON.error) {
                        msg = xhr.responseJSON.error;
                    }
                    $("#resultado").html('<div class="resultado-error">⚠️ ' + msg + '</div>');
                },

                complete: function() {
                    $("#btn-consultar").prop("disabled", false).text("Verificar");
                }
            });
        }

        $("#btn-consultar").on("click", consultar);
        $("#input-dni").on("keypress", function(e) {
            if (e.which === 13) consultar();
        });
    </script>

</body>
</html>
