package com.consultora.sistema.service.impl;

import com.consultora.sistema.dao.UsuarioDAO;
import com.consultora.sistema.dao.impl.UsuarioDAOImpl;
import com.consultora.sistema.domain.Usuario;
import com.consultora.sistema.service.UsuarioService;

public class UsuarioServiceImpl implements UsuarioService {

    private final UsuarioDAO usuarioDAO = new UsuarioDAOImpl();

    @Override
    public boolean login(String username, String passHash) {
        Usuario usuario = usuarioDAO.obtenerPorUsername(username);
        if (usuario != null) {
            return usuario.getPassword().equals(passHash);
        }
        return false;
    }

    @Override
    public Usuario buscarUsuarioPorNombre(String username) {
        return usuarioDAO.obtenerPorUsername(username);
    }
}