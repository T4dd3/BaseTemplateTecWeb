function subMatrix(matrix) {
	/* Suppongo la mia matrice con numero di righe e colonne pari, non per forza quadrata */
	var res = {"m0": [], "m1":[], "m2": [], "m3": [] }
	
	var halfHor = matrix[0].length / 2 + matrix[0].length % 2;
	var halfVert = matrix.length / 2 + matrix.length % 2;
	for (var i = 0; i < 4; i++) {
		halfI = Math.floor(i / 2);
		for (var j = halfI + (halfI *(halfVert - 1)) ; j < halfVert + halfVert*halfI; j++) {
			if (i % 2 == 0)
				res["m" + i].push(matrix[j].slice(0, halfHor));
			else
				res["m" + i].push(matrix[j].slice(halfHor, matrix[0].length));
		}
	}
	return res;
}

function callbackJSON( theXhr ) {
	if ( theXhr.readyState === 4 ) {
		if ( theXhr.status === 200 ) {
			console.log(theXhr.response);
			var json = JSON.parse(theXhr.response);
			
			myGetElementById("output").innerHTML = theXhr.response;
		}
		else if ( theXhr.status == 404)
			alert("Ricevuto 404, controlla url: "+ theXhr.responseURL);
		else 
			alert("Impossibile effettuare l'operazione richiesta.\n");
	}
}

function inviaDati() {
	var xhr = myGetXmlHttpRequest();
	
	if ( xhr ) {
		/* Binding funzione di callback */
		xhr.onreadystatechange = function() { callbackJSON(xhr); };

		try {
			/* Apertura connessione verso destinatario */
			xhr.open("post", "../***NOMEDEST(SERVLET)***", true);
		}
		catch(e) { alert(e); }
		
		var data = { "dati": [] };
		
		/* Settaggio header adeguati per la corretta trasmissione e ricezione dei dati */
		xhr.setRequestHeader("connection", "close");
		xhr.setRequestHeader("content-type", "application/x-www-form-urlencoded");
		
		/* Invio della richiesta */
		console.log(JSON.stringify(data));
		xhr.send(JSON.stringify(data));
	}
	else 
		alert("Il tuo browser non supporta AJAX");
}