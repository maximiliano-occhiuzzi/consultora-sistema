package com.consultora.sistema.service;

import com.consultora.sistema.domain.Usuario;

public interface UsuarioService {
    boolean login(String username, String passHash);
    Usuario buscarUsuarioPorNombre(String username);
}