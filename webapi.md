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

## Prodotti

### /prodotti -> `ArProdottoJSON`

La risorsa gestisce una pluralità o il singolo prodotto.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce l'anagrafica di tutti i prodotti |`ArProdottoJSON` |
| `POST` | `ProdottoJSON`  senza id| Aggiunge un prodotto nel DB|  `ProdottoJSON`  |
| `PUT`| - | - | - |
| `DEL` | - | Elimina tutti i prodotti dalla lista, eliminando anche i relativi box che li contengono | `Response` |


### /prodotti/{id} -> `ProdottoJSON`
Risorsa che gestisce un singolo prodotto specificato nell'ID nell'URL

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce il singolo prodotto |`ProdottoJSON` |
| `POST` | - | - | - |
| `PUT`| `ProdottoJSON` | Modifica un prodotto | `Response` |
| `DEL` | - | Elimina il prodotto dalla lista, eliminando tutti i box che contengono quel prodotto | `Response` |


## Box
***ATTENZIONE QUESTI SONO I BOX GENERICI!***
L'entità qualificante di questo progetto, descrive i dati contenuti nel DB per i box.

### /box -> `ArBoxJSON`

La risorsa gestisce una pluralità di box.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce l'elenco di tutti i box generici | `ArBoxJSON` |
| `POST`| `BoxJSON`  senza id| Aggiunge un box nel DB|  `BoxJSON` |
| `PUT` | - | - | - |
| `DEL` | - | Elimina tutti i box dalla lista | `Response` |


### /box/:id -> `BoxJSON`

La risorsa gestisce un singolo box generico (cioè non relativo ad un certo negozio).

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce l'anagrafica del box con quell'ID |`BoxJSON` |
| `POST` | - | - |  - |
| `PUT`| `BoxJSON`     | Modifica un box in lista | `Response` |
| `DEL` | - | Elimina il box dalla lista | `Response` |


### /box/{id}/prodotti -> `ArProdottoInBoxJSON`
Restituisce solo l'array di prodorri di un box (che comunque è già contenuto nel JSON del box. Questo serve ad avere l'array diretto.
|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce l'elenco dei prodotti nel box |`ArProdottoInBoxJSON` |
| `POST` | `ProdottoInBoxJSON` | Aggiunge un prodotto ai prodotti nel box |  - |
| `PUT`| `ProdottoInBoxJSON`     | Modifica le quantità di un prodotto nel box | `Response` |
| `PUT`| `ArProdottoInBoxJSON` | Rimpiazza la lista di prodotti del box con quella fornita | `Response` |
| `DEL` |  | Elimina il box dalla lista | `Response` |


### /box/{id}/negozi -> `ArNegozioJSON`
Restituisce l'array di negozi in cui un box è disponibile.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce l'elenco dei negozi in cui il box è disponibile |`ArNegozioJSON` |
| `POST` | - | - |  - |
| `PUT`| - | - | - |
| `DEL` | - | - | - |



## Negozio

Per la gestione del negozio e dei box che i negozi offrono.



### /negozio -> `ArNegozioJSON`
Restituisce tutti i negozi nel sistema

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce l'elenco di tutti i negozi | `ArNegozioJSON` |
| `POST`| `NegozioJSON`  senza id| Aggiunge un negozio nel DB|  `NegozioJSON` |
| `PUT` | - | - | - |
| `DEL` | - | Elimina tutti i negozi dalla lista, e tutti i relativi box | `Response` |


### /negozio/{id} -> `NegozioJSON`

La risorsa gestisce un singolo negozio.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - |Restituisce l'anagrafica del negozio con quell'ID |`NegozioJSON` |
| `POST` | - | - |  - |
| `PUT`| `NegozioJSON` | Modifica un negozio in lista, lasciando inalterati i suoi box | `Response` |
| `DEL` | - | Elimina il negozio dalla lista, con i relativi box | `Response` |


### /negozio/{id}/boxes -> `ArBoxInNegozioJSON`

Gestisce i box registrati per quel negozio.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce la lista dei box di quel negozio | `BoxInNegozioJSON` |
| `POST` | `BoxInNegozioJSON` senza negozio | Aggiunge il box al negozio con la relativa disponibilità e prezzo | `Response` |
| `PUT`| `BoxInNegozioJSON` | Modifica la disponibilità o il prezzo di un box nel negozio | `Response` |
| `DEL` | - | - | `Response` |


### /negozio/{id}/boxes/{id_boxinnegozio} -> `BoxInNegozioJSON`

Gestisce i box registrati per quel negozio.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce quel box in negozio con la sua disponibilità e il suo prezzo | `BoxInNegozioJSON` |
| `POST` | - | - | - |
| `PUT`| `BoxInNegozioJSON` | Modifica la disponibilità o il prezzo di questo box nel negozio | `Response` |
| `DEL` | - | Rimuove questo box tra quelli disponibili per il negozio | `Response` |


### /negozio/cap/{cap} -> `ArNegozioJSON`
Restituisce tutti i negozi che si trovano in una certa zona

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce l'elenco di tutti i negozi con quel CAP | `ArNegozioJSON` |



## Ordine

Per la gestione degli ordini dei clienti.



### /ordine-> `ArOrdineJSON`
Restituisce tutti gli ordini nel sistema

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce l'elenco di tutti gli ordini | `ArOrdineJSON` |
| `POST`| `OrdineJSON`  senza id| Inserisce un nuovo ordine |  `OrdineJSON` |
| `PUT` | - | - | - |
| `DEL` | - | Elimina tutti gli ordini nel sistema | `Response` |


### /ordine/{id} -> `OrdineJSON`

La risorsa gestisce un singolo ordine.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce l'ordine di codice id |`OrdineJSON` |
| `POST` | - | - |  - |
| `PUT`| `OrdineJSON` | Modifica un ordine in lista | `Response` |
| `DEL` | - | Elimina l'ordine dal sistema | `Response` |


### /ordine/{id}/boxes -> `ArBoxInOrdineJSON`

Gestisce i box registrati in un certo ordine.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce la lista dei box in quell'ordine | `BoxInOrdineJSON` |
| `POST` | `BoxInOrdineJSON` | Aggiunge il box all'ordine | `Response` |
| `PUT`| `BoxInNegozioJSON` | Modifica la quantita di quel box nell'ordine | `Response` |
| `DEL` | - | - | `Response` |



### /ordine/{id}/boxes/{idboxinordine} -> `BoxInOrdineJSON`

Gestisce un certo box in un certo ordine.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce il box in quell'ordine | `BoxInOrdineJSON` |
| `POST` | - | - | - |
| `PUT`| `BoxInOrdineJSON` | Modifica la quantita di quel box nell'ordine | `Response` |
| `DEL` | - | Cancella la prenotazione di questo specifico box nell'ordine | `Response` |


### /ordine/data/{data} -> `ArOrdineJSON`

Gestisce gli ordini di una certa data.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce gli ordini di una certa data | `ArOrdineJSON` |
| `DEL` | - | Cancella gli ordini di una certa data | `Response` |


### /ordine/oggi -> `ArOrdineJSON`
Restituisce gli ordini della data odierna.
Una scorciatoia per: `/ordine/data/{datacorrente}`


### /ordine/da/{data}/a/{data} -> `ArOrdineJSON`

Gestisce gli ordini di una certo intervallo di date.

|   Verbi       | Arg | Descrizione | Response |
| ------------- |-----|-------------|---------:|
| `GET` | - | Restituisce gli ordini di un certo intervallo di date | `ArOrdineJSON` |
| `DEL` | - | Cancella gli ordini di questo intervallo | `Response` |


/utente/:id
/utente/:telefono
/utente/?/ordini

/ordine/ritiro
