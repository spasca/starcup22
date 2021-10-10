import json

"""
#esempio di utilizzo:
listina=[]
CalcolaCF("Daniele","Nucciarelli",1997,1,25,"M", "Perugia",listina)   
#in "listina" ora ci sono gli 8 codici fiscali possibili

#algoritmo basato sul D.M. n° 345 del 23/12/1976 (Articolo 7)
#https://www.studioaleo.it/struttura-codice-fiscale.html
"""
FILENAME="comuni_e_nazioni.json" 
"""nome del file con codici catastali di comuni italiani e stati esteri. Deve essere un json del tipo:
[
  {
    "nome":"Perugia",
    "codiceCatastale":"G478"
  },
  {
    "nome":"Albania",
    "codiceCatastale":"Z100"
  }
  {
    ...
  }
]

"""
#utility di conversione
vocali="AEIOU"
consonanti="BCDFGHJKLMNPQRSTVWXYZ "

MonthDict={1:"A",2:"B",3:"C",4:"D",5:"E",6:"H",7:"L",8:"M",9:"P",10:"R",11:"S",12:"T"}

EvenLetterConvert={
    "A":0,"B":1,"C":2,"D":3,"E":4,"F":5,"G":6,"H":7,
    "I":8,"J":9,"K":10,"L":11,"M":12,"N":13,"O":14,"P":15,"Q":16,
    "R":17,"S":18,"T":19,"U":20,"V":21,"W":22,"X":23,"Y":24,"Z":25
}
OddNumberConvert={
    "1":0,"2":5,"3":7,"4":9,"5":13,"6":15,"7":17,"8":19,"9":21,"0":1
}
OddLetterConvert={
    "A":1,"B":0,"C":5,"D":7,"E":9,"F":13,"G":15,"H":17,
    "I":19,"J":21,"K":2,"L":4,"M":18,"N":20,"O":11,"P":3,"Q":6,
    "R":8,"S":12,"T":14,"U":16,"V":10,"W":22,"X":25,"Y":24,"Z":23  
}
OmocodiaConvert={
    "0":"L","5":"R","1":"M","6":"S","2":"N","7":"T","3":"P","8":"U","4":"Q","9":"V"
}
ControlCharConvert={   
    0:"A",1:"B",2:"C",3:"D",4:"E",5:"F",6:"G",7:"H",
    8:"I",9:"J",10:"K",11:"L",12:"M",13:"N",14:"O",15:"P",16:"Q",
    17:"R",18:"S",19:"T",20:"U",21:"V",22:"W",23:"X",24:"Y",25:"Z" 
}

def CalcolaCF(Nome, Cognome, AnnoDiNascita, MeseDiNascita,
              GiornoDiNascita, Sesso, ComuneDiNascita, ListCF):
    """Calcola gli otto possibili CF associati a una persona fisica, considerando l'omocodia.
    Nome,Cognome, Sesso e ComuneDiNascita devono essere stringhe
        !!! nel caso in cui si è nati fuori Italia comunicare lo Stato di Nascita 
            al posto della variabile ComuneDiNascita 
    AnnoDiNascita, MeseDiNascita, GiornoDiNascitadevono essere interi

    ListCF è la lista che verrà riempita di tutti i possibili CF    """

    worklist=[]
    PrimeQuindici = QuindiciCF(Nome, Cognome, AnnoDiNascita, MeseDiNascita,
                               GiornoDiNascita, Sesso, ComuneDiNascita)
    Sette = OttoAlternative(PrimeQuindici,worklist)
    
    for tempCF in worklist:
        CF = tempCF + CharDiControllo(tempCF)
        #print(CF)
        ListCF.append(CF)

def CharDiControllo(PrimeQuindici):
    """Calcola il carattere di controllo, ovvero il sedicesimo e ultimo carattere del CF
    PrimeQuindici sono i primi quindici caratteri sotto forma di stringa
    
    ritorna il carattere di controllo sotto forma di stringa"""
    
    Somma=0
    Count=1

    for cifra in PrimeQuindici:
        if Count%2==0:
            if cifra.isdigit():
                Somma+=int(cifra)
            else:
                Somma+=EvenLetterConvert[cifra]
        else:
            if cifra.isdigit():
                Somma+=OddNumberConvert[cifra]
            else:
                Somma+=OddLetterConvert[cifra]
        Count+=1
    ControlChar = ControlCharConvert[Somma % 26]

    return ControlChar
   
def OttoAlternative(PrimeQuindici, worklist):
    """Trasforma i primi 15 caratteri (sotto forma di stringa) 
    in una lista (worklist) di otto codici che tengono conto dell'omocodia

    non ritorna nulla"""

    NumberPosition=[14,13,12,10,9,7,6]

    #no omocodia:
    worklist.append(PrimeQuindici)
    #omocodia:
    for i in NumberPosition:
        PrimeQuindici = PrimeQuindici[:i] + OmocodiaConvert[PrimeQuindici[i]] + PrimeQuindici[i+1:]
        worklist.append(PrimeQuindici)

def QuindiciCF(Nome, Cognome, AnnoDiNascita, MeseDiNascita,
               GiornoDiNascita, Sesso, ComuneDiNascita):
    """calcola i primi quindici caratteri del CF.
    Nome,Cognome, Sesso e ComuneDiNascita devono essere stringhe
        !!! nel caso in cui si è nati fuori Italia comunicare lo Stato di Nascita 
            al posto della variabile ComuneDiNascita 
    AnnoDiNascita, MeseDiNascita, GiornoDiNascitadevono essere interi

    ritorna i primi 15 caratteri del CF sotto forma di stringa"""

    NomeFiscale=""
    Nome=Nome.upper()
    ConsonantiNome = Nome.translate(str.maketrans(vocali,"     ")).replace(" ","") #rimuove le vocali
    VocaliNome = Nome.translate(str.maketrans(consonanti,"                      ")).replace(" ","") #rimuove le consonanti
    if len(ConsonantiNome) <= 3:
        NomeFiscale = (ConsonantiNome + VocaliNome)[0:3]
    else:
        NomeFiscale = ConsonantiNome[0] + ConsonantiNome[2:4]
    NomeFiscale = NomeFiscale + (max(0,(3-len(NomeFiscale)))*"X")
        
    Cognome=Cognome.upper()
    ConsonantiCognome = Cognome.translate(str.maketrans(vocali,"     ")).replace(" ","")
    VocaliCognome = Cognome.translate(str.maketrans("                      ",consonanti)).replace(" ","")
    CognomeFiscale = (ConsonantiCognome + VocaliCognome)[0:3]
    CognomeFiscale = CognomeFiscale + (max(0,(3-len(CognomeFiscale)))*"X")

    Sex = 40 if Sesso == "F" else 0

    CodiceCatastale=""
    Comuni=json.load(open(FILENAME,"r"))
    for comune in Comuni:
        if ComuneDiNascita.upper() == comune["nome"].upper():
            CodiceCatastale=comune["codiceCatastale"]

    firstCF=CognomeFiscale+NomeFiscale+str(AnnoDiNascita)[-2:]+MonthDict[MeseDiNascita]+str(GiornoDiNascita+Sex)+CodiceCatastale

    return firstCF
