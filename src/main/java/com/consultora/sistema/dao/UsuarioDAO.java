package com.consultora.sistema.dao;

import com.consultora.sistema.domain.Usuario;
import java.util.List;

public interface UsuarioDAO {
    List<Usuario> listar();
    Usuario obtenerPorId(int id);
    Usuario obtenerPorUsername(String username);
    boolean insertar(Usuario usuario);
    boolean actualizar(Usuario usuario);
    boolean eliminar(int id);
}