package it.unibo.tw.web.listeners;

import java.util.*;

import it.unibo.tw.web.beans.*;

import javax.servlet.*;

/* ContextListener viene chiamato al primo avvio della web-app (metodo contextInitialized) e alla sua chiusura 
 * Lo utilizzo per inizializzare le strutture ed i beans della mia webapp 
 * Così facendo rendo i codici di business logic delle mie servlet e jsp più pulito */
public class MyServletContextListener implements ServletContextListener 
{
	Utenti utenti;
	Map<String, Gruppo> gruppi;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) 
	{
		utenti = new Utenti();
		gruppi = new HashMap<String, Gruppo>();
		
		inizializzaUtenti();
		inizializzaGruppi();
		
		sce.getServletContext().setAttribute("utenti", utenti);
		sce.getServletContext().setAttribute("gruppi", gruppi);
		System.out.println("Application context created!");
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) 
	{
		System.out.println("Application context destroyed!");
	}
	
	public void inizializzaGruppiVuoti() {
		gruppi.put("group_1", new Gruppo(new ArrayList<Utente>(), "group_1"));
		gruppi.put("group_2", new Gruppo(new ArrayList<Utente>(), "group_2"));
		gruppi.put("group_3", new Gruppo(new ArrayList<Utente>(), "group_3"));
		gruppi.put("admin", new Gruppo(Arrays.asList(new Utente("admin", "admin", "admin")), "admin"));
	}
	
	public void inizializzaGruppi() {
		List<Utente> usersApp = new ArrayList<Utente>();
		usersApp.add(new Utente("u1", "u1", "group_1"));
		usersApp.add(new Utente("u2", "u2", "group_1"));
		usersApp.add(new Utente("u3", "u3", "group_1"));
		gruppi.put("group_1", new Gruppo(usersApp, "group_1"));
		
		usersApp = new ArrayList<Utente>();
		usersApp.add(new Utente("u4", "u4", "group_2"));
		usersApp.add(new Utente("u5", "u5", "group_2"));
		gruppi.put("group_2", new Gruppo(usersApp, "group_2"));
		
		gruppi.put("group_3", new Gruppo(new ArrayList<Utente>(), "group_3"));
		
		gruppi.put("admin", new Gruppo(Arrays.asList(new Utente("admin", "admin", "admin")), "admin"));
	}
	
	public void inizializzaUtenti() 
	{
		this.utenti.addUtente(new Utente("u1", "u1", "group_1"));
		this.utenti.addUtente(new Utente("u2", "u2", "group_1"));
		this.utenti.addUtente(new Utente("u3", "u3", "group_1"));
		this.utenti.addUtente(new Utente("u4", "u4", "group_2"));
		this.utenti.addUtente(new Utente("u5", "u5", "group_2"));
		this.utenti.addUtente(new Utente("admin", "admin", "admin"));
	}
}
