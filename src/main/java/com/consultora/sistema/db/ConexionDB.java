package com.consultora.sistema.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

public class ConexionDB {

    private static final Logger log = Logger.getLogger(ConexionDB.class.getName());

    private static final String DRIVER = "org.postgresql.Driver";
    
    // Configuración de conexión para Supabase
    private static final String HOST = "aws-0-sa-east-1.pooler.supabase.com"; 
    private static final String PUERTO = "6543"; 
    private static final String DBNAME = "postgres?pgbouncer=true";
    
    // Cadena de conexión JDBC
    private static final String URL = "jdbc:postgresql://" + HOST + ":" + PUERTO + "/" + DBNAME;

    // Credenciales de acceso
    private static final String USUARIO = "postgres.nqxpoacupkekgwznixub"; 
    private static final String PASSWORD = "6tcsistema26nuevo"; 

    private static ConexionDB instance; 
    private static Connection conn;

    private ConexionDB() {
    }

    public static Connection dameConnection() {
        try {
            Class.forName(DRIVER);
            if (conn == null || conn.isClosed()) {
                conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
                log.info("Conexión exitosa a Supabase mediante Transaction Pooler.");
            }
            return conn;
        } catch (ClassNotFoundException e) {
            log.severe("Error de acceso al driver de PostgreSQL: " + e.getMessage());
        } catch (SQLException e) {
            log.severe("Error de SQL al conectar a Supabase: " + e.getMessage());
        }
        return null;
    }

    public static ConexionDB getInstance() {
        if (instance == null) {
            instance = new ConexionDB();
        }
        return instance;
    }
}