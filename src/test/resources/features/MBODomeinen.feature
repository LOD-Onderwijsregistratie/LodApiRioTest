#language:nl

Functionaliteit: MBO Domeinen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-domeinen'

  Scenario: 1a. Pagina van 10 opvragen
    #er zijn nu maar 17 mbodomeinen
    Stel het soort request in op GET met endpoint '/mbo-domeinen?pageSize=10'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '10' jsonpath '_embedded.mboDomeinen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/mbo-domeinen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboDomeinen[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/mbo-domeinen?naam=Afbouw, hout en onderhoud'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboDomeinen[*][?(@.naam=='Afbouw, hout en onderhoud')]' terug
    #En geen enteiten met een andere eigenNaam
    En krijg ik aantal '0' jsonpath '_embedded.mboDomeinen[*][?(@.naam!='Afbouw, hout en onderhoud')]' terug

  Scenario: 2a. Zoeken op wet
    Stel het soort request in op GET met endpoint '/mbo-domeinen?wet=WEB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.mboDomeinen[*]' terug

  Scenario: 2b. Zoeken op wet
    Stel het soort request in op GET met endpoint '/mbo-domeinen?wet=nietbestaandewet'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboDomeinen[*]' terug

  Scenario: 3a. Filter aangebodenMboOpleidingen obv mbodomein
    Stel het soort request in op GET met endpoint 'aangeboden-mbo-opleidingen?mboDomein=79000-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #helaas geen data beschikbaar

  Scenario: 3b. Filter aangebodenMboOpleidingen obv mbodomein
    Stel het soort request in op GET met endpoint 'aangeboden-mbo-opleidingen?mboDomein=aaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 4a. Filter mboopleidingserkenningen obv mbodomein
    Stel het soort request in op GET met endpoint 'mbo-opleidingserkenningen?mboDomein=79000-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboOpleidingserkenningen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/MboOpleidingserkenning/79000')]' terug

  Scenario: 4b. Filter mboopleidingserkenningen obv mbodomein, mbodomein bestaat niet
    Stel het soort request in op GET met endpoint 'mbo-opleidingserkenningen?mboDomein=aaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboOpleidingserkenningen[*]' terug

  Scenario: 5a. Filter mboKwalificatiedossier obv mbodomein
    Stel het soort request in op GET met endpoint 'mbo-kwalificatiedossiers?mboDomein=79000-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboKwalificatiedossiers[*]' terug

  Scenario: 5b. Filter mboKwalificatiedossier obv mbodomein, mbodomein bestaat niet
    Stel het soort request in op GET met endpoint 'mbo-kwalificatiedossiers?mboDomein=aaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificatiedossiers[*]' terug
