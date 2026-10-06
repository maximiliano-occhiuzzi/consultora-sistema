package com.consultora.sistema.dao.impl;

import com.consultora.sistema.dao.ProyectoDAO;
import com.consultora.sistema.db.ConexionDB;
import com.consultora.sistema.domain.Proyecto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProyectoDAOImpl implements ProyectoDAO {

    @Override
    public List<Proyecto> listar() {
        List<Proyecto> lista = new ArrayList<>();
        String sql = "SELECT * FROM proyectos";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Proyecto(
                    rs.getInt("id"),
                    rs.getString("nombre"),
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
    public Proyecto obtenerPorId(int id) {
        String sql = "SELECT * FROM proyectos WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Proyecto(
                        rs.getInt("id"),
                        rs.getString("nombre"),
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
    public boolean insertar(Proyecto p) {
        String sql = "INSERT INTO proyectos (nombre, descripcion, estado) VALUES (?, ?, ?)";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getEstado());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizar(Proyecto p) {
        String sql = "UPDATE proyectos SET nombre = ?, descripcion = ?, estado = ? WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setString(3, p.getEstado());
            ps.setInt(4, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM proyectos WHERE id = ?";
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