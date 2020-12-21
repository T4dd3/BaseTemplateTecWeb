<!-- pagina per la gestione di errori -->
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>
<%@ page import="java.time.*" %>
<%@ page import="it.unibo.tw.web.beans.*" %>

<html>
	<head>
		<meta name="Author" content="Giovanni Taddei">
		<title>AdminPage</title>
		<meta charset="UTF-8">
		<meta http-equiv="Pragma" content="no-cache"/>
		<meta http-equiv="Expires" content="-1"/>
		<link type="text/css" href="../styles/myCss.css" rel="stylesheet"></link>
		<link type="text/css" href="../styles/table.css" rel="stylesheet"></link>
		<script type="text/javascript" src="../scripts/utils.js"></script>
		<script type="text/javascript" src="../scripts/myUtils.js"></script>
		<style>
			table, th, td {
			  border: 1px solid black;
			}
		</style>
	</head>
	<jsp:useBean id="utenti" class="it.unibo.tw.web.beans.Utenti"  scope="application"></jsp:useBean>
	<body>
		<%
		Map<String, Gruppo> gruppi = (Map<String, Gruppo>)application.getAttribute("gruppi");
		
		if(session.getAttribute("utente") != null && ((Utente)session.getAttribute("utente")).equals("admin")) 
		{ %>
			<%@ include file="../fragments/header.jsp" %>
			<h1 style="color: green">Pagina amministrazione</h1><br><br>
			<center>
			<form style="display: inline-block">
			Id gruppo: <select type="text" id="group" name="group" >
					<option value="showAll">Show All</option>
					<% for(String group : new TreeSet<String>(gruppi.keySet())) {%>
					<option value="<%=group %>"><%=group %></option>
					<%} %>
					</select>
					<input type="submit" value="Analizza" name="analizza"></input>
			</form>
			<% 	if (request.getParameter("group") != null) {%>
				<table class="personal"><tbody>
				<tr><th>User</th><th>Last password update</th><th>Expires in</th>
				<% 	if (request.getParameter("group").equals("showAll")) {
						%><th>Group</th></tr><%
						for(Gruppo gruppo : gruppi.values()) 
						{
							for(Utente utente : gruppo.getUtenti()) 
							{
								DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
								%><tr><td><%=utente.getUsername() %></td>
								<td><%=utente.getCreationTime().format(formatter) %></td>
								<td><%=60 - Duration.between(utente.getCreationTime(), LocalDateTime.now()).toDays()%> days</td>
								<td><%=gruppo.getGroupName() %></td></tr><%
								
							}
						}
					}
					else
					{
						%></tr><%
						for(Utente utente : gruppi.get(request.getParameter("group")).getUtenti()) 
						{
							if (utente.getGroup().equals(request.getParameter("group"))) 
							{
								DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
								%><tr><td><%=utente.getUsername() %></td>
								<td><%=utente.getCreationTime().format(formatter) %></td>
								<td><%=60 - Duration.between(utente.getCreationTime(), LocalDateTime.now()).toDays()%> days</td></tr><%
							}
						}
					}
				%>
				</tbody></table>
			<%} %>
			</center><%
		}
		else { %>
		<center>
			<b><p>Se vuoi vedere la pagina: <a href="signup.jsp">Registrati</a> o effettua il <a href="login.jsp">Login</a>! </p>
			<p>Per farlo devi essere un amministratore!</p></b>
		</center>
		<%} %>
		<%@ include file="../fragments/footer.jsp" %>
	</body>
</html>

