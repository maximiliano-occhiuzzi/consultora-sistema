package com.consultora.sistema.service.impl;

import com.consultora.sistema.dao.UsuarioDAO;
import com.consultora.sistema.dao.impl.UsuarioDAOImpl;
import com.consultora.sistema.domain.Usuario;
import com.consultora.sistema.service.UsuarioService;

public class UsuarioServiceImp implements UsuarioService {

    private final UsuarioDAO usuarioDAO;

    public UsuarioServiceImp() {
        this.usuarioDAO = new UsuarioDAOImpl();
    }

    @Override
    public boolean login(String username, String password) {
        return usuarioDAO.login(username, password);
    }

    @Override
    public Usuario buscarUsuarioPorNombre(String username) {
        return usuarioDAO.buscarPorNombre(username);
    }
}