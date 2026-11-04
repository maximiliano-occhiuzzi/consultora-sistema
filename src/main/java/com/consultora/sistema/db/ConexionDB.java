package com.consultora.sistema.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionDB {

    // Usar el pooler IPv4 de Supabase (Puerto 6543 con pgbouncer=true)
    private static final String URL = "jdbc:postgresql://aws-0-sa-east-1.pooler.supabase.com:6543/postgres?pgbouncer=true&sslmode=require";
    private static final String USUARIO = "postgres.nqxpoacupkekgwznixub"; 
    private static final String PASSWORD = "6tcsistema26nuevo";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println(">>> ERROR: No se encontro el driver de PostgreSQL.");
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