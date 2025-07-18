<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, pck.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>CrÃ©ation d'un nouveau projet</title>
</head>
<body>
    <h1>CrÃ©ation d'un nouveau projet</h1>
    <form>
        <label for="nom">Nom du projet:</label><br>
        <input type="text" id="text" name="nom" required><br><br>

        <label for="description">Description:</label><br>
        <textarea id="description" name="description" rows="4" cols="50"></textarea><br><br>

        <label for="dateDebut">Date de dÃ©but:</label><br>
        <input type="date" id="dateDebut" name="dateDebut" required><br><br>

        <label for="dateFin">Date de fin:</label><br>
        <input type="date" id="dateFin" name="dateFin" required><br><br>
        
        Choisir les eleves:<br>
<% 
Collection<Utilisateur> eleves = (Collection<Utilisateur>)request.getAttribute("eleves");
for (Utilisateur p : eleves) {
	String s = p.getNom();
%>
        <input type="checkbox" name="idpersonne" value="<%=s %>"> <br><%
}
%>
<br>
		
        <input type="submit" name = "operation" value = "CreationdunProjet"></form>
    </form>

</body>
</html>
