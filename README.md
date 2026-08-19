# 🚀 Modulex - Sistema de Asignación de Personal Técnico

[![Java Version](https://shields.io)](https://oracle.com)
[![PostgreSQL](https://shields.io)](https://postgresql.org)
[![Supabase](https://shields.io)](https://supabase.com)

**Modulex** es una solución informática monolítica modular diseñada para una consultora tecnológica internacional. Su propósito principal es optimizar y administrar eficientemente la asignación de personal técnico a múltiples proyectos concurrentes del sector público y privado, controlando cargas horarias, competencias específicas y plazos de entrega.

---

## 📑 Índice
* [🛠️ Tecnologías y Herramientas](#%EF%B8%8F-tecnolog%C3%ADas-y-herramientas)
* [🏛️ Arquitectura del Proyecto](#%EF%B8%8F-arquitectura-del-proyecto)
* [🗂️ Modelo de Datos (DER)](#%EF%B8%8F-modelo-de-datos-der)
* [🎛️ Controladores y Endpoints](#%EF%B8%8F-controladores-y-endpoints)
* [🚀 Configuración e Instalación](#-configuraci%C3%B3n-e-instalaci%C3%B3n)

---

## 🛠️ Tecnologías y Herramientas

*   **Lenguaje:** Java 17+ (Servlets & JSPs)
*   **Base de Datos:** PostgreSQL en la nube mediante **Supabase**
*   **Persistencia:** JDBC nativo con Driver oficial de PostgreSQL
*   **Optimización:** Connection Pooling a través del *Transaction Pooler* integrado (Puerto `6543`)
*   **Control de Versiones:** Git & GitHub CLI (`gh`)

---

## 🏛️ Arquitectura del Proyecto

El sistema adopta el patrón de arquitectura clásica **MVC (Model-View-Controller)** con desacoplamiento mediante capas de Servicio y DAO:

```text
src/main/
├── java/
│   └── com.consultora.sistema
│       ├── controller/      # Servlets que manejan la interfaz web (?action=)
│       ├── domain/          # Entidades o modelos de datos (POJOs)
│       ├── service/         # Capa con la lógica de negocio y validaciones
│       ├── dao/             # Interfaces de acceso a datos
│       │   └── impl/        # Implementaciones JDBC nativas
│       └── db/              # Singleton de conexión ConexionDB.java
└── webapp/
    ├── assets/              # Archivos estáticos (CSS, JS, Imágenes)
    └── WEB-INF/
        └── views/           # Vistas JSP protegidas (Estructura -list y -form)
```

---

## 🗂️ Modelo de Datos (DER)

El diseño relacional se compone de 5 tablas principales optimizadas para romper la relación de muchos a muchos existente entre Empleados y Proyectos:

*   **`empleados` (`int4`):** Almacena el perfil técnico, conocimientos y disponibilidad máxima de horas semanales.
*   **`proyectos` (`int4`):** Registra el nombre, cliente, segmentación (`Público` / `Privado`) y plazos de ejecución.
*   **`tareas` (`int4`):** Catálogo maestro de actividades operativas (Backend, Frontend, DevOps, etc.).
*   **`asignacion_proyectos` (`int4`):** Tabla intermedia que vincula técnicos con proyectos, asignando una carga horaria específica.
*   **`asignacion_tareas` (`int4`):** Detalle de grano fino que conecta la asignación de un empleado con tareas del catálogo y fechas límite de cumplimiento.

---

## 🎛️ Controladores y Endpoints

Cada módulo operativo se centraliza en un único Servlet dinámico reduciendo drásticamente la duplicación de código en la aplicación:

| Controlador | Endpoint Base | Responsabilidad Operativa |
| :--- | :--- | :--- |
| `LoginServlet` | `/login` | Validación de credenciales y establecimiento de `HttpSession` |
| `LogoutServlet` | `/logout` | Invalidación de sesión y limpieza de cookies |
| `DashboardServlet` | `/dashboard` | Carga de métricas, alertas de sobreasignación y tareas críticas |
| `EmpleadoServlet` | `/empleados` | CRUD unificado del personal técnico interno |
| `ProyectoServlet` | `/proyectos` | CRUD unificado de proyectos públicos y privados |
| `TareaServlet` | `/tareas` | Administración del catálogo global de especialidades |
| `AsignacionServlet` | `/asignaciones` | Coordinación de equipos, cruce de horas y plazos |

---

## 🚀 Configuración e Instalación

### 1. Clonar el repositorio
```bash
git clone https://github.com
cd consultora-sistema
```

### 2. Configurar las variables de entorno / Conexión
Modificá el archivo `src/main/java/com/consultora/sistema/db/ConexionDB.java` con las credenciales de tu instancia de Supabase obtenidas del panel de administración:

```java
private static final String HOST = "://supabase.com"; 
private static final String PUERTO = "6543"; // Transaction Pooler
private static final String DBNAME = "postgres?pgbouncer=true";
private static final String USUARIO = "postgres.ortprlwuunusdyxsrnsp";
private static final String PASSWORD = "TU_CONTRASEÑA_MAESTRA";
```

### 3. Compilar y Desplegar
Si utilizás Maven para la construcción del artefacto:
```bash
mvn clean package
```
Desplegá el archivo `.war` resultante en tu contenedor de Servlets preferido (Apache Tomcat 9/10, Jetty o WildFly).
