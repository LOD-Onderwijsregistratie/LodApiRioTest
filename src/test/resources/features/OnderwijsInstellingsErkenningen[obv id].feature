#language:nl

Functionaliteit: Opvragen OnderwijsInstellingserkenningen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen/{id}'

  Scenario: 1. OnderwijsInstellingsErkenning opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '31EW'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.bRIN4=='31EW')]' de volgende inhoud
      | verkorteNaam     | "\'s Gravendreef College"                                                           |
      | volledigeNaam    | "\'s Gravendreef College voor vbo, mavo en havo"                                              |
      | bRIN4            | "31EW"                                                                         |
      | bekostigingscode | "BEKOSTIGD"                                                                    |
      | startdatum       | "2017-08-01"                                                                   |
      | wet              | "WVO"                                                                          |
      | einddatum        | null                                                                           |
      | richtingen       | ["RK", "PC"]                                                                             |
      | uri              | "http://lod.onderwijsregistratie.nl/rio/id/Onderwijsinstellingserkenning/31EW" |
      | soort            | "VOS"                                                                          |
      | ingangsdatum     | "2017-08-01"                                                                   |
    En bevat de jsonpath '_links.self' de waarde '/onderwijsinstellingserkenningen/31EW'
    En bevat de jsonpath '_links.onderwijsaanbieder' de waarde 'onderwijsaanbieders?onderwijsinstellingserkenning=31EW'
    En bevat de jsonpath '_links.mboOnderwijslicentie' de waarde 'mbo-onderwijslicenties?onderwijsinstellingserkenning=31EW'
    En bevat de jsonpath '_links.examenlicentie' de waarde 'examenlicenties?onderwijsinstellingserkenning=31EW'
    En bevat de jsonpath '_links.vavoOnderwijslicentie' de waarde 'vavo-onderwijslicenties?onderwijsinstellingserkenning=31EW'
    En bevat de jsonpath '_links.bevoegdGezagErkenning' de waarde 'bevoegd-gezag-erkenningen?onderwijsinstellingserkenning=31EW'


  Scenario: 2.  Onderwijsinstellingserkenning komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen/{id}?datumGeldigOp=1974-07-01'
    Als gezocht wordt op pathparam 'id' met waarde '31EW'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug