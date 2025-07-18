<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, pck.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vos Projet</title>
</head>
<body>
    <h1>Liste des projets</h1>
    <form action="Serv" method="GET">
<br>
<%
Collection<Projet> listeprojets = (Collection<Projet>)request.getAttribute("listeprojet");
for (Projet p : listeprojets) {
	int id = p.getId();
	String s = p.getNom() + " : " + p.getStatutProjet();
%>
<input type="radio" name="idProjet" value="<%=id %>"> <%=s %><br>
<%
}
%>
<br>
    <input type="submit" name = "operation" value = "Consulterunprojet">
    <input type="submit" name = "operation" value = "Creeunnouveauprojet">
	</form>
</body>
</html>