#language:nl

Functionaliteit: VoOpleidingen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/vo-opleidingen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/vo-opleidingen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.voOpleidingen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/vo-opleidingen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.voOpleidingen[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/vo-opleidingen?naam=HAVO Prf Cul/Maat'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.voOpleidingen[*][?(@.naam=='HAVO Prf Cul/Maat')]' terug
    #En geen enteiten met een andere code
    En krijg ik aantal '0' jsonpath '_embedded.voOpleidingen[*][?(@.naam!='HAVO Prf Cul/Maat')]' terug

  Scenario: 2a. Zoeken op wet
    Stel het soort request in op GET met endpoint '/vo-opleidingen?wet=nietbestaandewet'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Er wordt geen enteit gevonden want wet is nietbestaand
    En krijg ik aantal '0' jsonpath '_embedded.voOpleidingen[*]' terug

  Scenario: 3. Filter VoGroep ophalen obv voOpleiding
    Stel het soort request in op GET met endpoint '/vo-groepen?voOpleiding=6721-OCW'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.voGroepen[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/vo3137-VORAAD')]' terug

  #Scenario: 3. Filter Aangeboden VavoOpleiding ophalen obv voOpleiding

  #Scenario: 4. Filter VavoOpleidingsErkenning ophalen obv voOpleiding


