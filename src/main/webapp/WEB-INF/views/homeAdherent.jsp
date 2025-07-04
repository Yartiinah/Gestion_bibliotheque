<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<html>
<head>
    <title>Accueil Adhérent</title>
    <style>
        .page-container { max-width: 700px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 8px #ccc; }
        h2 { color: #2c3e50; text-align: center; }
        p { font-size: 18px; color: #34495e; text-align: center; }
    </style>
</head>
<body>
    <div class="page-container">
        <h2>Bienvenue sur votre espace adhérent</h2>
        <p>Accédez à vos prêts, réservations et informations personnelles depuis le menu.</p>
        <ul>
            <li><a href="${pageContext.request.contextPath}/prets/mes-prets">Mes prêts</a></li>
            <li><a href="${pageContext.request.contextPath}/livres/liste">Liste des livres</a></li>
            <li><a href="${pageContext.request.contextPath}/mon-compte">Mon compte</a></li>
        </ul>
    </div>
</body>
</html>
