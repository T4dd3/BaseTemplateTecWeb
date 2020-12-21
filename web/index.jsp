<%@ page session="true"%>

<html>
   <head>
		<meta http-equiv="Refresh" content="4; URL=pages/login.jsp"/>
      	<title>WebApplication starting...</title>
		<link type="text/css" href="styles/myCss.css" rel="stylesheet"></link>
		<script>
			window.onload = function () {
				document.getElementsByTagName("p")[0].style.marginTop = window.innerHeight * 0.1;
			};
			window.onresize = window.onload;
		</script>
   </head>
   <body style="background-color: black;">
	<center>
    	<p style="color: white">
      		<b>Your WebApp is loading... <br /><br /></b>
			<img width="auto" height="50%" alt="wait" title="wait" src="images/wait.gif"/>
      	</p>
	</center>
	<%@ include file="fragments/footer.jsp" %>
   </body>
</html>

