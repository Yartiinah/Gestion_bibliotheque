<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Créer un utilisateur</title>
    <style>
        .page-container { max-width: 500px; margin: 40px auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 2px 8px #ccc; }
        h2 { color: #2c3e50; text-align: center; }
        form { display: flex; flex-direction: column; gap: 15px; }
        label { font-weight: bold; color: #34495e; }
        input, select { padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        button { background: #27ae60; color: #fff; border: none; padding: 10px 20px; border-radius: 4px; font-size: 16px; cursor: pointer; transition: background 0.2s; }
        button:hover { background: #219150; }
    </style>
</head>
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/navbar.jsp" />

<div class="page-container">
    <h2>Créer un utilisateur</h2>
    <form method="post" action="${pageContext.request.contextPath}/utilisateur/creer">
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
        </select>
        <label for="username">Nom d'utilisateur :</label>
        <input type="text" id="username" name="username" required>
        <label for="password">Mot de passe :</label>
        <input type="password" id="password" name="password" required>
        <label for="role">Rôle :</label>
        <select id="role" name="role" required>
            <option value="ADHERENT">Adhérent</option>
            <option value="BIBLIOTHECAIRE">Bibliothécaire</option>
        </select>
        <button type="submit">Créer</button>
    </form>
    <c:if test="${not empty message}">
        <p style="color:green;">${message}</p>
    </c:if>
</div>
</body>
</html>
