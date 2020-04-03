#language:nl

Functionaliteit: MBO KwalificatieDossiers

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.mboKwalificatiedossiers[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificatiedossiers[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers?naam=AV-productie'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboKwalificatiedossiers[*][?(@.naam=='AV-productie')]' terug
    #En geen enteiten met een andere eigenNaam
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificatiedossiers[*][?(@.naam!='AV-productie')]' terug

  Scenario: 3a. Zoeken op wet, wet bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers?wet=WEB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '10' jsonpath '_embedded.mboKwalificatiedossiers[*]' terug

  Scenario: 3b. Zoeken op wet, wet bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers?wet=nietbestaandewet'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificatiedossiers[*]' terug

    Scenario: 5a. AangebodenMboOpleidingen ophalen obv mboKwalificatieDossier
      Stel het soort request in op GET met endpoint 'aangeboden-mbo-opleidingen?mboKwalificatiedossier=23030-SBB'
      En ik verstuur het bericht
      Dan krijg ik een statuscode '200' terug
      En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 5b. AangebodenMboOpleidingen ophalen obv mboKwalificatieDossier, mboKwalificatieDossier bestaat niet
    Stel het soort request in op GET met endpoint 'aangeboden-mbo-opleidingen?mboKwalificatiedossier=aaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 6a. MboDomeinen ophalen obv mboKwalificatieDossier
    Stel het soort request in op GET met endpoint 'mbo-domeinen?mboKwalificatiedossier=22000-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboDomeinen[*]' terug

  Scenario: 6b. MboDomeinen ophalen obv mboKwalificatieDossier, mboKwalificatieDossier bestaat niet
    Stel het soort request in op GET met endpoint 'mbo-domeinen?mboKwalificatiedossier=aaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboDomeinen[*]' terug

  Scenario: 7a. MboKwalificaties ophalen obv mboKwalificatieDossier
    Stel het soort request in op GET met endpoint 'mbo-kwalificaties?mboKwalificatiedossier=92090-SBB-ENTREEOPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboKwalificaties[*]' terug

  Scenario: 7b. MboKwalificaties ophalen obv mboKwalificatieDossier
    Stel het soort request in op GET met endpoint 'mbo-kwalificaties?mboKwalificatiedossier=aaaaaaaaa''
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificaties[*]' terug

  Scenario: 8. mboOpleidingserkenningen ophalen obv mboKwalificatieDossier
    Stel het soort request in op GET met endpoint 'mbo-opleidingserkenningen?mboKwalificatiedossier=22000-SBB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboOpleidingserkenningen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/MboOpleidingserkenning/22000')]' terug



