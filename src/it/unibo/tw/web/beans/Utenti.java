package it.unibo.tw.web.beans;

import java.util.*;

/* Uso una classe di appoggio per contenere tutti gli utenti
 * in modo tale che possa usare dei metodi di utility direttamente sull'oggetto utenti
 * così facendo scrivo un po' più di codice all'inizio, ma risparmio molto tempo e codice inutile nella 
 * business logic dell'applicazione se ho bisogno di implementare qualcosa per lavorare sugli utenti
 */
public class Utenti {
	List<Utente> utenti;
	
	public Utenti() {
		super();
		this.utenti = new ArrayList<Utente>();
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
	
	public Utente find(String user, String password) {
		return this.utenti.stream()
				.filter(x -> x.getPassword().equals(password) && x.getUsername().equals(user))
				.findFirst().orElse(null);
	}
	public boolean exist(String user) {
		return this.utenti.stream().
				filter(x -> x.getUsername().equals(user)).count() > 0;
	}

	public List<Utente> getUtenti() {
		return utenti;
	}
	public void setUtenti(List<Utente> utenti) {
		this.utenti = utenti;
	}
}
