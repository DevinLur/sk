<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    // ============================================================
    // DECLARACIONES: mapas que se cargan una sola vez
    // ============================================================
    java.util.Map<String, Integer> distancias = new java.util.HashMap<String, Integer>();
    java.util.Map<String, String> paises = new java.util.HashMap<String, String>();
    java.util.Map<String, String> usuarios = new java.util.HashMap<String, String>();

    public void cargarDatos() {
        if (!distancias.isEmpty()) return;

        distancias.put("Bogotá", 0);
        distancias.put("Medellín", 240);
        distancias.put("Cali", 320);
        distancias.put("Cartagena", 1050);
        distancias.put("Santa Marta", 1180);
        distancias.put("Barranquilla", 1000);
        distancias.put("Bucaramanga", 390);
        distancias.put("Pereira", 350);
        distancias.put("Manizales", 300);
        distancias.put("Cúcuta", 570);
        distancias.put("Ibagué", 200);
        distancias.put("Villavicencio", 120);
        distancias.put("Pasto", 800);
        distancias.put("San Andrés", 1200);
        distancias.put("Leticia", 1100);
        distancias.put("Miami", 2850);
        distancias.put("Nueva York", 3950);
        distancias.put("Toronto", 4300);
        distancias.put("Ciudad de México", 3150);
        distancias.put("Cancún", 2600);
        distancias.put("Buenos Aires", 4700);
        distancias.put("Lima", 1900);
        distancias.put("Santiago", 4650);
        distancias.put("Río de Janeiro", 5300);
        distancias.put("Madrid", 8100);
        distancias.put("Barcelona", 8300);
        distancias.put("París", 8600);
        distancias.put("Londres", 8800);
        distancias.put("Roma", 9200);
        distancias.put("Berlín", 9100);
        distancias.put("Ámsterdam", 8900);
        distancias.put("Lisboa", 7800);
        distancias.put("Dubái", 13500);
        distancias.put("Tokio", 14600);
        distancias.put("Sídney", 15200);
        distancias.put("Punta Cana", 1900);

        paises.put("Bogotá", "Colombia");
        paises.put("Medellín", "Colombia");
        paises.put("Cali", "Colombia");
        paises.put("Cartagena", "Colombia");
        paises.put("Santa Marta", "Colombia");
        paises.put("Barranquilla", "Colombia");
        paises.put("Bucaramanga", "Colombia");
        paises.put("Pereira", "Colombia");
        paises.put("Manizales", "Colombia");
        paises.put("Cúcuta", "Colombia");
        paises.put("Ibagué", "Colombia");
        paises.put("Villavicencio", "Colombia");
        paises.put("Pasto", "Colombia");
        paises.put("San Andrés", "Colombia");
        paises.put("Leticia", "Colombia");
        paises.put("Miami", "Estados Unidos");
        paises.put("Nueva York", "Estados Unidos");
        paises.put("Toronto", "Canadá");
        paises.put("Ciudad de México", "México");
        paises.put("Cancún", "México");
        paises.put("Buenos Aires", "Argentina");
        paises.put("Lima", "Perú");
        paises.put("Santiago", "Chile");
        paises.put("Río de Janeiro", "Brasil");
        paises.put("Madrid", "España");
        paises.put("Barcelona", "España");
        paises.put("París", "Francia");
        paises.put("Londres", "Reino Unido");
        paises.put("Roma", "Italia");
        paises.put("Berlín", "Alemania");
        paises.put("Ámsterdam", "Países Bajos");
        paises.put("Lisboa", "Portugal");
        paises.put("Dubái", "Emiratos Árabes");
        paises.put("Tokio", "Japón");
        paises.put("Sídney", "Australia");
        paises.put("Punta Cana", "República Dominicana");

        usuarios.put("admin@skywing.com", "1234");
        usuarios.put("angel@universidad.edu.co", "5678");
    }
%>

<%
    // ============================================================
    // PROCESAMIENTO: se ejecuta en cada petición
    // ============================================================
    cargarDatos();

    String accion = request.getParameter("accion");
    String origen = request.getParameter("origen");
    String destino = request.getParameter("destino");
    String fecha = request.getParameter("fecha");
    String emailLogin = request.getParameter("email");
    String passwordLogin = request.getParameter("password");

    String mensaje = "";
    String tipoMensaje = "error";
    int precio = 0;
    String duracion = "";
    boolean mostrarResultado = false;

    String usuarioActual = (String) session.getAttribute("usuario");

    // ---------- BUSCAR VUELO ----------
    if ("buscar".equals(accion)) {
        if (origen == null || origen.trim().isEmpty()
                || destino == null || destino.trim().isEmpty()
                || fecha == null || fecha.trim().isEmpty()) {
            mensaje = "Debes completar todos los campos (origen, destino y fecha).";
        } else if (origen.equals(destino)) {
            mensaje = "El origen y el destino no pueden ser iguales.";
        } else {
            int km = distancias.get(origen) + distancias.get(destino);
            boolean nacional = paises.get(origen).equals("Colombia")
                            && paises.get(destino).equals("Colombia");

            if (nacional) {
                precio = 200000 + (km * 200);
            } else {
                precio = 400000 + (km * 280);
            }

            int horas = km / 850;
            int minutos = (int) ((km % 850) * 60.0 / 850);
            if (horas < 1) horas = 1;
            duracion = horas + "h " + minutos + "min";

            mostrarResultado = true;
        }
    }

    // ---------- LOGIN ----------
    if ("login".equals(accion) && emailLogin != null && passwordLogin != null) {
        if (usuarios.containsKey(emailLogin) && usuarios.get(emailLogin).equals(passwordLogin)) {
            session.setAttribute("usuario", emailLogin);
            usuarioActual = emailLogin;
            mensaje = "Bienvenido, " + emailLogin;
            tipoMensaje = "exito";
        } else {
            mensaje = "Correo o contrasena incorrectos.";
        }
    }

    // ---------- CERRAR SESION ----------
    if ("cerrar".equals(accion)) {
        session.invalidate();
        usuarioActual = null;
        mensaje = "Sesion cerrada correctamente.";
        tipoMensaje = "exito";
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyWing - Buscador de Viajes</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <!-- ============================================================
         BARRA DE NAVEGACION (dinamica segun sesion)
         ============================================================ -->
    <header>
        <nav class="navbar">
            <div class="logo">Sky<span>Wing</span></div>
            <ul class="nav-links">
                <li><a href="index.jsp" class="active">Vuelos</a></li>
                <li><a href="#login">Hoteles</a></li>
                <li><a href="#login">Coches</a></li>
                <% if (usuarioActual != null) { %>
                    <li><a href="index.jsp?accion=cerrar"><%= usuarioActual %> - Cerrar Sesion</a></li>
                <% } else { %>
                    <li><a href="#login">Iniciar Sesion</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <!-- ============================================================
         MENSAJES (solo si hay algo que mostrar)
         ============================================================ -->
    <% if (!mensaje.equals("")) { %>
        <div class="mensaje-sistema <%= tipoMensaje.equals("exito") ? "mensaje-exito" : "mensaje-error" %>">
            <%= mensaje %>
        </div>
    <% } %>

    <!-- ============================================================
         RESULTADO DE LA BUSQUEDA (solo si se realizo)
         ============================================================ -->
    <% if (mostrarResultado) { %>
        <div class="resultado-busqueda">
            <h2>Vuelo encontrado</h2>
            <p><strong>Origen:</strong> <%= origen %></p>
            <p><strong>Destino:</strong> <%= destino %></p>
            <p><strong>Fecha:</strong> <%= fecha %></p>
            <p><strong>Duracion:</strong> <%= duracion %></p>
            <p><strong>Precio:</strong> $<%= String.format("%,d", precio) %> COP</p>
            <a href="index.jsp" class="btn-card">Nueva busqueda</a>
        </div>
    <% } %>

    <!-- ============================================================
         FORMULARIO DE BUSQUEDA
         ============================================================ -->
    <section class="hero">
        <h1>Encuentra tu proximo destino</h1>
        <p>Compara precios en cientos de aerolineas al instante.</p>

        <form class="search-box" method="post" action="index.jsp">
            <input type="hidden" name="accion" value="buscar">

            <div class="field">
                <label for="origin">Origen</label>
                <select id="origin" name="origen" required>
                    <option value="">-- Selecciona --</option>
                    <%
                        for (String ciudad : distancias.keySet()) {
                    %>
                        <option value="<%= ciudad %>"><%= ciudad %></option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="field-divider"></div>

            <div class="field">
                <label for="dest">Destino</label>
                <select id="dest" name="destino" required>
                    <option value="">-- Selecciona --</option>
                    <%
                        for (String ciudad : distancias.keySet()) {
                    %>
                        <option value="<%= ciudad %>"><%= ciudad %></option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="field-divider"></div>

            <div class="field">
                <label for="date">Fecha</label>
                <input type="date" id="date" name="fecha" required>
            </div>

            <button type="submit" class="search-btn">Buscar</button>
        </form>
    </section>

    <!-- ============================================================
         TARJETAS DE DESTINOS (generadas con bucle)
         ============================================================ -->
    <section class="destinations">
        <div class="destinations-header">
            <h2>Destinos <span>disponibles</span></h2>
        </div>

        <div class="card-grid">
            <%
                for (String ciudad : distancias.keySet()) {
                    String pais = paises.get(ciudad);
                    String idImg = ciudad.toLowerCase()
                        .replace("á","a").replace("é","e").replace("í","i")
                        .replace("ó","o").replace("ú","u").replace("ñ","n")
                        .replace(" ","");
                    int precioDesde = 200000 + (distancias.get(ciudad) * 200);
            %>
                <div class="card">
                    <div class="card-img">
                        <img src="assets/images/<%= idImg %>1.jpg" alt="<%= ciudad %>" onerror="this.style.display='none'">
                        <span class="city-label"><%= ciudad %></span>
                    </div>
                    <div class="card-content">
                        <h3><%= ciudad %></h3>
                        <p class="country"><%= pais %></p>
                        <div class="price">$ <%= String.format("%,d", precioDesde) %> <small>desde Bogota</small></div>
                        <a href="index.jsp?accion=buscar&origen=Bogotá&destino=<%= ciudad %>&fecha=2026-12-01" class="btn-card">Ver oferta</a>
                    </div>
                </div>
            <%
                }
            %>
        </div>
    </section>

    <!-- ============================================================
         LOGIN (con o sin sesion activa)
         ============================================================ -->
    <section class="login-section" id="login">
        <div class="login-container">
            <% if (usuarioActual == null) { %>
                <h2>Iniciar sesion</h2>
                <form action="index.jsp" method="post">
                    <input type="hidden" name="accion" value="login">
                    <div class="login-field">
                        <label>Correo electronico</label>
                        <input type="email" name="email" required>
                    </div>
                    <div class="login-field">
                        <label>Contrasena</label>
                        <input type="password" name="password" required>
                    </div>
                    <button type="submit" class="login-btn">Ingresar</button>
                </form>
            <% } else { %>
                <h2>Sesion activa</h2>
                <p>Has iniciado sesion como <strong><%= usuarioActual %></strong>.</p>
                <a href="index.jsp?accion=cerrar" class="btn-card">Cerrar sesion</a>
            <% } %>
        </div>
    </section>

    <!-- ============================================================
         PIE DE PAGINA
         ============================================================ -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-col">
                <h4>SkyWing</h4>
                <p>Comparador de viajes ficticio para proyecto universitario.</p>
            </div>
            <div class="footer-col">
                <h4>Empresa</h4>
                <ul>
                    <li><a href="#">Acerca de</a></li>
                    <li><a href="#">Prensa</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>Soporte</h4>
                <ul>
                    <li><a href="#">Centro de ayuda</a></li>
                    <li><a href="#">Contacto</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2026 <strong>SkyWing</strong> — Proyecto academico.
        </div>
    </footer>

</body>
</html>