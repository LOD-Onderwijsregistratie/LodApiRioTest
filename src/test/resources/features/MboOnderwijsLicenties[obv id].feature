#language:nl

Functionaliteit: Mbo Onderwijslicenties obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties/{id}'

  Scenario: 1. MboOnderwijslicenties opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '27DV-91690-BOL'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.begindatum=='2008-08-01')]' de volgende inhoud
      | bekostigd  | true                                                                            |
      | stadium    | "STANDAARD"                                                                     |
      | einddatum  | "2020-08-01"                                                                    |
      | leerweg    | "BOL"                                                                           |
      | uri        | "http://lod.onderwijsregistratie.nl/rio/id/MboOnderwijslicentie/27DV-91690-BOL" |
      | begindatum | "2008-08-01"                                                                    |
    En bevat de jsonpath '_links.self' de waarde '/mbo-onderwijslicenties/27DV-91690-BOL'
    En bevat de jsonpath '_links.mboOpleidingserkenning' de waarde 'mbo-opleidingserkenningen?mboOnderwijslicentie=27DV-91690-BOL'
    En bevat de jsonpath '_links.onderwijsinstellingserkenning' de waarde 'onderwijsinstellingserkenningen?mboOnderwijslicentie=27DV-91690-BOL'

  Scenario: 2. MBO onderwijslicentie komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties/{id}?datumGeldigOp=1996-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '27DV-91690-BOL'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug
