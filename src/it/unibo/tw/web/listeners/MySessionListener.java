package it.unibo.tw.web.listeners;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/* Viene chiamato il metodo sessionCreated ogni qualvolta una nuova sessione è creata,
 * si poteva fare con una servlet ma usando un listener la business logic diventa più pulita
 * e si ha un controllo fatto meglio sulle sessioni dato che vengono gestite completamente dal container
 */
public class MySessionListener implements HttpSessionListener
{
	private List<HttpSession> sessioni = new ArrayList<HttpSession>();
	
	@Override
	public void sessionCreated(HttpSessionEvent ses) 
	{
		HttpSession session = ses.getSession();
		//session.setMaxInactiveInterval(10); //Timeout della sessione in secondi
		
		System.out.println("Nuova sessione, ID=" + session.getId());
		this.sessioni.add(session);
		
		/* Inserisco la lista delle sessioni aggiornate in applicazione */
		session.getServletContext().setAttribute("sessioni", this.sessioni);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent ses) 
	{
		HttpSession session = ses.getSession();
		System.out.println("Distrutta sessione, ID="+session.getId());
		
		/* Sessione scaduta o distrutta rimossa dalla lista di sessioni */
		this.sessioni.remove(session);
	}
}
