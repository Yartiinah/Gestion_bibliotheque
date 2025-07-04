<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<html>
<head>
    <title>Mes prêts</title>
    <style>
        .page-container { max-width: 900px; margin: 30px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 8px #ccc; }
        h2 { color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background: #34495e; color: #fff; }
        tr:nth-child(even) { background: #f2f2f2; }
        tr:hover { background: #eaf6fb; }
        button, a { background: #2980b9; color: #fff; border: none; padding: 7px 15px; border-radius: 4px; text-decoration: none; transition: background 0.2s; }
        button:hover, a:hover { background: #1c5d8c; }
    </style>
</head>
<body>
<div class="page-container">
<h2>Mes prêts</h2>
<table>
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
</div>
</body>
</html>
