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
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboKwalificaties[*][?(@.naam=='Verkoopspecialist')]' terug
    #En geen enteiten met een andere eigenNaam
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificaties[*][?(@.naam!='Verkoopspecialist')]' terug

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



