package com.consultora.sistema.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionDB {

    // Usar el pooler IPv4 de Supabase (Puerto 6543)
    private static final String URL = "jdbc:postgresql://aws-0-sa-east-1.pooler.supabase.com:6543/postgres?sslmode=require";
    private static final String USUARIO = "postgres.nqxpoacupkekgwznixub"; 
    private static final String PASSWORD = "-!5i%2RXVZ&#yNN";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection dameConnection() {
        try {
            return DriverManager.getConnection(URL, USUARIO, PASSWORD);
        } catch (Exception e) {
            System.err.println(">>> ERROR CONECTANDO A SUPABASE:");
            e.printStackTrace();
            return null;
        }
    }
}