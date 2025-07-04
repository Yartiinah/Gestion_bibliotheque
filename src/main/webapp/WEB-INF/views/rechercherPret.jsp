<!-- filepath: src/main/webapp/WEB-INF/views/rechercherPret.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Rechercher un prêt par exemplaire</title>
</head>
<body>
    <jsp:include page="/WEB-INF/views/navbar.jsp" />
    <h2>Rechercher un prêt pour un exemplaire</h2>
    <form method="get" action="rechercher">
        <label>Exemplaire :</label>
        <select name="referenceExemplaire" required>
            <c:forEach var="ex" items="${exemplaires}">
                <option value="${ex.reference}">${ex.reference} - ${ex.livre.titre}</option>
            </c:forEach>
        </select>
        <button type="submit">Rechercher</button>
    </form>
    <c:if test="${not empty pret}">
        <h3>Résultat :</h3>
        <ul>
            <li>Adhérent : ${pret.adherent.nom} ${pret.adherent.prenom}</li>
            <li>Date emprunt : ${pret.dateEmprunt}</li>
            <li>Date retour prévue : ${pret.dateRetourPrevue}</li>
            <li>Statut : ${pret.statut}</li>
            <li>
                <a href="retour?id=${pret.id}">Faire un retour</a>
            </li>
        </ul>
    </c:if>
    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</body>
</html>