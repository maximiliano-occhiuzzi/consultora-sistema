package com.consultora.sistema.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String uri = request.getRequestURI();
        String ctx = request.getContextPath();

        // La raíz redirige al dashboard o al login, nunca deja una página vacía.
        if (uri.equals(ctx + "/") || uri.equals(ctx)) {
            HttpSession session = request.getSession(false);
            boolean logueado = session != null && session.getAttribute("usuarioId") != null;
            response.sendRedirect(ctx + (logueado ? "/Dashboard" : "/vistas/login.jsp"));
            return;
        }

        // Rutas públicas: login, logout y recursos estáticos.
        boolean esPublica =
                uri.equals(ctx + "/Login") ||
                uri.equals(ctx + "/Logout") ||
                uri.contains("/vistas/login.jsp") ||
                uri.contains("/assets/") ||
                uri.contains("/css/") ||
                uri.contains("/js/") ||
                uri.contains("/scripts/") ||
                uri.contains("/styles/") ||
                uri.endsWith("/favicon.ico");

        if (esPublica) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        boolean logueado = session != null && session.getAttribute("usuarioId") != null;

        if (logueado) {
            chain.doFilter(request, response);
        } else {
            String xhr = request.getHeader("X-Requested-With");
            String accept = request.getHeader("Accept");
            boolean esperaJson = "XMLHttpRequest".equals(xhr)
                    || (accept != null && accept.contains("application/json"));

            if (esperaJson) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().print("{\"ok\":false,\"error\":\"Sesión expirada.\"}");
            } else {
                response.sendRedirect(ctx + "/vistas/login.jsp");
            }
        }
    }

    @Override
    public void destroy() {
    }
}
