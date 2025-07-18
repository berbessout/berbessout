<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, pck.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<% 
Utilisateur user = (Utilisateur) request.getAttribute("utilisateur");
%>
<%= user.getNom() %>
<%= user.getMdp() %>
<%= user.getRole() %>

<h2>Modifier les informations :</h2>
    <form action="Serv" method="GET">
        <label for="nom">Nom :</label>
        <input type="text" id="username" name="username" value="${utilisateur.nom}"><br>

        <label for="mdp">Mot de passe :</label>
        <input type="password" id="password" name="password" value="${utilisateur.mdp}"><br>
		
        <input type="submit" name = "operation" value="Modifier">
    </form>

</body>
</html>