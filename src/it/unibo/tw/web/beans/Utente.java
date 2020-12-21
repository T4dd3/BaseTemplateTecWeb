package it.unibo.tw.web.beans;

import java.time.LocalDateTime;
import java.util.Date;

import javax.servlet.http.HttpSession;

/* Ho implementato già vari metodi che potrebbero tornarmi utili */
public class Utente {
	private String username;
	private String password;
	private String group;
	private HttpSession session = null;
	private LocalDateTime creationTime;
	
	/* Costruttori */
	public Utente(String username, String password) {
		super();
		this.username = username;
		this.password = password;
		this.creationTime = LocalDateTime.now();
	}
	public Utente(String username, String password, String group) {
		super();
		this.username = username;
		this.password = password;
		this.group = group;
		this.creationTime = LocalDateTime.now();
	}
	
	/* Metodi di utility per login e confronto */
	public boolean login(Utente ut) {
		return this.getUsername().equals(ut.getUsername()) && this.getPassword().equals(ut.getPassword());
	}
	public boolean login(String user, String password) {
		return this.getUsername().equals(user) && this.getPassword().equals(password);
	}
	@Override
	public boolean equals(Object ut) {
		Utente userComp = (Utente)ut;
		return this.getUsername().equals(userComp.getUsername());
	}
	public boolean equals(String toCompUser) {
		return this.getUsername().equals(toCompUser);
	}
	
	/* Metodi Accessor */
	public HttpSession getSession() {
		return session;
	}
	public void setSession(HttpSession session) {
		this.session = session;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public LocalDateTime getCreationTime() {
		return creationTime;
	}
	public void setCreationTime(LocalDateTime creationTime) {
		this.creationTime = creationTime;
	}
	
}
