package com.consultora.sistema.dao.impl;

import com.consultora.sistema.dao.AsignacionTareaDAO;
import com.consultora.sistema.db.ConexionDB;
import com.consultora.sistema.domain.AsignacionTarea;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsignacionTareaDAOImpl implements AsignacionTareaDAO {

    @Override
    public List<AsignacionTarea> listar() {
        List<AsignacionTarea> lista = new ArrayList<>();
        String sql = "SELECT at.id, at.id_empleado, at.id_tarea, " +
                "CONCAT(e.nombre, ' ', e.apellido) AS empleado_nombre, " +
                "t.titulo AS tarea_titulo, t.estado AS tarea_estado, " +
                "COALESCE(t.id_proyecto, 0) AS id_proyecto, p.nombre AS proyecto_nombre " +
                "FROM asignaciones_tarea at " +
                "JOIN empleados e ON at.id_empleado = e.id " +
                "JOIN tareas t ON at.id_tarea = t.id " +
                "LEFT JOIN proyectos p ON t.id_proyecto = p.id " +
                "ORDER BY at.id";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new AsignacionTarea(
                        rs.getInt("id"),
                        rs.getInt("id_empleado"),
                        rs.getInt("id_tarea"),
                        rs.getString("empleado_nombre"),
                        rs.getString("tarea_titulo"),
                        rs.getString("tarea_estado"),
                        rs.getInt("id_proyecto"),
                        rs.getString("proyecto_nombre")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public boolean existe(int idEmpleado, int idTarea) {
        String sql = "SELECT 1 FROM asignaciones_tarea WHERE id_empleado = ? AND id_tarea = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idEmpleado);
            ps.setInt(2, idTarea);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean insertar(AsignacionTarea at) {
        String sql = "INSERT INTO asignaciones_tarea (id_empleado, id_tarea) VALUES (?, ?)";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, at.getIdEmpleado());
            ps.setInt(2, at.getIdTarea());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM asignaciones_tarea WHERE id = ?";
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
