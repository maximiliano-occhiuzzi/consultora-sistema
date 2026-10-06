package com.consultora.sistema.dao.impl;

import com.consultora.sistema.dao.TareaDAO;
import com.consultora.sistema.db.ConexionDB;
import com.consultora.sistema.domain.Tarea;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TareaDAOImpl implements TareaDAO {

    @Override
    public List<Tarea> listar() {
        List<Tarea> lista = new ArrayList<>();
        String sql = "SELECT * FROM tareas";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Tarea(
                    rs.getInt("id"),
                    rs.getString("titulo"),
                    rs.getString("descripcion"),
                    rs.getString("estado")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Tarea obtenerPorId(int id) {
        String sql = "SELECT * FROM tareas WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Tarea(
                        rs.getInt("id"),
                        rs.getString("titulo"),
                        rs.getString("descripcion"),
                        rs.getString("estado")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insertar(Tarea t) {
        String sql = "INSERT INTO tareas (titulo, descripcion, estado) VALUES (?, ?, ?)";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, t.getTitulo());
            ps.setString(2, t.getDescripcion());
            ps.setString(3, t.getEstado());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizar(Tarea t) {
        String sql = "UPDATE tareas SET titulo = ?, descripcion = ?, estado = ? WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, t.getTitulo());
            ps.setString(2, t.getDescripcion());
            ps.setString(3, t.getEstado());
            ps.setInt(4, t.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM tareas WHERE id = ?";
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