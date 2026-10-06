package com.consultora.sistema.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.consultora.sistema.domain.Usuario;
import com.consultora.sistema.service.UsuarioService;
import com.consultora.sistema.service.impl.UsuarioServiceImpl;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UsuarioService usuarioService = new UsuarioServiceImpl();

    private String sha256(String input) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(input.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : hash) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password  = request.getParameter("password");

        if (username == null || password == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = response.getWriter();
            out.print("{\"ok\":false,\"error\":\"Usuario y contraseña son obligatorios.\"}");
            out.flush();
            return;
        }

        try {
            String passHash = sha256(password.trim());
            boolean valido  = usuarioService.login(username.trim(), passHash);

            if (valido) {
                HttpSession session = request.getSession(true);
                Usuario u = usuarioService.buscarUsuarioPorNombre(username.trim());
                session.setAttribute("usuarioId",   u.getId());
                session.setAttribute("username",    u.getUsername());
                session.setMaxInactiveInterval(30 * 60); // 30 minutos

                PrintWriter out = response.getWriter();
                out.print("{\"ok\":true,\"username\":\"" + u.getUsername() + "\"}");
                out.flush();

            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                PrintWriter out = response.getWriter();
                out.print("{\"ok\":false,\"error\":\"Usuario o contraseña incorrectos.\"}");
                out.flush();
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.print("{\"ok\":false,\"error\":\"Error interno del servidor.\"}");
            out.flush();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/vistas/login.jsp");
    }
}