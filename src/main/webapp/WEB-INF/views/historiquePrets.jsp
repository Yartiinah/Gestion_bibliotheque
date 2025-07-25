<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<html>
<head>
    <title>Historique des prêts</title>
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
<h2>Historique des prêts</h2>
<table>
    <tr>
        <th>ID</th>
        <th>ID Prêt</th>
        <th>Action</th>
        <th>Date action</th>
        <th>Commentaire</th>
    </tr>
    <c:forEach var="hist" items="${historiques}">
        <tr>
            <td>${hist.id}</td>
            <td>${hist.pret.id}</td>
            <td>${hist.action}</td>
            <td>${hist.dateAction}</td>
            <td>${hist.commentaire}</td>
        </tr>
    </c:forEach>
</table>
<c:if test="${empty historiques}">
    <p>Aucun historique trouvé.</p>
</c:if>
</div>
</body>
</html>
