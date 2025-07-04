<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<html>
<head>
    <title>Mes Réservations</title>
    <style>
        .page-container { max-width: 900px; margin: 30px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 8px #ccc; }
        h2 { color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background: #34495e; color: #fff; }
        tr:nth-child(even) { background: #f2f2f2; }
        tr:hover { background: #eaf6fb; }
    </style>
</head>
<body>
<div class="page-container">
<h2>Mes réservations</h2>
<table>
<tr>
    <th>Livre</th>
    <th>Exemplaire</th>
    <th>Date de demande</th>
    <th>Statut</th>
</tr>
<c:forEach var="reservation" items="${reservations}">
    <tr>
        <td>${reservation.exemplaire.livre.titre}</td>
        <td>${reservation.exemplaire.reference}</td>
        <td>${reservation.dateDemande}</td>
        <td>${reservation.statut}</td>
    </tr>
</c:forEach>
</table>
<c:if test="${empty reservations}">
    <p>Aucune réservation en cours ou passée.</p>
</c:if>
</div>
</body>
</html>