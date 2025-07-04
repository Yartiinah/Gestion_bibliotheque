<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Navbar dynamique selon le rôle utilisateur --%>
<nav style="background:#f0f0f0;padding:10px;">
    <c:choose>
        <c:when test="${sessionScope.user.role eq 'BIBLIOTHECAIRE'}">
            <a href="${pageContext.request.contextPath}/livres/liste">liste Livres</a> |
            <a href="${pageContext.request.contextPath}/adherents">Adhérents</a> |
            <a href="${pageContext.request.contextPath}/adherents/ajouter">ajouter Adhérents</a> |

            <a href="${pageContext.request.contextPath}/prets/liste">liste pret</a> |
            <a href="${pageContext.request.contextPath}/prets/nouveau">ajout pret</a> |
            <a href="${pageContext.request.contextPath}/utilisateur/creer">ajout utilisateur</a> |

            <a href="${pageContext.request.contextPath}/prets/rechercher">rechercher pret</a> |
            <a href="${pageContext.request.contextPath}/paiements">Paiements</a> |
            <a href="${pageContext.request.contextPath}/login/logout">Déconnexion</a>
        </c:when>
        <c:when test="${sessionScope.user.role eq 'ADHERENT'}">
            <a href="${pageContext.request.contextPath}/livres/liste">Livres</a> |
            <a href="${pageContext.request.contextPath}/prets/mes-prets">Mes prêts</a> |
            <a href="${pageContext.request.contextPath}/mon-compte">Mon compte</a> |
            <a href="${pageContext.request.contextPath}/login/logout">Déconnexion</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/login">Connexion</a>
        </c:otherwise>
    </c:choose>
</nav>
