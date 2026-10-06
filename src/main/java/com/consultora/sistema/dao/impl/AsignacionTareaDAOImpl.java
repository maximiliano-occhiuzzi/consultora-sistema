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
        String sql = "SELECT * FROM asignaciones_tarea";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new AsignacionTarea(
                    rs.getInt("id"),
                    rs.getInt("id_empleado"),
                    rs.getInt("id_tarea")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
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