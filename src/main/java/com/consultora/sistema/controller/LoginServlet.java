package com.consultora.sistema.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.consultora.sistema.domain.Usuario;
import com.consultora.sistema.service.UsuarioService;
import com.consultora.sistema.service.impl.UsuarioServiceImpl;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UsuarioService usuarioService = new UsuarioServiceImpl();

    private String sha256(String input) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(input.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : hash) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    private String jsonEscape(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-store");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null
                || username.trim().isEmpty() || password.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            escribirJson(response, "{\"ok\":false,\"error\":\"Usuario y contraseña son obligatorios.\"}");
            return;
        }

        try {
            String passHash = sha256(password.trim());
            boolean valido = usuarioService.login(username.trim(), passHash);

            if (valido) {
                Usuario u = usuarioService.buscarUsuarioPorNombre(username.trim());

                // Evita reutilizar una sesión anterior (session fixation).
                HttpSession sesionAnterior = request.getSession(false);
                if (sesionAnterior != null) {
                    sesionAnterior.invalidate();
                }

                HttpSession session = request.getSession(true);
                session.setAttribute("usuarioId", u.getId());
                session.setAttribute("username", u.getUsername());
                session.setMaxInactiveInterval(30 * 60);

                escribirJson(response, "{\"ok\":true,\"username\":\"" + jsonEscape(u.getUsername()) + "\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                escribirJson(response, "{\"ok\":false,\"error\":\"Usuario o contraseña incorrectos.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            escribirJson(response, "{\"ok\":false,\"error\":\"Error interno del servidor.\"}");
        }
    }

    private void escribirJson(HttpServletResponse response, String json) throws IOException {
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuarioId") != null) {
            response.sendRedirect(request.getContextPath() + "/Dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/vistas/login.jsp");
        }
    }
}
