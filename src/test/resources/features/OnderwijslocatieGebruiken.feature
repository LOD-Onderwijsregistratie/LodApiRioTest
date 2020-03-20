#language:nl

Functionaliteit: Opvragen Onderwijslocatiegebruiken

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.onderwijslocatiegebruiken[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijslocatiegebruiken[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken?naam='s Gravendreef College Leidschendam'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.onderwijslocatiegebruiken[*][?(@.naam=='\'s Gravendreef College Leidschendam')]' terug
    #En geen enteiten met een andere code
    En krijg ik aantal '0' jsonpath '_embedded.onderwijslocatiegebruiken[*][?(@.naam!='\'s Gravendreef College Leidschendam')]' terug

  Scenario: 2. Filter onderwijslocatie ophalen obv onderwijslocatiegebruik
    Stel het soort request in op GET met endpoint '/onderwijslocaties?onderwijslocatiegebruik=100B481-100X501'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijslocaties[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijslocatie/100X501')]' terug

  Scenario: 3. Filter onderwijsbestuur ophalen obv onderwijslocatiegebruik
    Stel het soort request in op GET met endpoint '/onderwijsbesturen?onderwijslocatiegebruik=100B225-100X655'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsbesturen[*][?(@.uri=='"http://lod.onderwijsregistratie.nl/rio/id/Onderwijsbestuur/100B225')]' terug