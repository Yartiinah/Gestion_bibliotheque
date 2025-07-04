<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Ajouter un adhérent</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/navbar.jsp" />
<h2>Ajouter un nouvel adhérent</h2>
<form:form method="post" modelAttribute="adherent">
    <label>Nom : <form:input path="nom" required="true"/></label><br>
    <label>Prénom : <form:input path="prenom" required="true"/></label><br>
    <label>Email : <form:input path="email" type="email" required="true"/></label><br>
    <label>Type d'abonnement :
        <form:select path="typeAbonnement.id">
            <form:options items="${typesAbonnement}" itemValue="id" itemLabel="libelle"/>
        </form:select>
    </label><br>
    <label>Adresse : <form:input path="adresse" required="true"/></label><br>
    <label>Date d'inscription : <input type="date" name="dateInscription" required="true"/></label><br>
    <label>Date d'expiration : <input type="date" name="dateExpiration" required="true"/></label><br>
    <button type="submit">Ajouter</button>
</form:form>
<c:if test="${not empty message}">
    <p style="color:blue;">${message}</p>
</c:if>
</body>
</html>
