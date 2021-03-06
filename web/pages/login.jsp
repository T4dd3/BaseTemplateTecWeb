<!-- Per non far scaturire errori in console relativi a codifica caratteri -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>
<%@ page import="it.unibo.tw.web.beans.*" %>

<% /* Eseguo la gesione del login all'interno della jsp (avrei potuto usare una servlet),
	* ma essendo la business logic abbastanza semplice e compatta o preferito tenere tutto insieme */ %>
<html>
	<head>
		<meta name="Author" content="Giovanni Taddei">
		<title>Login</title>
		<meta charset="UTF-8">
		<meta http-equiv="Pragma" content="no-cache"/>
		<meta http-equiv="Expires" content="-1"/>
		<link type="text/css" href="../styles/myCss.css" rel="stylesheet"></link>
		<script type="text/javascript" src="../scripts/utils.js"></script>
		<script type="text/javascript" src="../scripts/myUtils.js"></script>
	
	<jsp:useBean id="utenti" class="it.unibo.tw.web.beans.Utenti" scope="application"></jsp:useBean>
	
	<%!public boolean allParametersInitialized(HttpServletRequest request, List<String> paramsName) {
			for (String par : paramsName) {
				if (request.getParameter(par) == null || request.getParameter(par).isBlank())
					return false;
			}
			return true;
		}%>
	<% 	
		Utente utente;
		String errorMessage = "";
		/*
		if (allParametersInitialized(request, Arrays.asList("user", "password"))) 
		{
			if (utenti.exist(request.getParameter("user"))) 
			{
				if ((utente = utenti.find(request.getParameter("user"), request.getParameter("password"))) != null) 
				{
					utente.setSession(session);
					session.setAttribute("utente", utente);
					RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/pages/main.jsp");
					rd.forward(request, response);
					return;
				}
				else
					errorMessage = "La password inserita è errata";
			}
			else
				errorMessage = "Non sei ancora registrato, <a href=\"signup.jsp\">registrati ora</a!";
		}
		else
			errorMessage = "Devi compilare tutti i campi per procedere";
			*/
	%>
	<%
		Map<String, Gruppo> gruppi = (Map<String, Gruppo>)application.getAttribute("gruppi");
		
		if (allParametersInitialized(request, Arrays.asList("user", "password"))) 
		{ 
			for (Gruppo g : gruppi.values()) 
			{
				if (g.exist(request.getParameter("user"))) 
				{
					if ((utente = g.find(request.getParameter("user"), request.getParameter("password"))) != null) 
					{
						utente.setSession(session);
						session.setAttribute("utente", utente);
						RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/pages/main.jsp");
						rd.forward(request, response);
						return;
					}
					else {
						errorMessage = "La password inserita è errata, riprova!";
						break;
					}
				}
				else
					errorMessage = "Non sei ancora registrato, <a href=\"signup.jsp\">registrati ora</a!";
			}
		}
		else
			errorMessage = "Devi compilare tutti i campi per procedere";

	%>
		
	</head>
	<body>	
		<center>
		<h1>Login:</h1>
		<div class="main">
			<form id="login"><table>
				<tr><td>Username: </td><td><input type="text" id="user" name="user" size="20" autocomplete="off"></td></tr>
				<tr><td>Password:  </td><td><input type="password" id="password" name="password" size="20" autocomplete="off"></td></tr>
				
				<tr><td colspan="2"><input type="submit" style="width:100%" name="login" value="Log-in"/></td></tr>
			</table></form>
			<span style="font-size: 0.8em">Non ancora registrato? <a href="./signup.jsp">Crea un account</a></span><br />
			<p style="color: red"><b><%=(request.getAttribute("error") != null) ? request.getAttribute("error") : 
										(request.getParameter("user") != null) ? errorMessage : "" %></b></p>
		</div>
		</center>
		
		<%@ include file="../fragments/footer.jsp" %>
	</body>
</html>