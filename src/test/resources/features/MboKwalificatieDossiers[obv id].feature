#language:nl

Functionaliteit: MBO KwalificatieDossiers obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers/{id}'

  Scenario: 1. mboKwalificatiedossiers opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '23091-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.code=='23091')]' de volgende inhoud
      | internationaleNaam | null                                                                    |
      | afkorting          | "23091"                                                                 |
      | structuur          | "HKS"                                                                   |
      | code               | "23091"                                                                 |
      | startdatum         | "2015-08-01"                                                            |
      | herkomstOpleiding  | "SBB"                                                                   |
      | naamLang           | "AV-productie"                                                          |
      | naam               | "AV-productie"                                                          |
      | uri                | "http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/23091-SBB" |
      | opheffingsdatum    | null                                                                    |
    En bevat de jsonpath '_links.self' de waarde '/mbo-kwalificatiedossiers/23091-SBB'
    En bevat de jsonpath '_links.mboOpleidingserkenning' de waarde 'mbo-opleidingserkenningen?mboKwalificatiedossier=23091-SBB'
    En bevat de jsonpath '_links.aangebodenMboOpleiding' de waarde 'aangeboden-mbo-opleidingen?mboKwalificatiedossier=23091-SBB'
    En bevat de jsonpath '_links.mboDomein' de waarde 'mbo-domeinen?mboKwalificatiedossier=23091-SBB'

  Scenario: 2. MBO Kwalificatiedossier komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers/{id}?datumGeldigOp=2010-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '23091-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug

