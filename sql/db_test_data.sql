
use starcup22;

-- -----------------------------------
-- Inserisce Don Simone - Persona 1
-- -----------------------------------
INSERT INTO `Persona` (
  `IdPersona`, `Nome`, `Cognome`, `Sesso`,
  `LuogoNascita`, `DataNascita`,
  `Indirizzo`, `Email`,
  `Foto`, `Documento`,
  `Telefono`,
  `CodFiscale`,
  `Città`, `Provincia`, `CAP`,
  `Patentino`
) VALUES (
    1, "Simone", "Pascarosa", "m", "Perugia", "1984-11-24",
    "Via della Concordia, 42", "simone.pascarosa@gmail.com",
    "", "", "3493731005", "PSCSMN84S24G478G",
    "Perugia", "PG", "06124", ""
);

-- -----------------------------------
-- Inserisce David Fiorini - Persona 2
-- -----------------------------------
INSERT INTO `Persona` (
  `IdPersona`, `Nome`, `Cognome`, `Sesso`,
  `LuogoNascita`, `DataNascita`,
  `Indirizzo`, `Email`,
  `Foto`, `Documento`,
  `Telefono`,
  `CodFiscale`,
  `Città`, `Provincia`, `CAP`,
  `Patentino`
) VALUES (
    2, "David", "Fiorini", "m", "Perugia", "2000-01-01",
    "A san sisto", "fiorinidavid99@gmail.com",
    "", "", "3333333333", "FRNXXX",
    "Perugia", "PG", "06132", ""
);


-- -----------------------------------
-- Inserisce Daniele - Persona 3
-- -----------------------------------
INSERT INTO `Persona` (
  `IdPersona`, `Nome`, `Cognome`, `Sesso`,
  `LuogoNascita`, `DataNascita`,
  `Indirizzo`, `Email`,
  `Foto`, `Documento`,
  `Telefono`,
  `CodFiscale`,
  `Città`, `Provincia`, `CAP`,
  `Patentino`
) VALUES (
    3, "Daniele", "Nucciarelli", "m", "Perugia", "2001-01-01",
    "A san sisto", "thenucciasfourth@gmail.com",
    "", "", "3333333333", "FRNXXX",
    "Perugia", "PG", "06132", ""
);

-- -----------------------------------
-- Inserisce Emanuele - Persona 4
-- -----------------------------------
INSERT INTO `Persona` (
  `IdPersona`, `Nome`, `Cognome`, `Sesso`,
  `LuogoNascita`, `DataNascita`,
  `Indirizzo`, `Email`,
  `Foto`, `Documento`,
  `Telefono`,
  `CodFiscale`,
  `Città`, `Provincia`, `CAP`,
  `Patentino`
) VALUES (
    4, "Emanuele", "Persichini", "m", "Perugia", "2001-02-01",
    "A san sisto", "persichini.emanuele@gmail.com",
    "", "", "3333333333", "FRNXXX",
    "Perugia", "PG", "06132", ""
);


-- -----------------------------------
-- Inserisce GIOCATORI CASUALI
-- -----------------------------------
INSERT INTO `Persona` (
  `IdPersona`, `Nome`, `Cognome`, `Sesso`,
  `LuogoNascita`, `DataNascita`,
  `Indirizzo`, `Email`,
  `Foto`, `Documento`,
  `Telefono`,
  `CodFiscale`,
  `Città`, `Provincia`, `CAP`,
  `Patentino`
) VALUES (
    5, "Giocatore 1", "Rossi", "m", "Perugia", "2001-02-01",
    "A san sisto", "persichini.emanuele@gmail.com",
    "", "", "3333333333", "FRNXXX",
    "Perugia", "PG", "06132", ""
);

-- -----------------------------------
-- Inserisce GIOCATORI CASUALI
-- -----------------------------------
INSERT INTO `Persona` (
  `IdPersona`, `Nome`, `Cognome`, `Sesso`,
  `LuogoNascita`, `DataNascita`,
  `Indirizzo`, `Email`,
  `Foto`, `Documento`,
  `Telefono`,
  `CodFiscale`,
  `Città`, `Provincia`, `CAP`,
  `Patentino`
) VALUES (
    6, "Giocatore2", "BIanchi", "m", "Perugia", "2001-02-01",
    "A san sisto", "persichini.emanuele@gmail.com",
    "", "", "3333333333", "FRNXXX",
    "Perugia", "PG", "06132", ""
);




-- -----------------------------------
-- Inserisce Don Simone come arbitro
-- -----------------------------------
INSERT INTO `Arbitro` (
    `IdArbitro`, `CodPersona`
) VALUES (
    1, 1
);

-- -----------------------------------
-- Inserisci i gruppi parrocchiali
-- -----------------------------------
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (1,'Non presente in lista',0,0);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (2,'Gruppo diocesano',1,0);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (3,'UP22 - Ponte Valleceppi, Sant\'Egidio',22,4);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (4,'UP21 - Ponte Pattoli, Pierantonio',21,4);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (5,'UP20 - Colombella, Piccione, Ramazzano',20,4);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (6,'UP19 - Ponte Felcino',19,4);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (7,'UP18 - San Martino in Colle, San Martino in C',18,3);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (8,'UP17 - San Fortunato della Collina',17,3);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (9,'UP16 - Deruta, San Nicolò di Celle',16,3);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (10,'UP15 - Torgiano',15,3);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (11,'UP14 - Ponte San Giovanni, Collestrada',14,3);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (12,'UP13 - Ferro di Cavallo',13,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (13,'UP12 - San Mariano, Solomeo',12,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (14,'UP11 - Cenerente',11,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (15,'UP10 - Olmo, Corciano ',10,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (16,'UP9 - Pila, Castel del Piano',9,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (17,'UP8 - San Sisto, Lacugnano',8,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (18,'UP7 - Elce, Case Bruciate',7,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (19,'UP6 - Monteluce, Casaglia',6,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (20,'UP5 - Santa Lucia, San Marco, Ponte d\'oddi',5,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (21,'UP4 - Prepo, Settevalli',4,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (22,'UP3 - Madonna Alta',3,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (23,'UP2 - San Biagio, Santo Spirito',2,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (24,'UP1 - Perugia Centro',1,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (25,'UP32 - Panicarola, Macchie, Sant\'Arcangelo',32,7);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (26,'Oratorio Sentinelle del mattino - San Sisto',8,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (27,'Oratorio Pingo \'Preferisco il Paradiso\' - Cas',7,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (28,'Oratori riuniti \'Giampiero Morettini\'',18,3);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (29,'Oratorio Piergiorgio Frassati \'State buoni se',9,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (30,'Oratorio L\'astrolabio - Ponte d\'Oddi',5,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (31,'Oratorio Giovanni Paolo II - Prepo',4,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (32,'Oratorio Don Dario Pasquini - Olmo',10,2);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (33,'Oratorio OSMA - Marsciano',23,5);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (34,'Oratorio San Barnaba',3,1);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (35,'UP23 - Marsciano',23,5);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (36,'UP24 - Tavernelle, Panicale, Pietrafitta',24,5);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (37,'UP25 - Fontignano, Mugnano, Agello',25,5);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (38,'UP26 - Papiano, Cerqueto, Spina, Castiglione ',26,5);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (39,'UP27 - Magione, San Feliciano',27,6);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (40,'UP28 - Passignano, Tuoro',28,6);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (41,'UP29 - Castel Rigone, Preggio',29,6);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (42,'UP30 - Città della Pieve, Monteleone',30,7);
INSERT INTO `Gruppo` (`IdGruppo`,`Denominazione`,`UP`,`ZP`) VALUES (43,'UP31 - Castiglione del Lago',31,7);


-- -----------------------------------
-- Inserisci 3 campi di gioco
-- -----------------------------------
INSERT INTO `Campo` (`IdCampo`,`Denominazione`,`Foto`) VALUES (1, 'Campo 1', '');
INSERT INTO `Campo` (`IdCampo`,`Denominazione`,`Foto`) VALUES (2, 'Campo 2', '');
INSERT INTO `Campo` (`IdCampo`,`Denominazione`,`Foto`) VALUES (3, 'Campo 3', '');



-- -----------------------------------
-- Inserisci i 3 ruoli previsti: Referente, Allenatore e Giocatore
-- -----------------------------------
INSERT INTO `Ruolo` (`IdRuolo`,`Descrizione`) VALUES (1,'Referente');
INSERT INTO `Ruolo` (`IdRuolo`,`Descrizione`) VALUES (2,'Allenatore');
INSERT INTO `Ruolo` (`IdRuolo`,`Descrizione`) VALUES (3,'Giocatore');


-- -----------------------------------
-- Inserisco i tornei di qualificazione m e f e le starcup e argiocup
-- -----------------------------------
INSERT INTO `Torneo` (`IdTorneo`,`NomeTorneo`,`Tipologia`,`Fase`,`Stemma`,`ColoreRGB`) 
    VALUES (1,'Fasi preliminari Maschili','M','Gir',NULL,NULL);

INSERT INTO `Torneo` (`IdTorneo`,`NomeTorneo`,`Tipologia`,`Fase`,`Stemma`,`ColoreRGB`) 
    VALUES (2,'Fasi preliminari Femminili','F','Gir',NULL,NULL);

INSERT INTO `Torneo` (`IdTorneo`,`NomeTorneo`,`Tipologia`,`Fase`,`Stemma`,`ColoreRGB`) 
    VALUES (3,'Starcup Maschile','M','Eli',NULL,NULL);

INSERT INTO `Torneo` (`IdTorneo`,`NomeTorneo`,`Tipologia`,`Fase`,`Stemma`,`ColoreRGB`) 
    VALUES (4,'Starcup Femminile','F', 'Eli',NULL,NULL);

INSERT INTO `Torneo` (`IdTorneo`,`NomeTorneo`,`Tipologia`,`Fase`,`Stemma`,`ColoreRGB`) 
    VALUES (5,'Argiocup Maschile','M','Eli',NULL,NULL);

INSERT INTO `Torneo` (`IdTorneo`,`NomeTorneo`,`Tipologia`,`Fase`,`Stemma`,`ColoreRGB`) 
    VALUES (6,'Argiocup Femminile','F', 'Eli',NULL,NULL);



-- -----------------------------------
-- Inserisco l'unico utente per il sistema
-- -----------------------------------
-- Simone Pascarosa, parroco, Utente approvato per il GRuppo 29
INSERT INTO `Utente` (`IdUtente`,`CodPersona`,`Incarico`,`NomeUtente`,`Password`,`CodGruppo`,`Amministratore`,`Approvato`) 
    VALUES (1,1,'Parroco', 'simone.pascarosa', 's1m0n3', 29, 1, 1);



-- -----------------------------------
-- Inserisco le squadre
-- -----------------------------------

-- Fusion, F, 29, Oratorio Piergiorgio Frassati
INSERT INTO `Squadra` (`IdSquadra`,`NomeSquadra`,`Tipologia`,`CodGruppo`,`CodUtente`,`Stemma`,`CodiceSquadra`,`NomeParroco`,`CognomeParroco`,`TelefonoParroco`,`Note`,`ColoreDivise`) 
    VALUES (1, "Fusion",'F', 29, 1, NULL, "FUS", "Prete","Cattolico","3337771234",NULL,NULL);

-- Shalke104, M, 29, Oratorio Piergiorgio Frassati
INSERT INTO `Squadra` (`IdSquadra`,`NomeSquadra`,`Tipologia`,`CodGruppo`,`CodUtente`,`Stemma`,`CodiceSquadra`,`NomeParroco`,`CognomeParroco`,`TelefonoParroco`,`Note`,`ColoreDivise`) 
    VALUES (2, "Shalke 104",'M', 29, 1, NULL, "SHA", "Prete","Cattolico","3337771234",NULL,NULL);

-- San Sisters, F, 26, ORatorio Sentinelle mattino
INSERT INTO `Squadra` (`IdSquadra`,`NomeSquadra`,`Tipologia`,`CodGruppo`,`CodUtente`,`Stemma`,`CodiceSquadra`,`NomeParroco`,`CognomeParroco`,`TelefonoParroco`,`Note`,`ColoreDivise`) 
    VALUES (3, "San Sisters",'F', 26, 1, NULL, "SAN", "Prete","Cattolico","3337771234",NULL,NULL);

-- Sisto blacks, M, 26, ORatorio Sentinelle mattino
INSERT INTO `Squadra` (`IdSquadra`,`NomeSquadra`,`Tipologia`,`CodGruppo`,`CodUtente`,`Stemma`,`CodiceSquadra`,`NomeParroco`,`CognomeParroco`,`TelefonoParroco`,`Note`,`ColoreDivise`) 
    VALUES (4, "Sisto Blacks",'M', 26, 1, NULL, "SIS", "Prete","Cattolico","3337771234",NULL,NULL);

-- All Blacks, M, 24, Monteluce
INSERT INTO `Squadra` (`IdSquadra`,`NomeSquadra`,`Tipologia`,`CodGruppo`,`CodUtente`,`Stemma`,`CodiceSquadra`,`NomeParroco`,`CognomeParroco`,`TelefonoParroco`,`Note`,`ColoreDivise`) 
    VALUES (5, "All Blacks",'M', 24, 1, NULL, "ALL", "Prete","Cattolico","3337771234",NULL,NULL);

-- Ciambelle, F, 23, San Biagio e Savino
INSERT INTO `Squadra` (`IdSquadra`,`NomeSquadra`,`Tipologia`,`CodGruppo`,`CodUtente`,`Stemma`,`CodiceSquadra`,`NomeParroco`,`CognomeParroco`,`TelefonoParroco`,`Note`,`ColoreDivise`) 
    VALUES (6, "Ciambelle",'F', 23, 1, NULL, "CIA", "Prete","Cattolico","3337771234",NULL,NULL);



-- -----------------------------------
-- Inserisco i ruoli per i giocatori
-- -----------------------------------
-- Inserisce i 2 giocatori della squadra 1
INSERT INTO `RuoloInSquadra` (`IdRuoloInSquadra`,`CodPersona`,`CodSquadra`,`CodRuolo`) 
    VALUES (1,5,1,3);

INSERT INTO `RuoloInSquadra` (`IdRuoloInSquadra`,`CodPersona`,`CodSquadra`,`CodRuolo`) 
    VALUES (2,6,1,3);


-- -----------------------------------
-- Inserisci alcune posizioni nel torneo
-- -----------------------------------
-- Fase Qualif Girone A maschile - Shalke104, Sisto Blacks, All Blacks
INSERT INTO `Posizione` (`IdPosizione`,`CodTorneo`,`CodSquadra`,`GironePosizione`) 
    VALUES (1,1,2,'A');
INSERT INTO `Posizione` (`IdPosizione`,`CodTorneo`,`CodSquadra`,`GironePosizione`) 
    VALUES (2,1,4,'A');
INSERT INTO `Posizione` (`IdPosizione`,`CodTorneo`,`CodSquadra`,`GironePosizione`) 
    VALUES (3,1,5,'A');

-- Fase Qualif Girone A femminile - Shalke104, Sisto Blacks, All Blacks
INSERT INTO `Posizione` (`IdPosizione`,`CodTorneo`,`CodSquadra`,`GironePosizione`) 
    VALUES (4,2,1,'A');
INSERT INTO `Posizione` (`IdPosizione`,`CodTorneo`,`CodSquadra`,`GironePosizione`) 
    VALUES (5,2,3,'A');
INSERT INTO `Posizione` (`IdPosizione`,`CodTorneo`,`CodSquadra`,`GironePosizione`) 
    VALUES (6,2,6,'A');


-- ------------------------------------
-- Inserisci alcune partite con punteggio (goal e bonus/malus)
-- ------------------------------------

-- Partita Shalke VS Sisto Blacks 4 - 1 
INSERT INTO `Partita` (`IdPartita`,`CodSquadra1`,`CodSquadra2`,`Stato`,`CodTorneo`,`Posizione`,`BonusMalus1`,`BonusMalus2`) 
    VALUES (1,2,4,'fin',1,'A',4,1);

-- Partita Shalke VS All Blacks 2 - 0 
INSERT INTO `Partita` (`IdPartita`,`CodSquadra1`,`CodSquadra2`,`Stato`,`CodTorneo`,`Posizione`,`BonusMalus1`,`BonusMalus2`) 
    VALUES (2,2,5,'fin',1,'A',2,0);


