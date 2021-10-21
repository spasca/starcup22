# Starcup 2022 Web API

Server addr:  77.81.229.90


# To Do

- [ ] Definire un modello di JSON standard con supporto errori e autenticazione
- [ ] Definire tutti gli endpoint necessari
- [ ] Preparare il database con i dati delle starcup vecchie per fare i test
- [ ] Implementazione delle funzioni WebAPI
- [ ] Ingrandire il set di dati
- [ ] Preparare qualche test per l'API


# Domande da risolvere

1. I valori null come li mostriamo??!!? null, "null", 0, {} oppure?!?!
2. Le variabili del CAP le facciamo integer o string?


# Settings generali

## Principi generali

1. Le risorse hanno tutti nomi al singolare, tranne quando sono alla fine della catena dell'URL e definiscono una pluralità di entità
2. Tutti gli URL restituiti dalla nostra API sono **ASSOLUTI**
3. Non soddisfiamo il paradigma *HATEOAS* restituendo puntatori alle risorse ma cerchiamo il più possibile di restituire JSON e dati grezzi, usabili

## Gestione degli errori

### Codici di stato

Nel nostro progetto useremo gli status code HTTP per la gestione degli errori.

1. Codici di successo: codice `2xx`
  * `200`: OK, l'azione richiesta ha avuto successo
  * `201`: Created, una nuova risorsa è stata creata
  * `202`: Accepted, la richiesta è stata ricevuta ma non sono state fatte modifiche
  * `204`: Non Content, la richiesta è stata eseguita con successo ma la risposta non ha contenuto (come dopo una DELETE)
  
2. Codici di errore: codice `4xx` e `5xx`
  * `400`: Bad Request, la richiesta non è conforme
  * `401`: Unauthorized, il client non ha autorizzazione ad eseguire la operazione richiesta
  * `404`: Not Found, la risorsa richiesta non è stata trovata
  * `415`: Unsupported Media Type, i dati spediti sono in un formato non supportato (ad es. XML e non JSON)
  * `422`: Unprocessable Entity, i dati sono ben formattati ma contengono dati invalidi o mancanti
  * `500`: Internal Server Error, il server ha sollevato un errore nel processare la richiesta
  
Se il sistema emette uno dei condici di errore, il contenuto del payload JSON conterrà un campo 'error' con una stringa che descrive l'errore.

## Tipi di Persone
Ogni persona è registrata nel sistema con i suoi dati anagrafici (uguali per tutti) e con il dettaglio del suo ruolo nel sistema:
1. `Utente`: è l'utente registrato nel sistema che può inserire dati
2. `Allenatore`: è uno degli allenatori di una Squadra (specifica di squadra)
3. `Giocatore`: è uno dei giocatori di una Squadra (specifica di squadra)
4. `Referente`: è uno dei referenti di una Squadra (specifica di squadra)

# Strutture dati

## Problemi da risolvere
- Negli indirizzi c'è bisogno di separare l'indirizzo, la località, il cap ecc..


## Defaults
- Tutti gli ID chiave primaria sono registrati col nome *id*
- Tutti gli URL DEVONO ESSERE ASSOLUTI


### `PersonaJSON`
L'anagrafica di una persona registrata nel sistema.
Contiene:
- `integer` *id*: il codice della persona nel db
- `string` *nome*: il nome della persona
- `string` *cognome*: il cognome della persona
- `string` *sesso*: il sesso della persona ('M' o 'F)
- `string` *luogonascita*: il luogo di nascita
- `datetime` *datanascita*: la data di nascita
- `string` *indirizzo*: l'indirizzo della persona
- `string` *email*: l'email della persona
- `URL` *foto*: l'url della foto tessera della persona
- `URL` *documento*: l'url della foto del documento della persona
- `string` *telefono*: il numero di telefono della persona


Esempio
```json
{
  "id":1,
  "nome":"Simone",
  "cognome":"Pascarosa",
  "sesso": "M",
  "luogonascita":"Perugia",
  "datanascita":"1984-11-24",
  "indirizzo":"Via della Concordia, 42",
  "email":"simone.pascarosa@gmail.com",
  "foto":"http://sportlab.cloud/starcup22/imgdb/simone.pascarosa_foto.jpg",
  "documento":"http://sportlab.cloud/starcup22/imgdb/simone.pascarosa_documento.jpg",
  "telefono":"3493731005"
}
```

### `UtenteJSON` -> estende `PersonaJSON`
Un utente registrato nel sistema.

Oltre ai dati di `PersonaJSON` contiene:
- `integer` *id*: attenzione, l'*id* è dell'utente, non di persona
- `integer` *persona_id*: il codice della persona nella entità persona
- `string` *ruolo*: specifica di un ruolo particolare nel sistema (serve?!?!?)
- `string` *nomeutente*: il nome utente
- `string` *password*: la password (in chiaro???)
- `GruppoJSON` *gruppo*: gruppo di appartenenza
- `boolean` *amministratore*: gruppo di appartenenza

Esempio:
```json
{
  "id":1,
  "nome":"Simone",
  "cognome":"Pascarosa",
  "sesso": "M",
  "luogonascita":"Perugia",
  "datanascita":"1984-11-24",
  "indirizzo":"Via della Concordia, 42",
  "email":"simone.pascarosa@gmail.com",
  "foto":"http://sportlab.cloud/starcup22/imgdb/simone.pascarosa_foto.jpg",
  "documento":"http://sportlab.cloud/starcup22/imgdb/simone.pascarosa_documento.jpg",
  "telefono":"3493731005",
  "persona_id":"1",
  "ruolo":"root",
  "nomeutente":"spasca",
  "password":"mamicaPens1ket3LOdica",
  "gruppo": {
    "id":1,
    "denominazione":"Oratorio Piergiorgio Frassati State Buoni se Potete",
    "UP":9,
    "ZP":2
  },
  "amministratore":true
}
```





## Lista endpoint

Quelle che seguono sono tutte le richieste che gli adapters dovrebbero poter soddisfare, per consentire una gestione totale e intuitiva del database.

Può darsi che in futuro ci accorgeremo che qualcuno di questi non serve, quelli a cui si darebbe meno fiducia sono segnati con "???".
Per il momento possiamo ignorarli.

<details>
  <summary> Vedi i dubbi rimasti </summary>

(Cosa che non mi è chiara:
per stampare la classifica di un girone si prendono tutte le partite del girone e si ricalcolano i punteggi di tutte le squadre ogni singola volta..?
Non vedo dati di classifica salvati da nessuna parte, quindi credo sia così...

*Don Simo*: **Si, ogni volta vengono ricalcolati i risultati (potremmo fare una piccola cache/proxy per questa richiesta così da non doverla calcolare ad ogni request**)

Alternativa:
salvare in Posizione tutti i dati di classifica.
E' un luogo adatto perché rappresenta la squadra in quanto partecipante ad un dato torneo, e tutti i dati di classifica sono in effetti legati al torneo.
Quindi Posizione potrebbe avere i campi: "Giocate","Vittorie","Pareggi","Sconfitte","GF","GS","Punti".

*Don Simo*: **No, la classifica va calcolata, altrimenti è ridondante e dovremmo assicurare di tenere sempre aggiornati questi dati sul DB. Soluzione--> fare una cache della richiesta di ricalcolo della classifica, così invece che fare la query ad ogni richiesta, magari tiene in cache la richiesta e la fa una volta al minuto o più.**)
  
*Xzy*: **Ok. Invece che a intervalli di tempo si potrebbe anche ricalcolarla ogni volta che viene modificata una Partita nel database, mi sembra più pulito. La mettiamo in un file tendenzialmente statico, immagino: tipo un json?**

Vantaggio:
molto più semplice stampare le classifiche!!

Pecca:
i dati della classifica sono già contenuti nell'insieme delle partite giocate nel girone/torneo.
A: sarebbe una ripetizione.
B: bisognerebbe scrivere i metodi di modifica degli oggetti "Partita" in modo che, se si cambia/corregge un dato significativo di una partita,
anche i dati nelle Posizioni coinvolte dalla partita siano corretti di conseguenza.)

(Spunto:
aggiungere nel database una Tabella per i Gironi?
Conterrebbe i campi: "IdGirone" INT, "CodTorneo" INT, "NomeGirone" CHAR(1).
I campi "CodTorneo" INT e "Girone" CHAR(1) di Posizione andrebbero sostutiti con un campo "CodGirone" INT.
Dal punto di vista logico mi sembra un lieve miglioramento.
Dal punto di vista pratico credo che sia un lieve peggioramento nella sintassi delle interrogazioni.)

*Don Simo*: **Valutiamo insieme questa cosa ... ci devo pensare un attimo ... mi sembra però intelligente come analisi**

(Le risorse "aggiuntive" non sono tra quelle principali individuate dal Pasca per inizializzare il sistema di iscrizioni, perché giustamente si usano dopo.
Però dovremo affrontarle prima o poi.)

</details>
<br><br>

Per ogni risorsa è possibile richiedere:
 - La lista completa delle risorse di quel tipo nel database
 - La singola risorsa corrispondente a un id dato
 - La lista di tutte le risorse figlie di una data risorsa madre, e queste sono le voci di tipo "da"
 - Una delle liste precedenti filtrata tramite un altro parametro, che può essere:
   - un possibile valore di un campo all'interno alla risorsa
   - l'id di una risorsa collegata
   e queste sono le voci di tipo "per"

<br>
<details>
  <summary> Visualizza lista completa </summary>
  
 - Gruppi (`Gruppo`)
   - Lista (/gruppi)
   - da id (/gruppo/{id})

 - Utenti (`Persona` + `Utente`)
   - Lista (/utenti)
   - da id (/utente/{id})
   - da `Gruppo` (/utenti/gruppo/{id_gruppo}) (/gruppo/{id_gruppo}/utenti)

 - Arbitri (`Persona` + `Arbitro`)
   - Lista (/arbitri)
   - da id (/arbitro/{id})

 - Elementi (`Persona` + `RuoloInSquadra`) (PROPOSTA alternativa, da valutare)
   - Lista (/elementi)
   - da id (/elemento/{id})
   - da `Squadra` (/elementi/squadra/{id_squadra}) (/squadra/{id_squadra}/elementi)
   - da `Gruppo` ??? (/elementi/gruppo/{id_gruppo}) (/gruppo/{id_gruppo}/elementi)
   - per `Ruolo` (/[...]?ruolo={id_ruolo}) (id_ruolo in ["1", "2", "3"])

*Don Simo*: **Ho capito il motivo della tua proposta e propongo di accoglierla cambiando il nome da Elementi a Componenti, mi sembra più comprensibile.**
*Xzy*: **Ho usato un sinonimo perché React, come hai visto, ha cose che si chiamano Componenti; ma andrebbe bene anche chiamarli Componenti, sarà difficile fare confusione.**


<details>
  <summary> Visualizza idea originale </summary>

 - Vari tipi di Persona
   - Giocatori (`Persona` + `RuoloInSquadra`)
     - Lista (/giocatori)
     - da id (/giocatore/{id})
     - da `Squadra` (/giocatori/squadra/{id_squadra}) (/squadra/{id_squadra}/giocatori)
     - da `Gruppo` ??? (/giocatori/gruppo/{id_gruppo}) (/gruppo/{id_gruppo}/giocatori)
   - Allenatori (`Persona` + `RuoloInSquadra`)
     - Lista (/allenatori)
     - da id (/allenatore/{id})
     - da `Squadra` (/allenatori/squadra/{id_squadra}) (/squadra/{id_squadra}/allenatori)
     - da `Gruppo` ??? (/allenatori/gruppo/{id_gruppo}) (/gruppo/{id_gruppo}/allenatori)
   - Referenti (`Persona` + `RuoloInSquadra`) (Serve???)
     - Lista (/referenti)
     - da id (/referente/{id})
     - da `Squadra` (/referenti/squadra/{id_squadra}) (/squadra/{id_squadra}/referenti)
     - da `Gruppo` (/referenti/gruppo/{id_gruppo}) (/gruppo/{id_gruppo}/referenti)
  </details>

 - Partite (`Partita`)
   - Lista (/partite)
   - da id (/partita/{id})
   - da `Torneo` (/partite/torneo/{id_torneo}) (/torneo/{id_torneo}/partite)
   - da `Girone` (/partite/girone/{id_girone}) (/girone/{id_girone}/partite)
   - da `Campo` (/partite/campo/{id_campo}) (campo/{id_campo}/partite)
   - da `Squadra` ??? (/partite/squadra/{id_squadra}) (squadra/{id_squadra}/partite)
   - da `Arbitro` ??? (/partite/arbitro/{id_arbitro}) (arbitro/{id_arbitro}/partite) 
   - per Data e Fascia Oraria ??? (/[...]?data={data}&inizio={ora_inizio}&fine={ora_fine}) (data="YYYYMMDD", ora_inizio,ora_fine="hhmm")
   - per Nascosta ??? (/[...]?nascosta={nascosta}) (nascosta in ["True", "False"])
   - per `Torneo` ??? (/[...]?torneo={id_torneo})

 - Squadre (`Squadra`)
   - Lista (/squadre)
   - da id (/squadra/{id})
   - da `Utente` (/squadre/utente/{id_utente}) (/utente/{id_utente}/squadre)
   - da `Gruppo` (/squadre/gruppo/{id_gruppo}) (/gruppo/{id_gruppo}/squadre)
   - da `Partita` (/squadre/partita/{id_partita}) (/partita//{id_partita}/squadre)
   - da `Torneo` (/squadre/torneo/{id_torneo}) (/partita//{id_partita}/squadre)
   - (ipotesi) da `Girone` (/squadre/girone/{id_girone}) (/partita//{id_girone}/squadre)
     - (altrimenti) per Girone (/[...]?girone={id_girone}) (vedi dubbi sopra. Si potrebbe anche definire endpoint appositi, impropriamente: Girone non è una risorsa)
<details>
  <summary> Risorse aggiuntive </summary>

 - Gironi (`Girone`) (Serve farla???)
   - Lista (/gironi)
   - da id (/girone/{id})
   - da `Torneo` (/gironi/torneo/{id_torneo}) (/torneo/{id_torneo}/gironi)
 
 - Goal (`Goal` + `RuoloInSquadra` + `Persona` + `Squadra`)
   - Lista (/goals)
   - da id (/goal/{id})
   - da `Partita` (/goals/partita/{id_partita}) (/partita/{id_partita}/goals)
   - da `Giocatore` ??? (/goals/giocatore/{id_giocatore}) (/giocatore/{id_giocatore}/goals)

 - Tornei (`Torneo`)
   - Lista (/tornei)
   - da id (/torneo/{id})
   - da `Squadra` ??? (/tornei/squadra/{id_squadra}) (/squadra/{id_squadra}/tornei)

 - Pagamenti (`Pagamento`)
   - Lista (/pagamenti)
   - da id (/pagamento/{id})
   - da `Squadra` (/pagamenti/squadra/{id_squadra}) (/squadra/{id_squadra}/pagamenti)
   - da `Utente` ??? (/pagamenti/utente/{id_utente}) (/utente/{id_utente}/pagamenti)
   - da `Gruppo` ??? (/pagamenti/gruppo/{id_gruppo}) (/gruppo/{id_gruppo}/pagamenti)

 - Campi (`Campo`)
   - Lista (/campi)
   - da id (/campo/{id})

 - Posizioni (`Posizione`) (Serve???)
   - Lista (/posizioni)
   - da id (/posizione/{id})
   - da `Torneo` ??? (/posizioni/torneo/{id_torneo}) (/torneo/{id_torneo}/posizioni)
   - da `Girone` ??? (/posizioni/girone/{id_girone}) (/girone/{id_girone}/posizioni)

 - Persone (`Persona`) (Serve???)
   - Lista (/persone)
   - da id (/persona/{id})

 - Ruoli (`Ruolo`) (Serve???)
   - Lista (/ruoli)
   - da id (/ruolo/{id})

 - ConstraintsSquadra ???
 - ConstraintsGruppo ???
  </details>
  </details>




# Risorse e verbi disponibili

## Utente

### /gruppi -> `ArGruppoJSON`

La risorsa gestisce una pluralità o il singolo gruppo parrocchiale.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce l'anagrafica di tutti i gruppi parrocchiali |`ArGruppoJSON` |
| `POST` | `GruppoJSON`  senza id| Aggiunge un gruppo nel DB|  `GruppoJSON`  |
| `PUT`| - | - | - |
| `DEL` | - | **** Elimina tutti i gruppi parrocchiali, eliminando anche i relativi utenti e squadre | `Response` |


### /gruppi/{id} -> `GruppoJSON`

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce il singolo gruppo |`GruppoJSON` |
| `POST` | - | - | - |
| `PUT`| `GruppoJSON` | Modifica un prodotto | `Response` |
| `DEL` | - | Elimina il gruppo dalla lista, eliminando anche i relativi utenti e squadre| `Response` |


### /gruppi/{id}/squadre -> `ArSquadraJSON`

La risorsa gestisce una pluralità di squadre appartenenti allo stesso gruppo parrocchiale.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce l'elenco di tutte le squadre di quel gruppo |`ArSquadraJSON` |
| `POST` | `SquadraJSON`  senza id| Aggiunge una nuova squadra per quel gruppo|  `SquadraJSON`  |
| `PUT`| - | - | - |
| `DEL` | - |Elimina tutte le squadre di quel gruppo | `Response` |


### /gruppi/{id}/utenti -> `ArUtenteJSON`

La risorsa gestisce una pluralità di utenti appartenenti allo stesso gruppo parrocchiale.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce l'elenco di tutti gli utenti di quel gruppo |`ArUtenteJSON` |
| `POST` | `UtenteJSON`  senza id| Aggiunge un nuovo utente per quel gruppo|  `UtenteJSON`  |
| `PUT`| - | - | - |
| `DEL` | - |Elimina tutte gli utenti di quel gruppo | `Response` |


