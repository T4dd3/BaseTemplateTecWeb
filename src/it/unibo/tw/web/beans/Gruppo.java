package it.unibo.tw.web.beans;

import java.util.*;

public class Gruppo {
	private List <Utente> utenti;
	private String groupName;
	
	/* Metodi di Utility */
	public boolean contains(Utente ut) {
		return this.utenti.contains(ut);
	}
	public Utente find(String user, String password) {
		return this.utenti.stream()
				.filter(x -> x.getPassword().equals(password) && x.getUsername().equals(user))
				.findFirst().orElse(null); 
	}
	public boolean addUtente(Utente ut) {
		try {
			if (this.utenti.contains(ut))
				this.utenti.remove(ut);
			this.utenti.add(ut);
		} catch (Exception ex) {
			return false;
		}
		return true;
	}
	public boolean exist(String user) {
		return this.utenti.stream().
				filter(x -> x.getUsername().equals(user)).count() > 0;
	}
	
	/* Costruttori */
	public Gruppo() {
		this.utenti = new ArrayList<Utente>();
	}
	public Gruppo(List<Utente> utenti, String groupName) {
		super();
		this.utenti = utenti;
		this.groupName = groupName
				;
	}
	
	/* Metodi Accessor */
	public List<Utente> getUtenti() {
		return utenti;
	}
	public void setUtenti(List<Utente> utenti) {
		this.utenti = utenti;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
}
