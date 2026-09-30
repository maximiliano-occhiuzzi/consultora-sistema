package com.consultora.sistema.dao;

import com.consultora.sistema.domain.Usuario;

public interface UsuarioDAO {

    boolean login(String username, String password);

    Usuario buscarPorNombre(String username);
}