import json
from Model import Array, Model
from codice_fiscale.dizionari import *

class Persona(Model):
    # Build a single Persona resource from the data 
    # of a single SQL query result.
    # dict_data: a dictionary with the query data in the format field: value

    CodiciFiscaliValidi = [] #lista con otto codici fiscali validi. Si riempe con self.CalcolaCF()

    def __init__(self, dict_data):
        
        # Check and assign the values of the current entry in the query
        for k, v in dict_data.items():
            if   k.lower() == "idpersona":     self.IdPersona = v
            elif k.lower() == "nome":          self.Nome = v
            elif k.lower() == "cognome":       self.Cognome = v
            elif k.lower() == "sesso":         self.Sesso = v
            elif k.lower() == "luogonascita":  self.LuogoNascita = v
            elif k.lower() == "datanascita":   self.DataNascita = v
            elif k.lower() == "indirizzo":     self.Indirizzo = v
            elif k.lower() == "email":         self.Email = v
            elif k.lower() == "foto":          self.Foto = v
            elif k.lower() == "documento":     self.Documento = v
            elif k.lower() == "telefono":      self.Telefono = v
            elif k.lower() == "codfiscale":    self.CodFiscale = v
            elif k.lower() == "città":         self.Città = v
            elif k.lower() == "provincia":     self.Provincia = v
            elif k.lower() == "cap":           self.CAP = v
            elif k.lower() == "patentino":     self.Patentino = v 

        aaaa_mm_gg = self.DataNascita.split("-")
        self.AnnoNascita   = aaaa_mm_gg[0]
        self.MeseNascita   = aaaa_mm_gg[1]
        self.GiornoNascita = aaaa_mm_gg[2]
            
    def CalcolaCF(self):
        """Calcola gli otto possibili CF associati a una persona fisica, considerando l'omocodia.
        algoritmo basato sul D.M. n° 345 del 23/12/1976 (Articolo 7)
        https://www.studioaleo.it/struttura-codice-fiscale.html
            
        gli otto CF verranno appesi alla lista self.CodiciFiscaliValidi 
        """
        for un_possibile_CF in self.OttoAlternative():
            CF = un_possibile_CF + self.CharDiControllo(un_possibile_CF)
            self.CodiciFiscaliValidi.append(CF)

    def PrimeQuindiciCifreCF(self):
        """FUNZIONE DI LAVORO PER self.CalcolaCF()
        ritorna i primi 15 caratteri del CF sotto forma di stringa"""

        NomeFiscale=""
        Nome = self.Nome.upper()
            
        ConsonantiNome = "".join([c for c in Nome if c in consonanti])
        VocaliNome     = "".join([v for v in Nome if v in vocali    ])

        if len(ConsonantiNome) <= 3:
            NomeFiscale = (ConsonantiNome + VocaliNome)[0:3]
        else:
            NomeFiscale = ConsonantiNome[0] + ConsonantiNome[2:4]
        NomeFiscale = NomeFiscale + (max(0,(3-len(NomeFiscale)))*"X")
        
        Cognome=self.Cognome.upper()
            
        ConsonantiCognome = "".join([c for c in Cognome if c in consonanti])
        VocaliCognome     = "".join([v for v in Cognome if v in vocali    ])
    
        CognomeFiscale = (ConsonantiCognome + VocaliCognome)[0:3]
        CognomeFiscale = CognomeFiscale + (max(0,(3-len(CognomeFiscale)))*"X")

        Sex = 40 if self.Sesso == "F" else 0

        CodiceCatastale=""
        Luoghi=json.load(open(FILENAME,"r"))
        for luogo in Luoghi:
            if self.LuogoNascita.upper() == luogo["nome"].upper():
                CodiceCatastale = luogo["codiceCatastale"]
                break
            #raise error

        firstCF = (CognomeFiscale +
                   NomeFiscale +
                   str(self.AnnoNascita)[-2:] +
                   MonthDict[self.MeseNascita] +
                   str(int(self.GiornoNascita)+Sex) +
                   CodiceCatastale
                   )
            
        return firstCF

    def CharDiControllo(self,PrimeQuindiciCifre):
        """FUNZIONE DI LAVORO PER self.CalcolaCF()
        Calcola il carattere di controllo, ovvero il sedicesimo e ultimo carattere del CF
            PrimeQuindiciCifre : i primi quindici caratteri sotto forma di stringa 
            ritorna il carattere di controllo sotto forma di stringa
        """
    
        Somma=0
        Count=1

        for cifra in PrimeQuindiciCifre:
            if Count%2 == 0:
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

    def OttoAlternative(self):
        """FUNZIONE DI LAVORO PER self.CalcolaCF()
        Trasforma i primi 15 caratteri (sotto forma di stringa) 
        in una lista (worklist) di otto codici che tengono conto dell'omocodia
        """
        
        worklist=[]
        PrimeQuindiciCifre=self.PrimeQuindiciCifreCF()
        NumberPosition=[14,13,12,10,9,7,6]

        #no omocodia:
        worklist.append(PrimeQuindiciCifre)

        #omocodia:
        for i in NumberPosition:
            PrimeQuindiciCifre = ( PrimeQuindiciCifre[:i] +
                                   OmocodiaConvert[PrimeQuindiciCifre[i]] +
                                   PrimeQuindiciCifre[i+1:])
            worklist.append( PrimeQuindiciCifre )

        return worklist

"""
#proviamolo
dict_data={
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
    "codfiscale":"lo scopriremo!",
    "città":"Perugia",
    "provincia":"Perugia",
    "cap":"06132",
    "patentino":"che è sta roba"
}

Pasca=Persona(dict_data)
Pasca.CalcolaCF()
print(Pasca.CodiciFiscaliValidi)
"""
