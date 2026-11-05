<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    request.setAttribute("activeNav", "proyectos");
    request.setAttribute("pageTitle", "Crear proyecto");
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<header class="topbar">
    <div>
        <p class="eyebrow">Nuevo proyecto</p>
        <h1>Crear proyecto</h1>
        <p class="muted">Ingresá los datos del proyecto para darlo de alta en el sistema.</p>
    </div>
    <a href="<%= ctxPath %>/Proyecto" class="btn secondary">
        <i class="fa-solid fa-arrow-left"></i> Volver
    </a>
</header>

<section class="form-card">
    <form action="<%= ctxPath %>/Proyecto" method="post">
        <div class="form-grid">
            <label class="full">
                Nombre del proyecto *
                <input type="text" name="nombre" placeholder="Ej. Aplicación Móvil" required autofocus>
            </label>

            <label>
                Estado inicial *
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
            <a class="btn secondary" href="<%= ctxPath %>/Proyecto">Cancelar</a>
            <button type="submit" class="btn primary">
                <i class="fa-solid fa-floppy-disk"></i> Guardar proyecto
            </button>
        </div>
    </form>
</section>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
