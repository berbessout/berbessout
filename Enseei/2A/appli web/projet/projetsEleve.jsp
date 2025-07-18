<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INDEX</title>
</head>
<body>
    <h1>Liste des projets</h1>
    <form action="Serv" method="GET">
<br>
<% 
Collection<Projet> listeprojets = (Collection<Projet>)request.getAttribute("utilisateur").getProjets();
for (Projet p : listeprojets) {
	int id = p.getId();
	String s = p.getNom() + " : " + p.getStatutProjet();
%>
<input type="radio" name="idProjet" value="<%=id %>"> <%=s %><br>
<%
}
%>
<br>
    <input type="submit" name = "operation" value = "ProjetsEleve">
	</form>
</body>
</html>