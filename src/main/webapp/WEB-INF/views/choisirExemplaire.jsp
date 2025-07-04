<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<html>
<head>
    <title>Choisir un exemplaire à réserver</title>
    <style>
    .error-message { color: #c0392b; font-weight: bold; margin-bottom: 15px; }
    </style>
</head>
<body>
<h2>Choisir un exemplaire à réserver</h2>
<c:if test="${not empty erreur}">
    <div class="error-message">${erreur}</div>
</c:if>
<form method="post" action="${pageContext.request.contextPath}/reservation/demander">
    <input type="hidden" name="livreId" value="${livre.id}" />
    <label>Exemplaire :
        <select name="exemplaireId" required>
            <c:forEach var="ex" items="${exemplaires}">
                <option value="${ex.id}">${ex.reference} (${ex.statut})</option>
            </c:forEach>
        </select>
    </label>
    <br>
    <label>Date de demande :
        <input type="date" name="dateDemande" required>
    </label>
    <br>
    <button type="submit">Réserver</button>
</form>
</body>
</html>