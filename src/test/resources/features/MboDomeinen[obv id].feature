#language:nl

Functionaliteit: MBO Domeinen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-domeinen/{id}'

  Scenario: 1. MboDomeinen opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '79010-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.code=='79010')]' de volgende inhoud
      | internationaleNaam | null                                                                             |
      | afkorting          | "79010"                                                                                 |
      | structuur          | "HKS" |
      | code               | "79010"                                                                                |
      | startdatum         | "2012-08-01"                                                                            |
      | herkomstOpleiding  | "SBB"                                                                                   |
      | naamLang           | "Afbouw, hout en onderhoud"                                                            |
      | naam               | "Afbouw, hout en onderhoud"                                                                         |
      | uri                | "http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/79010-SBB"                |
      | opheffingsdatum    | null                                                                            |
    En bevat de jsonpath '_links.self' de waarde '/mbo-domeinen/79010-SBB'
    En bevat de jsonpath '_links.mboOpleidingserkenning' de waarde 'mbo-opleidingserkenningen?mboDomein=79010-SBB'
    En bevat de jsonpath '_links.aangebodenMboOpleiding' de waarde 'aangeboden-mbo-opleidingen?mboDomein=79010-SBB'
    En bevat de jsonpath '_links.mboKwalificatiedossier' de waarde 'mbo-kwalificatiedossiers?mboDomein=79010-SBB'

  Scenario: 2. MBODomein komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/mbo-domeinen/{id}?datumGeldigOp=2010-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '79010-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug
