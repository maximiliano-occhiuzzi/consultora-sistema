package com.consultora.sistema.dao.impl;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.consultora.sistema.dao.EmpleadoDAO;
import com.consultora.sistema.db.ConexionDB;
import com.consultora.sistema.domain.Empleado;

public class EmpleadoDAOImpl implements EmpleadoDAO {

    @Override
    public List<Empleado> listar() {
        List<Empleado> lista = new ArrayList<>();
        String sql = "SELECT * FROM empleados";

        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Empleado e = new Empleado();
                e.setId(rs.getInt("id"));
                e.setNombre(rs.getString("nombre"));
                e.setApellido(rs.getString("apellido"));
                e.setEmail(rs.getString("email"));
                e.setPuesto(rs.getString("puesto"));
                lista.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Empleado obtenerPorId(int id) {
        Empleado emp = null;
        String sql = "SELECT * FROM empleados WHERE id = ?";

        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    emp = new Empleado();
                    emp.setId(rs.getInt("id"));
                    emp.setNombre(rs.getString("nombre"));
                    emp.setApellido(rs.getString("apellido"));
                    emp.setEmail(rs.getString("email"));
                    emp.setPuesto(rs.getString("puesto"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emp;
    }

    @Override
    public boolean insertar(Empleado empleado) {
        String sql = "INSERT INTO empleados (nombre, apellido, email, puesto) VALUES (?, ?, ?, ?)";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, empleado.getNombre());
            ps.setString(2, empleado.getApellido());
            ps.setString(3, empleado.getEmail());
            ps.setString(4, empleado.getPuesto());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean actualizar(Empleado empleado) {
        String sql = "UPDATE empleados SET nombre = ?, apellido = ?, email = ?, puesto = ? WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, empleado.getNombre());
            ps.setString(2, empleado.getApellido());
            ps.setString(3, empleado.getEmail());
            ps.setString(4, empleado.getPuesto());
            ps.setInt(5, empleado.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM empleados WHERE id = ?";
        try (Connection cn = ConexionDB.dameConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}