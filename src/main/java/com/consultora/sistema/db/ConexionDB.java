package com.consultora.sistema.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

public class ConexionDB {

	private static final Logger log = Logger.getLogger(ConexionDB.class.getName());

	private static final String DRIVER = "org.postgresql.Driver";
	
	// DATOS OFICIALES DE TU CONEXIÓN SUPABASE
	private static final String HOST = "://supabase.com"; 
	private static final String PUERTO = "6543"; // Puerto del pooler de transacciones
	private static final String DBNAME = "postgres?pgbouncer=true"; // Parámetro óptimo para el pooler
	
	// URL JDBC definitiva para PostgreSQL
	private static final String URL = "jdbc:postgresql://" + HOST + ":" + PUERTO + "/" + DBNAME;

	// CREDENCIALES DE ACCESO ACTUALIZADAS
	private static final String USUARIO = "postgres.ortprlwuunusdyxsrnsp"; 
	private static final String PASSWORD = "fT3i*ec$??z8V6#"; // Colocá la clave de tu base de datos

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
