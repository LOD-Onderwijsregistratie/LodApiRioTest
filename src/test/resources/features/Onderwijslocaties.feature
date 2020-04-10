#language:nl

Functionaliteit: Opvragen Onderwijslocaties

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijslocaties'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/onderwijslocaties?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.onderwijslocaties[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/onderwijslocaties?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijslocaties[*]' terug

  Scenario: 2a:  Filter AangebodenMboOpleiding ophalen obv onderwijslocatie
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?onderwijslocatie=100X515'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 2a:  Filter AangebodenMboOpleiding ophalen obv onderwijslocatie, onderwijslocatie bestaat niet
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?onderwijslocatie=aaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 3a. Filter AangebodenVavoOpleiding ophalen obv onderwijslocatie
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen?onderwijslocatie=101X324'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenVavoOpleidingen[*]' terug

  Scenario: 3b. Filter AangebodenVavoOpleiding ophalen obv onderwijslocatie, onderwijslocatie bestaat niet
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen?onderwijslocatie=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingen[*]' terug

  Scenario: 4b. Filter Onderwijslocatiegebruik ophalen obv onderwijslocatie
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken?onderwijslocatie=100X501'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.onderwijslocatiegebruiken[*]' terug

  Scenario: 4a. Filter Onderwijslocatiegebruik ophalen obv onderwijslocatie, onderwijslocatie bestaat niet
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken?onderwijslocatie=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijslocatiegebruiken[*]' terug
