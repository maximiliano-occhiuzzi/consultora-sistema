package com.consultora.sistema.dao.impl;

import com.consultora.sistema.dao.UsuarioDAO;
import com.consultora.sistema.db.ConexionDB;
import com.consultora.sistema.domain.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAOImpl implements UsuarioDAO {

    @Override
    public List<Usuario> listar() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Usuario(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Usuario obtenerPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Usuario obtenerPorUsername(String username) {
        String sql = "SELECT * FROM usuarios WHERE username = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password")
                    );
                }
            }
        } catch (Exception e) {
            System.err.println(">>> ERROR AL CONSULTAR USUARIO:");
            e.printStackTrace(); // Muestra el error exacto en el Console de Eclipse
        }
        return null;
    }

    @Override
    public boolean insertar(Usuario u) {
        String sql = "INSERT INTO usuarios (username, password) VALUES (?, ?)";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizar(Usuario u) {
        String sql = "UPDATE usuarios SET username = ?, password = ? WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());
            ps.setInt(3, u.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}