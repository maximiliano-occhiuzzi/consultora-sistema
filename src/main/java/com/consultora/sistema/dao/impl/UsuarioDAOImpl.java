package com.consultora.sistema.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.consultora.sistema.dao.UsuarioDAO;
import com.consultora.sistema.db.ConexionDB;
import com.consultora.sistema.domain.Usuario;

public class UsuarioDAOImpl implements UsuarioDAO {

    @Override
    public boolean login(String username, String password) {

        String sql = "SELECT id FROM usuario WHERE username = ? AND password = ?";

        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Usuario buscarPorNombre(String username) {

        Usuario usuario = null;

        String sql = "SELECT id, username, password FROM usuario WHERE username = ?";

        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    usuario = new Usuario();

                    usuario.setId(rs.getInt("id"));
                    usuario.setUsername(rs.getString("username"));
                    usuario.setPassword(rs.getString("password"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuario;
    }
}