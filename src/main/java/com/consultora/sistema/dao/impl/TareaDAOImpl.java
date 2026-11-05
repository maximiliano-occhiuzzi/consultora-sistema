package com.consultora.sistema.dao.impl;

import com.consultora.sistema.dao.TareaDAO;
import com.consultora.sistema.db.ConexionDB;
import com.consultora.sistema.domain.Tarea;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TareaDAOImpl implements TareaDAO {

    private static final String SELECT_BASE =
            "SELECT t.id, t.titulo, t.descripcion, t.estado, " +
            "COALESCE(t.id_proyecto, 0) AS id_proyecto, p.nombre AS proyecto_nombre " +
            "FROM tareas t LEFT JOIN proyectos p ON t.id_proyecto = p.id ";

    @Override
    public List<Tarea> listar() {
        List<Tarea> lista = new ArrayList<>();
        String sql = SELECT_BASE + "ORDER BY t.id";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public List<Tarea> listarPorProyecto(int idProyecto) {
        List<Tarea> lista = new ArrayList<>();
        String sql = SELECT_BASE + "WHERE t.id_proyecto = ? ORDER BY t.id";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idProyecto);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapear(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Tarea obtenerPorId(int id) {
        String sql = SELECT_BASE + "WHERE t.id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insertar(Tarea t) {
        String sql = "INSERT INTO tareas (titulo, descripcion, estado, id_proyecto) VALUES (?, ?, ?, ?)";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, t.getTitulo());
            ps.setString(2, t.getDescripcion());
            ps.setString(3, t.getEstado());
            setProyecto(ps, 4, t.getIdProyecto());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizar(Tarea t) {
        String sql = "UPDATE tareas SET titulo = ?, descripcion = ?, estado = ?, id_proyecto = ? WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, t.getTitulo());
            ps.setString(2, t.getDescripcion());
            ps.setString(3, t.getEstado());
            setProyecto(ps, 4, t.getIdProyecto());
            ps.setInt(5, t.getId());
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

    private Tarea mapear(ResultSet rs) throws SQLException {
        Tarea t = new Tarea(
                rs.getInt("id"),
                rs.getString("titulo"),
                rs.getString("descripcion"),
                rs.getString("estado"),
                rs.getInt("id_proyecto")
        );
        t.setNombreProyecto(rs.getString("proyecto_nombre"));
        return t;
    }

    private void setProyecto(PreparedStatement ps, int index, int idProyecto) throws SQLException {
        if (idProyecto > 0) {
            ps.setInt(index, idProyecto);
        } else {
            ps.setNull(index, Types.INTEGER);
        }
    }
}
