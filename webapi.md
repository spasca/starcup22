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


