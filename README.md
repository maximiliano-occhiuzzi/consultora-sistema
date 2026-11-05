# TechConsult - Sistema de Gestión de Consultora

Aplicación web monolítica para administrar empleados, proyectos, tareas y asignaciones de una consultora tecnológica.

## Tecnologías

- **Java 17**
- **Jakarta Servlet 6.0 / JSP 3.1**
- **Apache Tomcat 10.1**
- **Maven 3.9+**
- **PostgreSQL en Supabase** mediante JDBC y *Transaction Pooler*
- **HTML5 + CSS3 + JavaScript** sin frameworks de frontend

> El proyecto usa `jakarta.servlet` (Tomcat 10.1). No es compatible con Tomcat 9, que trabaja con `javax.servlet`.

## Arquitectura

```text
src/main/
├── java/com/consultora/sistema/
│   ├── config/       # Main con Tomcat embebido
│   ├── controller/   # Servlets (Login, Dashboard, Empleado, Proyecto, Tarea, Asignaciones, Chat)
│   ├── dao/          # Interfaces de acceso a datos
│   │   └── impl/     # Implementaciones JDBC
│   ├── db/           # ConexionDB y scripts SQL
│   ├── domain/       # Entidades y DTOs
│   ├── filter/       # AuthFilter
│   └── service/      # Lógica de negocio
│       └── impl/
├── resources/db/migration/  # Migraciones SQL
└── webapp/
    ├── scripts/      # JavaScript global
    ├── styles/       # Hoja de estilos única
    └── vistas/
        ├── fragmentos/  # Header y footer compartidos
        └── *.jsp
```

## Modelo de datos

| Tabla | Descripción |
| :--- | :--- |
| `usuarios` | Credenciales del administrador. |
| `empleados` | Personal técnico de la consultora. |
| `proyectos` | Proyectos con nombre, descripción y estado. |
| `tareas` | Tareas vinculadas a un proyecto mediante `id_proyecto`. |
| `asignaciones_proyecto` | Relación empleado ↔ proyecto, con índice único para evitar duplicados. |
| `asignaciones_tarea` | Relación empleado ↔ tarea, con índice único para evitar duplicados. |

La columna `tareas.id_proyecto` es la relación principal proyecto–tarea. Si se elimina un proyecto, sus tareas se eliminan en cascada.

## Endpoints principales

| Endpoint | Descripción |
| :--- | :--- |
| `/Login` | Autenticación por JSON y creación de sesión. |
| `/Logout` | Cierre de sesión. |
| `/Dashboard` | Métricas reales, avance por proyecto y estado de tareas. |
| `/Empleado` | CRUD de empleados. |
| `/Empleado?accion=disponibilidad` | Carga y disponibilidad calculadas desde las asignaciones. |
| `/Proyecto` | Listado y CRUD de proyectos. |
| `/Proyecto?accion=detalle&id=...` | Detalle, equipo, tareas y avance del proyecto. |
| `/Tarea` | CRUD de tareas y filtro por proyecto. |
| `/Asignaciones` | Asignación de empleados a proyectos y tareas. |
| `/Chat` | Vista demostrativa del chat del equipo. |
| `/Proyecto?accion=configuracion` | Información técnica del sistema. |

## Base de datos

La conexión está configurada en:

```text
src/main/java/com/consultora/sistema/db/ConexionDB.java
```

Se usa el pooler de Supabase en el puerto `6543` con `prepareThreshold=0` para evitar conflictos de *prepared statements* en modo transacción.

Para una instalación nueva, ejecutar:

```text
src/main/java/com/consultora/sistema/db/queries.sql
```

Para una base ya existente, aplicar la migración:

```text
src/main/resources/db/migration/V2__tareas_proyecto.sql
```

La migración agrega `tareas.id_proyecto`, limpia asignaciones duplicadas y crea los índices únicos.

Usuario inicial de desarrollo:

```text
Usuario: admin
Contraseña: admin123
```

## Compilar

```bash
mvn clean package
```

El WAR se genera en:

```text
target/consultora-sistema.war
```

## Ejecutar con Tomcat embebido

Desde el IDE, ejecutar `com.consultora.sistema.config.Main` con esta opción de VM:

```text
--add-opens=java.base/java.io=ALL-UNNAMED
```

También se puede ejecutar por consola:

```bash
mvn dependency:build-classpath -Dmdep.outputFile=cp.txt
java --add-opens=java.base/java.io=ALL-UNNAMED -cp "target/classes;$(cat cp.txt)" com.consultora.sistema.config.Main
```

En Windows, reemplazar `$(cat cp.txt)` por el contenido del archivo `cp.txt` o usar PowerShell:

```powershell
$cp = Get-Content cp.txt -Raw
java --add-opens=java.base/java.io=ALL-UNNAMED -cp "target\classes;$cp" com.consultora.sistema.config.Main
```

La aplicación queda disponible en `http://localhost:8080`.

## Ejecutar con Docker

La imagen usa una build multi-etapa con **JDK 17 + Maven** y se ejecuta sobre **Tomcat 10.1 + JDK 17**:

```bash
docker build -t consultora-sistema .
docker run --rm -p 8080:8080 consultora-sistema
```

El contenedor publica la aplicación como `ROOT.war`, por lo que se accede directamente en `http://localhost:8080`.

## Frontend

Todas las vistas comparten:

- `src/main/webapp/styles/estilos.css`: tema oscuro, layout, tarjetas, tablas, formularios y login.
- `src/main/webapp/scripts/script.js`: búsquedas, filtros, confirmaciones y chat.
- `src/main/webapp/WEB-INF/jspf/header.jspf` y `footer.jspf`: navegación y estructura común.

El login usa el mismo lenguaje visual que el resto del sistema y redirige al dashboard después de autenticarse.
