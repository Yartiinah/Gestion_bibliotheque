<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<html>
<head>
    <title>Accueil Adhérent</title>
</head>
<body>
    <h2>Bienvenue sur votre espace adhérent !</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/prets/mes-prets">Mes prêts</a></li>
        <li><a href="${pageContext.request.contextPath}/livres">Liste des livres</a></li>
        <li><a href="${pageContext.request.contextPath}/mon-compte">Mon compte</a></li>
    </ul>
</body>
</html>
