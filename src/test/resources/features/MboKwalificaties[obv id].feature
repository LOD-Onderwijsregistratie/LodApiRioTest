#language:nl

Functionaliteit: MBO Kwalificaties obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties/{id}'

  Scenario: 1. mboKwalificaties opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '25031-SBB-ENTREEOPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.code=='25031')]' de volgende inhoud
      | structuur           | "HKS"                                                                                    |
      | code                | "25031"                                                                                 |
      | studielast          | 4800                                                                                    |
      | waardedocumentsoort | "DIPLOMA"                                                                               |
      | naamLang            | "(Ambulant) objectleider"                                                                     |
      | naam                | "(Ambulant) objectleider"                                                                     |
      | studielasteenheid   | "SBU"                                                                                   |
      | uri                 | "http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/25031-SBB-VAKOPLEIDING" |
      | niveau              | "MBO-3"                                                                                 |
      | opleidingssoort     | "VAKOPLEIDING"                                                                       |
      | internationaleNaam  | null                                                                      |
      | afkorting           | "25031"                                                                                 |
      | startdatum          | "2015-08-01"                                                                            |
      | herkomstOpleiding   | "SBB"                                                                                   |
      | wetEisendMinisterie | "DEF"                                                                                   |
      | opheffingsdatum     | null                                                                                    |
    En bevat de jsonpath '_links.self' de waarde '/mbo-kwalificaties/25031-SBB-ENTREEOPLEIDING'
    En bevat de jsonpath '_links.mboOpleidingserkenning' de waarde 'mbo-opleidingserkenningen?mboKwalificatie=25031-SBB-ENTREEOPLEIDING'
    En bevat de jsonpath '_links.aangebodenMboOpleiding' de waarde 'aangeboden-mbo-opleidingen?mboKwalificatie=25031-SBB-ENTREEOPLEIDING'
    En bevat de jsonpath '_links.mboKwalificatiedossier' de waarde 'mbo-kwalificatiedossiers?mboKwalificatie=25031-SBB-ENTREEOPLEIDING'

  Scenario: 2. MBO Kwalificatie komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties/{id}?datumGeldigOp=1996-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '10053-SBB-ENTREEOPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug
