<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Persona</title>
        <link href="${pageContext.request.contextPath}/assets/boostrap/css/bootstrap.min.css">
</head>
<body>

    <!-- CORRECCIÓN: Agregado el action dinámico con el Context Path -->
    <form id="formPersona" action="${pageContext.request.contextPath}/Persona">
        <input type="text" name="dni" placeholder="DNI" required> 
        <input type="text" name="apellido" placeholder="Apellido" required>
        <input type="text" name="nombre" placeholder="Nombre" required>
        <input type="date" name="fechaNac" required> 
        <select name="sexo">
            <option value="M">M</option>
            <option value="F">F</option>
            <option value="X">X</option>
        </select> 
        <input type="text" name="domicilio" placeholder="Domicilio">
        <input type="file" name="imagen" accept="image/*">

        <button type="submit">Registrar Persona</button>
    </form>
    <li><a href="${pageContext.request.contextPath}/vistas/listar.jsp" class="sidebar-nav-link"> <span
						class="nav-icon">➕</span> listar
				</a></li>

    <div id="mensaje"></div>
	<script>
		const ctx = "${pageContext.request.contextPath}";
	</script>
    <!-- Importación de librerías según tu estructura de carpetas en Eclipse -->
    <script src="${pageContext.request.contextPath}/assets/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/scripts/persona.js"></script>

</body>
</html>
