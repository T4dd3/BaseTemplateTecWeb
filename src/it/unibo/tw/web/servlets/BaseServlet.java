package it.unibo.tw.web.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.*;
import java.util.stream.*;

import it.unibo.tw.web.beans.*;

public class BaseServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	Gson gson;

	@Override
	public void init() throws ServletException {
		gson = new Gson();
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(true);
		invalSessionAfterCreationTime(17 * 60 * 1000); //Invalida dopo 17 minuti dalla creazione
		String json = "[[2,6,4,8,8,9],[1,3,5,1,3,2],[4,5,4,1,4,7],[4,4,0,0,6,7]]";
		
		Type listType = new TypeToken<List<List<Integer>>>(){}.getType(); //Per convertire direttamente array da json
		Matrice a = new Matrice(gson.fromJson(json/*req.getParameter("matrice")*/, listType));
		Matrice[] subMatrices = a.subMatrices();
		return;
	}
	
	/* Invalida session dopo ms millisecondi dalla sua creazione */
	public void invalSessionAfterCreationTime (long ms) {
		@SuppressWarnings("unchecked")
		List<HttpSession> sessioni = (List<HttpSession>)this.getServletContext().getAttribute("sessioni");	
		/* La rimozione dalla lista sessioni avviene già nel SessionListener alla distruzione della sessione */
		sessioni.stream().filter(s -> new Date().getTime() - s.getCreationTime()  >= ms).
						collect(Collectors.toList()).forEach(HttpSession::invalidate);;
	}
}
