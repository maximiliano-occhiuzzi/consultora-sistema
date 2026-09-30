package com.consultora.sistema.service;

import com.consultora.sistema.domain.Usuario;

public interface UsuarioService {

    boolean login(String username, String password);

    Usuario buscarUsuarioPorNombre(String username);
}