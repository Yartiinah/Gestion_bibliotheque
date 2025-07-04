<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<html>
<head>
    <title>Mes prêts</title>
</head>
<body>
<h2>Mes prêts</h2>
<table border="1" cellpadding="5" cellspacing="0">
<tr>
    <th>Livre</th>
    <th>Exemplaire</th>
    <th>Date d'emprunt</th>
    <th>Date retour prévue</th>
    <th>Date retour effective</th>
    <th>Statut</th>
    <th>Actions</th>
</tr>
<c:forEach var="pret" items="${prets}">
    <tr>
        <td>${pret.exemplaire.livre.titre}</td>
        <td>${pret.exemplaire.reference}</td>
        <td>${pret.dateEmprunt}</td>
        <td>${pret.dateRetourPrevue}</td>
        <td>${pret.dateRetourEffective != null ? pret.dateRetourEffective : '-'}</td>
        <td>${pret.statut}</td>
        <td>
            <c:if test="${pret.statut == 'en_cours'}">
                <a href="${pageContext.request.contextPath}/prets/prolonger?id=${pret.id}">Prolonger</a>
            </c:if>
        </td>
    </tr>
</c:forEach>
</table>
<c:if test="${empty prets}">
    <p>Aucun prêt en cours ou passé.</p>
</c:if>
</body>
</html>
