<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Enregistrer un prêt</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<h2>Enregistrer un prêt</h2>
<form method="post" action="nouveau">
    <label>Adhérent :
        <select name="adherentId" required>
            <c:forEach var="adherent" items="${adherents}">
                <option value="${adherent.id}">${adherent.nom} ${adherent.prenom} (${adherent.email})</option>
            </c:forEach>
        </select>
    </label><br>
    <label>Exemplaire :
        <select name="referenceExemplaire" required>
            <c:forEach var="ex" items="${exemplaires}">
                <option value="${ex.reference}">${ex.reference} (${ex.livre.titre})</option>
            </c:forEach>
        </select>
    </label><br>
    <label>Type de prêt :
        <select name="typePret" required>
            <option value="emporte">Emporté</option>
            <option value="sur_place">Sur place</option>
        </select>
    </label><br>
    <button type="submit">Enregistrer</button>
</form>
<c:if test="${not empty message}">
    <p style="color:blue;">${message}</p>
</c:if>
</body>
</html>