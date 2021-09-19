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


# Strutture dati

###  Esempio preso da un vecchio prodotto ProdottoJSON
L'anagrafica di un singolo prodotto.
Contiene:
- `integer` *id*: il codice del prodotto nel db
- `string` *nome*: il nome del prodotto corrente
- `string` *descrizione*: descrizione del prodotto
- `string/url` *immagine*: indirizzo dell'immagine
- `string` *tipomerceologico*: il tipo merceologico del prodotto

Esempio
```json
{
  "id":1,
  "nome":"Tonno in scatola",
  "descrizione":"Tonno di mare inscatolato",
  "immagine": "http://server/pics/tonno.jpg",
  "tipomerceologico":"alimenti conservati"
}
```

### ProdottoInBoxJSON -> estende `ProdottoJSON`
Un prodotto in un box. 

Oltre ai dati di `ProdottoJSON` contiene:
- `string` *unitamisura*: unità di misura usata
- `integer` *quantita*: valore della quantità in base all'unità di misura
***DARIO: questa quantità forse deve essere float ... no?!?!***

Esempio:
```json
{
  "id":1,
  "nome":"Tonno in scatola",
  "descrizione":"Tonno di mare inscatolato",
  "immagine": "http://server/pics/tonno.jpg",
  "tipomerceologico":"alimenti conservati",
  "unitamisura": "grammi",
  "quantita": 500
}
```

### ArProdottoJSON -> contiene molti `ProdottoJSON`
L'anagrafica di una pluralità di prodotti. Semplicemente un array di `ProdottoJSON`.

Esempio:
```json
{
  [
    {
      "id":1,
      "nome":"Tonno in scatola",
      "descrizione":"Tonno di mare inscatolato",
      "immagine": "http://server/pics/tonno.jpg",
      "tipomerceologico":"alimenti conservati"
    },
    {
      "id":2,
      "nome":"Pasta corta",
      "descrizione":"Penne, farfalla o altra pasta corta",
      "immagine": "http://server/pics/pastacorta.jpg",
      "tipomerceologico":"Paste alimentari"
    }
}
```


## Utente

Le strutture dati che servono per interrogare e modificare gli utenti che usufruiscono di SpesaFatta.

### UtenteJSON
L'anagrafica di un utente inserito nel sistema.
Contiene:
- `integer` *id*: il codice dell'utente nel DB
- `integer` *stato*: identificativo dello stato di registrazione ***serve?!***
- `string` *nome*: nome dell'utente
- `string` *cognome*: cognome dell'utente
- `string` *telefono*: telefono dell'utente
- `NegozioJSON` *negoziopreferito*: negozio preferito dell'utente (se c'è, senn)
- `string` *cap*: codice di avviamento postale
- `bit` *privacy*: vero o falso se ha rilasciato i permessi
- `string` *username*: dell'utente nel sistema
- `binary(64)` *password*: hash della password dell'utente

Esempio
```json
{
  "id":1,
  "stato": 2,
  "nome":"Simone",
  "cognome":"Pascarosa",
  "telefono": "12345667",
  "negozio": 
    {
      "id":1,
      "tiponegozio":"Supermercato",
      "denominazione":"Gaggi",
      "indirizzo": "Via Ruggero d'Andreotto, 19 - 06121 Perugia",
      "lat": 43.111613,
      "long": 12.377809,
      "nomereferente": "Vitaliano Gaggi",
      "telefonoreferente": "075347389514832",
      "emailreferente": "vitaliano@gaggi.it",
      "cap": "06121"
    },
  "cap": "06124",
  "privacy": true,
  "username": "simone.pascarosa",
  "password": "8349dj2f4vjg4gcvrecfwd@#"  
}
```



## Ordine

Le strutture dati che servono per interrogare e modificare gli ordini

### OrdineJSON
L'anagrafica di un singolo box generico.

Contiene:
- `integer` *id*: il codice dell'ordine, come registrato nel DB
- `UtenteJSON` *utente*: l'utente che ha effettuato l'ordine
- `NegozioJSON` *negozio*: il negozio in cui l'ordine è effettuato
- `integer` *stato*: stato dell'ordine ( ***definire gli stati e i codici!*** )
- `datetime` *dataordine*: nome del box con cui è conosciuto
- `datetime` *dataritiro*: nome del box con cui è conosciuto
- `datetime` *datafineritiro*: nome del box con cui è conosciuto
- `string` *codiceritiro*: codice con cui l'utente può ritirare l'ordine 
- `string` *note*: note eventuali per l'ordine
- `ArBoxInOrdineJSON` *boxes*: i box ordinati

Esempio
```json
{
  "id":1,
  "utente":
    {
	  "id":1,
	  "stato": 2,
	  "nome":"Simone",
	  "cognome":"Pascarosa",
	    ...
	},
  "negozio": 
    {
      "id":1,
      "tiponegozio":"Supermercato",
      "denominazione":"Gaggi",
        ...
    },
  "stato": 2,
  "dataordine": "2020-04-17 18:05:23",
  "dataritiro": "2020-04-18 08:00:00",
  "dataordine": "2020-04-21 20:00:00",
  "codiceritiro": "BO324L",
  "note": "",
  "boxes": 
    [
		...
    ]
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
