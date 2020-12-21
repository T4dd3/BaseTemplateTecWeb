<!-- Per non far scaturire errori in console relativi a codifica caratteri -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>
<%@ page import="it.unibo.tw.web.beans.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="Author" content="Giovanni Taddei">
	<title>Homepage</title>
	<meta charset="UTF-8">
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
	<link type="text/css" href="../styles/myCss.css" rel="stylesheet"></link>
	<script type="text/javascript" src="../scripts/utils.js"></script>
	<script type="text/javascript" src="../scripts/myUtils.js"></script>
</head>
<body>
	<% 	
		if (session.getAttribute("utente") != null) { %>
		<%@ include file="../fragments/header.jsp" %><%
		
	%>
		
	
	<%	}
		else {
			if (request.getParameter("user") == null) 
				request.setAttribute("error", "Effettua il login o registrati per usare la webapp");
			RequestDispatcher rd = application.getRequestDispatcher("/pages/login.jsp");
			rd.forward(request, response); 
		}%>
	<%@ include file="../fragments/footer.jsp" %>
</body>
</html>