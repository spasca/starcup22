#variabili di lavoro per il metodo Persona::CalcolaCF()

FILENAME="codice_fiscale/comuni_e_nazioni.json" 
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

il path è relativo alla posizione di Persona.py

"""
vocali="AEIOU"

consonanti="BCDFGHJKLMNPQRSTVWXYZ "

MonthDict={"1":"A","2":"B","3":"C","4":"D","5":"E","6":"H","7":"L","8":"M",
           "9":"P","10":"R","11":"S","12":"T"}

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
