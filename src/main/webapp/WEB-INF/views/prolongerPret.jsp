<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<html>
<head>
    <title>Prolonger un prêt</title>
</head>
<body>
    <h2>Prolonger un prêt</h2>
    <form method="post" action="${pageContext.request.contextPath}/prets/prolonger">
        <label for="pretId">Choisir un prêt à prolonger :</label>
        <select id="pretId" name="pretId" required>
            <%-- Affiche uniquement les prêts en cours de l'adhérent --%>
            <c:forEach var="pret" items="${prets}">
                <option value="${pret.id}">
                    Livre : ${pret.exemplaire.livre.titre} | Exemplaire : ${pret.exemplaire.reference} | Retour prévu : ${pret.dateRetourPrevue}
                </option>
            </c:forEach>
        </select>
        <button type="submit">Prolonger</button>
    </form>
    <c:if test="${not empty message}">
        <p style="color:blue;">${message}</p>
    </c:if>
</body>
</html>
