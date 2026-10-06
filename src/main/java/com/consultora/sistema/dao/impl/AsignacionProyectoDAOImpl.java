package com.consultora.sistema.dao.impl;

import com.consultora.sistema.dao.AsignacionProyectoDAO;
import com.consultora.sistema.db.ConexionDB;
import com.consultora.sistema.domain.AsignacionProyecto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsignacionProyectoDAOImpl implements AsignacionProyectoDAO {

    @Override
    public List<AsignacionProyecto> listar() {
        List<AsignacionProyecto> lista = new ArrayList<>();
        String sql = "SELECT ap.id, ap.id_empleado, ap.id_proyecto, " +
                     "CONCAT(e.nombre, ' ', e.apellido) AS empleado_nombre, " +
                     "p.nombre AS proyecto_nombre " +
                     "FROM asignaciones_proyecto ap " +
                     "JOIN empleados e ON ap.id_empleado = e.id " +
                     "JOIN proyectos p ON ap.id_proyecto = p.id";

        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(new AsignacionProyecto(
                    rs.getInt("id"),
                    rs.getInt("id_empleado"),
                    rs.getInt("id_proyecto"),
                    rs.getString("empleado_nombre"),
                    rs.getString("proyecto_nombre")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public boolean insertar(AsignacionProyecto ap) {
        String sql = "INSERT INTO asignaciones_proyecto (id_empleado, id_proyecto) VALUES (?, ?)";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, ap.getIdEmpleado());
            ps.setInt(2, ap.getIdProyecto());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM asignaciones_proyecto WHERE id = ?";
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