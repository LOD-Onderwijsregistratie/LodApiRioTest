#language:nl

Functionaliteit: VoGroepen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/vo-groepen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/vo-groepen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.voGroepen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/vo-groepen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.voGroepen[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/vo-groepen?naam=ESS'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.voGroepen[*][?(@.naam=='ESS')]' terug
    #En geen enteiten met een andere code
    En krijg ik aantal '0' jsonpath '_embedded.voGroepen[*][?(@.naam!='ESS')]' terug

  Scenario: 2a. Zoeken op wet
    Stel het soort request in op GET met endpoint '/vo-groepen?wet=nietbestaandewet'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Er wordt geen enteit gevonden want wet is nietbestaand
    En krijg ik aantal '0' jsonpath '_embedded.voGroepen[*]' terug

  Scenario: 3a. Filter VoOpleiding ophalen obv VoGroep
    Stel het soort request in op GET met endpoint '/vo-opleidingen?voGroep=vo3137-VORAAD'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.voOpleidingen[*]' terug

  Scenario: 3b. Filter VoOpleiding ophalen obv VoGroep, niet bestaande voGroep
    Stel het soort request in op GET met endpoint '/vo-opleidingen?voGroep=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.voOpleidingen[*]' terug

#  Scenario: 6. Filter vavoOpleidingserkenningCode

#  Scenario: 7. Filter wet

  Scenario: 8. Filter datumGeldigOp
    Stel het soort request in op GET met endpoint '/vo-groepen?datumGeldigOp=1960-08-01'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.voGroepen[*]' terug
    #filter doet niets, geeft alle vo-groepen terug