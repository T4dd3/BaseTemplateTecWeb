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
		<title>SignUp</title>
		<meta charset="UTF-8">
		<meta http-equiv="Pragma" content="no-cache"/>
		<meta http-equiv="Expires" content="-1"/>
		<link type="text/css" href="../styles/myCss.css" rel="stylesheet"></link>
		<script type="text/javascript" src="../scripts/utils.js"></script>
		<script type="text/javascript" src="../scripts/myUtils.js"></script>
	
	<jsp:useBean id="utenti" class="it.unibo.tw.web.beans.Utenti" scope="application"></jsp:useBean>
	
	<%!	public boolean allParametersInitialized(HttpServletRequest request, List<String> paramsName) {
			for (String par : paramsName) {
				if (request.getParameter(par) == null || request.getParameter(par).isBlank())
					return false;
			}
			return true;
		}%>
	<% 	
		String stato = "";
		if (request.getParameter("signup") != null)
			stato = "Compila tutti i campi per procedere!";
	
		/*if (allParametersInitialized(request, Arrays.asList("user", "password", "group")))
		{
			Utente nuovoUtente = new Utente(request.getParameter("user"), request.getParameter("password"), request.getParameter("group"));
			stato = "Ti sei registrato con successo! <a href=\"login.jsp\">Effettua il login</a>";
			
			for(Utente utente : utenti.getUtenti()) {
				if (nuovoUtente.equals(utente)) {
					nuovoUtente = null;
					stato = "Il tuo username è già registrato<br /><a href=\"login.jsp\">Effettua il login</a>";
					break;
				}
			}
			if (nuovoUtente != null) 
				utenti.getUtenti().add(nuovoUtente);
		} */
	%>
	<%
		Map<String, Gruppo> gruppi = (Map<String, Gruppo>)application.getAttribute("gruppi");
		
		if (allParametersInitialized(request, Arrays.asList("user", "password", "group"))) 
		{ 
			if (gruppi.keySet().contains(request.getParameter("group"))) 
			{
				Utente nuovoUtente = new Utente(request.getParameter("user"), request.getParameter("password"), request.getParameter("group"));
				for (Gruppo g : gruppi.values()) 
				{
					if (g.exist(request.getParameter("user"))) {
						stato = "Sei già registrato!";
						nuovoUtente = null;
						break;
					}
				}
				
				if (nuovoUtente != null) {
					gruppi.get(nuovoUtente.getGroup()).addUtente(nuovoUtente);
					stato = "Ti sei registrato con successo!";
				}
				stato += "<br /><a href=\"login.jsp\">Effettua il login</a>";
			}
			else
				stato = "Scegli un gruppo tra la lista di predefiniti";
		}

	%>
		
	</head>
	<body>	
		<center>
		<h1>Sign-Up:</h1>
		<div class="main">
			<form id="signup"><table>
				<tr><td>Username: </td><td><input type="text" id="user" name="user" size="20" autocomplete="off"></td></tr>
				<tr><td>Password:  </td><td><input type="password" id="password" name="password" size="20" autocomplete="off"></td></tr>
				<tr><td>Id gruppo: </td><td><select type="text" id="group" name="group">
					<% for(String group : new TreeSet<String>(gruppi.keySet())) { if (!group.equals("admin")) {%>
					<option value="<%=group %>"><%=group %></option>
					<%}} %>
					</select>
				</td></tr>
				<tr><td colspan="2"><input type="submit" style="width:100%" name="signup" value="Sign-Up"/></td></tr>
			</table></form>
			<span style="font-size: 0.8em">Hai già un account? <a href="./login.jsp">Effettua il login</a></span><br />
			<p style="color: red"><b><%=(request.getParameter("user") != null) ? stato : "" %></b></p>
		</div>
		</center>
		
		<%@ include file="../fragments/footer.jsp" %>
	</body>
</html>