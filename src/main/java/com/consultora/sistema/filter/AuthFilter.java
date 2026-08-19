package com.consultora.sistema.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String ctx = request.getContextPath();

        // Rutas públicas — no requieren sesión
        boolean esPublica =
        		   uri.equals(ctx + "/Login")           ||
        		    uri.equals(ctx + "/Logout")          ||
        		    uri.contains("/vistas/login.jsp")    ||
        		    uri.contains("/vistas/Busqueda.jsp") ||
        		    uri.equals(ctx + "/Busqueda")        ||
        		    uri.equals(ctx + "/Imagen")          ||  // ← agregar
        		    uri.contains("/assets/")             ||
        		    uri.contains("/styles/");             // hojas de estilo

        if (esPublica) {
            chain.doFilter(request, response);
            return;
        }

        // Verificar sesión activa
        HttpSession session = request.getSession(false);
        boolean logueado = (session != null && session.getAttribute("usuarioId") != null);

        if (logueado) {
            chain.doFilter(request, response);
        } else {
            // AJAX → responde 401 JSON; navegación normal → redirige al login
            String xhr = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(xhr)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json");
                response.getWriter().print("{\"ok\":false,\"error\":\"Sesion expirada.\"}");
            } else {
                response.sendRedirect(ctx + "/vistas/login.jsp");
            }
        }
    }

    @Override
    public void destroy() {}
}