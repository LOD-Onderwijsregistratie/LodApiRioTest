#language:nl

Functionaliteit: MBO Crossover Kwalificaties

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.mboCrossOverKwalificaties[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboCrossOverKwalificaties[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties?naam=AV-mediatechnoloog'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboCrossOverKwalificaties[*][?(@.naam=='AV-mediatechnoloog')]' terug
    #En geen enteiten met een andere eigenNaam
    En krijg ik aantal '0' jsonpath '_embedded.mboCrossOverKwalificaties[*][?(@.naam!='AV-mediatechnoloog')]' terug

  Scenario: 2a. Zoeken op wet
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties?wet=WEB'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.mboCrossOverKwalificaties[*]' terug

  Scenario: 2a. Zoeken op wet, wet bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties?wet=nietBestaandeWet'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboCrossOverKwalificaties[*]' terug

  Scenario: 3a. aangebodenMboOpleiding obv mboCrossOverKwalificatie
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?mboCrossOverKwalificatie=26001-SBB-VAKOPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.aangebodenMboOpleidingen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/AangebodenMboOpleiding/4c41d41f-c985-42e7-bea9-fffd186ea642')]' terug

  Scenario: 3b. aangebodenMboOpleiding obv mboCrossOverKwalificatie, mboCrossOverKwalificatie bestaat niet
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?mboCrossOverKwalificatie=aaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 4a. mboOpleidingserkenningen obv mboCrossOverKwalificatie
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen?mboCrossOverKwalificatie=26001-SBB-VAKOPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboOpleidingserkenningen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/MboOpleidingserkenning/26001')]' terug

  Scenario: 4b. mboOpleidingserkenningen obv mboCrossOverKwalificatie, mboCrossOverKwalificatie bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen?mboCrossOverKwalificatie=aaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboOpleidingserkenningen[*]' terug



