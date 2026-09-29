# SkyWing

Buscador de viajes ficticio desarrollado como proyecto semestral universitario.

## Descripción

SkyWing es una aplicación web que permite comparar y simular la compra de vuelos, hoteles, transportes y alquiler de coches a distintos destinos nacionales e internacionales. Todos los datos son ficticios y el proyecto tiene fines exclusivamente académicos.

## Funcionalidades

- Buscador de vuelos con origen, destino y fecha.
- Cálculo dinámico de precios y duración según la distancia entre ciudades.
- 36 destinos (15 de Colombia y 21 internacionales).
- 10 hoteles disponibles por destino.
- 3 opciones de transporte por destino (público, taxi/Uber y alquiler de coche).
- 6 opciones de coches en alquiler por destino.
- Sistema de registro e inicio de sesión de usuarios.
- Compra simulada de paquetes de viaje (requiere inicio de sesión).
- Historial de las últimas 5 búsquedas realizadas.
- Destinos populares aleatorios al cargar la página.
- Filtro dinámico de destinos con tolerancia a errores ortográficos.
- Modal de detalle con toda la información del destino.
- Easter egg en la sección "Acerca de".

## Tecnologías utilizadas

### Frontend
- HTML5
- CSS3 (Flexbox, Grid, variables CSS, media queries)
- JavaScript (manipulación del DOM, eventos, `localStorage`, `fetch`)

### Backend
- Java 17
- Jakarta Servlet API 6.0
- Apache Tomcat 10.1

### Herramientas
- Apache Maven 3.9
- Git y GitHub
- Visual Studio Code

## Estructura del proyecto
SkyWing/
├── pom.xml
├── README.md
├── src/
│ └── main/
│ ├── java/
│ │ └── com/skywing/
│ │ ├── LoginServlet.java
│ │ └── RegistroServlet.java
│ ├── resources/
│ └── webapp/
│ ├── index.html
│ ├── styles.css
│ ├── script.js
│ ├── assets/
│ │ └── images/
│ └── WEB-INF/
│ └── web.xml


## Servlets

| Ruta | Método | Descripción |
|------|--------|-------------|
| `/login` | POST | Valida el correo y la contraseña del usuario. |
| `/registro` | POST | Registra un nuevo usuario. |

Ambos Servlets responden en formato JSON.

## Cómo ejecutar el proyecto

### Requisitos previos

- JDK 17
- Apache Maven 3.9 o superior
- Apache Tomcat 10.1

### Compilar y generar el WAR

En la raíz del proyecto:

mcn clean packagee

Se generará el archivo `target/skywing.war`.

### Desplegar en Tomcat

1. Copiar `skywing.war` a la carpeta `webapps` de Tomcat.
2. Iniciar Tomcat con `startup.bat` (Windows) o `startup.sh` (Linux/Mac).
3. Acceder a: `http://localhost:8080/skywing/`

## Autor

**Angel Petro**
Proyecto semestral - Programación III
2026

## Licencia

Proyecto académico. Todos los datos son ficticios y no representan servicios reales.