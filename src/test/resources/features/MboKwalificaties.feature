#language:nl

Functionaliteit: MBO Kwalificaties

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.mboKwalificaties[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificaties[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?naam=(Ambulant) objectleider'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboKwalificaties[*][?(@.naam=='(Ambulant) objectleider')]' terug
    #En geen enteiten met een andere eigenNaam
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificaties[*][?(@.naam!='(Ambulant) objectleider')]' terug

  Scenario: 3a. Filter wet
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?wet=WEB&page=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.mboKwalificaties[*]' terug

  Scenario: 3b. Zoeken op wet, wet bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?wet=nietbestaandewet'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Er wordt geen enteit gevonden want wet is nietbestaand
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificaties[*]' terug

  Scenario: 4. Filter naam
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?naam=Verkoopspecialist'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '_embedded.mboKwalificaties[?(@.code=='10053')]' de volgende inhoud
      | structuur           | null                                                                                    |
      | code                | "10053"                                                                                 |
      | studielast          | 4800                                                                                    |
      | waardedocumentsoort | "DIPLOMA"                                                                               |
      | naamLang            | "Verkoopspecialist"                                                                     |
      | naam                | "Verkoopspecialist"                                                                     |
      | studielasteenheid   | "SBU"                                                                                   |
      | uri                 | "http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/10053-SBB-ENTREEOPLEIDING" |
      | niveau              | "MBO-4"                                                                                 |
      | opleidingssoort     | "ENTREEOPLEIDING"                                                                       |
      | internationaleNaam  | "Sales specialist"                                                                      |
      | afkorting           | "25155"                                                                                 |
      | startdatum          | "1997-08-01"                                                                            |
      | herkomstOpleiding   | "SBB"                                                                                   |
      | wetEisendMinisterie | "DEF"                                                                                   |
      | opheffingsdatum     | null                                                                                    |

  Scenario: 5. AangebodenMboOpleidingen ophalen obv mboKwalificatie
    Stel het soort request in op GET met endpoint 'aangeboden-mbo-opleidingen?mboKwalificatie=10053-SBB-ENTREEOPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug

  Scenario: 6. mboKwalificatiesDossier ophalen obv mboKwalificatie
    Stel het soort request in op GET met endpoint 'mbo-kwalificatiedossiers?mboKwalificatie=10053-SBB-ENTREEOPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug

  Scenario: 7. mboOpleidingserkenningen ophalen obv mboKwalificatie
    Stel het soort request in op GET met endpoint 'mbo-opleidingserkenningen?mboKwalificatie=10053-SBB-ENTREEOPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug



