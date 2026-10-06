<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - TechConsult</title>
</head>
<body>
    <h2>Iniciar Sesión</h2>
    <div id="mensajeError" style="color: red;"></div>
    
    <form id="loginForm">
        <label>Usuario:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label>Contraseña:</label>
        <input type="password" id="password" name="password" required><br><br>
        <button type="submit">Ingresar</button>
    </form>

    <script>
        document.getElementById('loginForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new URLSearchParams(new FormData(e.target));

            const res = await fetch('${pageContext.request.contextPath}/Login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            });

            const data = await res.json();
            if (data.ok) {
                window.location.href = '${pageContext.request.contextPath}/Dashboard';
            } else {
                document.getElementById('mensajeError').innerText = data.error;
            }
        });
    </script>
</body>
</html>