#language:nl

Functionaliteit: BevoegdGezagErkenning obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen/{id}'

  Scenario: 1. BevoegdGezagErkenning opvragen 1 resultaat (met als id bevoegdGezagNummer)
    Als gezocht wordt op pathparam 'id' met waarde '24597'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.nummer=='24597')]' de volgende inhoud
      | verkorteNaam     | "Stichting R'damse Ver. v. K.O."                                        |
      | volledigeNaam    | "Stichting Rotterdamse Verenig. van K.O."                               |
      | bekostigingscode | "NIET_VAN_TOEPASSING"                                                   |
      | startdatum       | "1973-09-01"                                                            |
      | wet              | null                                                                    |
      | einddatum        | null                                                                    |
      | richtingen       | [ ]                                                                     |
      | uri              | "http://lod.onderwijsregistratie.nl/rio/id/BevoegdGezagErkenning/24597" |
      | nummer           | "24597"                                                                 |
      | soort            | "BINS"                                                                  |
      | ingangsdatum     | "1973-09-01"                                                            |
    En bevat de jsonpath '_links.self' de waarde '/bevoegd-gezag-erkenningen/24597'
    En bevat de jsonpath '_links.onderwijsinstellingserkenning' de waarde 'onderwijsinstellingserkenningen?bevoegdGezagErkenning=24597'
    En bevat de jsonpath '_links.onderwijsbestuur' de waarde 'onderwijsbesturen?bevoegdGezagErkenning=24597'

  Scenario: 2. BevoegdGezagErkenning komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen/{id}?datumGeldigOp=1010-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '24597'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug