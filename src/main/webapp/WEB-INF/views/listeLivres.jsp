<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des livres</title>
</head>
<body>
    <jsp:include page="/WEB-INF/views/navbar.jsp" />
    <h1>Liste des livres</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Titre</th>
                <th>Auteur</th>
                <th>Catégorie</th>
                <th>ISBN</th>
                <th>Restriction</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% 
            java.util.List livres = (java.util.List) request.getAttribute("livres");
            if (livres != null) {
                for (Object obj : livres) {
                    model.Livre livre = (model.Livre) obj;
        %>
                <tr>
                    <td><%= livre.getTitre() %></td>
                    <td><%= livre.getAuteur() %></td>
                    <td><%= livre.getCategorie() != null ? livre.getCategorie().getNom() : "" %></td>
                    <td><%= livre.getIsbn() %></td>
                    <td><%= livre.getRestriction() %></td>
                    <td>
                        <form action="/livres/reserver" method="post" style="margin:0;">
                            <input type="hidden" name="livreId" value="<%= livre.getId() %>" />
                            <button type="submit">Réserver</button>
                        </form>
                    </td>
                </tr>
        <%      }
            }
        %>
        </tbody>
    </table>
</body>
</html>