<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Créer un utilisateur</title>
</head>
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />

<h2>Créer un utilisateur</h2>
<form method="post" action="creer">
    <label for="adherentId">Adhérent :</label>
    <select id="adherentId" name="adherentId" required>
    <% 
        java.util.List adherents = (java.util.List) request.getAttribute("adherents");
        if (adherents != null) {
            for (Object obj : adherents) {
                model.Adherent adherent = (model.Adherent) obj;
    %>
        <option value="<%= adherent.getId() %>"><%= adherent.getNom() %> <%= adherent.getPrenom() %></option>
    <%      }
        }
    %>
    </select><br>
    <label for="username">Nom d'utilisateur :</label>
    <input type="text" id="username" name="username" required><br>
    <label for="password">Mot de passe :</label>
    <input type="password" id="password" name="password" required><br>
    <label for="role">Rôle :</label>
    <select id="role" name="role" required>
        <option value="ADHERENT">Adhérent</option>
        <option value="BIBLIOTHECAIRE">Bibliothécaire</option>
    </select><br>
    <button type="submit">Créer</button>
</form>
<c:if test="${not empty message}">
    <p style="color:green;">${message}</p>
</c:if>
</body>
</html>
