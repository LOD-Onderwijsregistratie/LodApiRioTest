#language:nl

Functionaliteit: MBO Opleidingserkenningen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen/{id}'

  Scenario: 1. MboOpleidingserkenning obv id
    Als gezocht wordt op pathparam 'id' met waarde '25031'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.CREBOcode=='25031')]' de volgende inhoud
      | instroomEinddatum      | null                                                                     |
      | ministerie             | "OCW"                                                                    |
      | opleidingsstelsel      | "CREBO"                                                                  |
      | wet                    | "WEB"                                                                |
      | einddatum              | null                                                             |
      | toegestaneLeerweg      | ["BBL", "BOL", "OVO"]                                                                  |
      | uri                    | "http://lod.onderwijsregistratie.nl/rio/id/MboOpleidingserkenning/25031" |
      | prijsfactorBekostiging | 1.4                                                                     |
      | CREBOcode              | "25031"                                                                  |
      | ingangsdatum           | "2015-08-01"                                                             |
    En bevat de jsonpath '_links.self' de waarde '/mbo-opleidingserkenningen/25031'
    En bevat de jsonpath '_links.mboKwalificatie' de waarde 'mbo-kwalificaties?mboOpleidingserkenning=25031'
    En bevat de jsonpath '_links.mboDomein' de waarde 'mbo-domeinen?mboOpleidingserkenning=25031'
    En bevat de jsonpath '_links.mboKwalificatiedossier' de waarde 'mbo-kwalificatiedossiers?mboOpleidingserkenning=25031'
    En bevat de jsonpath '_links.mboCrossOverKwalificatie' de waarde 'mbo-cross-over-kwalificaties?mboOpleidingserkenning=25031'
    En bevat de jsonpath '_links.mboOnderwijslicentie' de waarde 'mbo-onderwijslicenties?mboOpleidingserkenning=25031'
    En bevat de jsonpath '_links.examenlicentie' de waarde 'examenlicenties?mboOpleidingserkenning=25031'

  Scenario: 2. MBO Opleidingserkenning komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen/{id}?datumGeldigOp=2010-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '25031'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug