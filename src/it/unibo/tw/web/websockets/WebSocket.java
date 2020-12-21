package it.unibo.tw.web.websockets;

import java.io.IOException;
import java.util.*;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;


@ServerEndpoint(value = "/wsPath")
public class WebSocket 
{
	Gson gson = new Gson();
	
	@OnOpen
	public void open(Session session) {
		System.out.println("Socket aperta! ID: " + session.getId());
	}
	
	@OnMessage
	public void handleMessage(String message, Session session) throws IOException
	{
		String id = message.split("-")[0];
		for (Session s : session.getOpenSessions()) {
			s.getUserProperties().get("x"); //Per accedere a proprieta "x" dell'utente
			if (s.getId().equals(id)) {
				s.getBasicRemote().sendText("Utente " + id + ": "+message.split("-")[1]);
				return;
			}
		}
		session.getBasicRemote().sendText("Non ci sono altri giocatori o non esiste");
	}
	
	@OnClose
	public void close(Session session) {
		System.out.println("Socket chiusa! ID: " + session.getId());
	}
}
