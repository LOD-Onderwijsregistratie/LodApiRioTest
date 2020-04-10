#language:nl

Functionaliteit: Examenlicenties obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/examenlicenties/{id}'

  Scenario: 1. Opvragen examenlicentie obv id
    Als gezocht wordt op pathparam 'id' met waarde '30PK-0473'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.begindatum=='2018-08-01')]' de volgende inhoud
      | stadium    | "STANDAARD"                                                          |
      | einddatum  | null                                                                 |
      | uri        | "http://lod.onderwijsregistratie.nl/rio/id/Examenlicentie/30PK-0473" |
      | begindatum | "2018-08-01"                                                         |
    En bevat de jsonpath '_links.self' de waarde '/examenlicenties/30PK-0473'
    En bevat de jsonpath '_links.onderwijsinstellingserkenning' de waarde 'onderwijsinstellingserkenningen?examenlicentie=30PK-0473'
    En bevat de jsonpath '_links.mboOpleidingserkenning' de waarde 'mbo-opleidingserkenningen?examenlicentie=30PK-0473'