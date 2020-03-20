#language:nl

Functionaliteit: Opvragen OnderwijsInstellingserkenningen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.onderwijsinstellingserkenningen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsinstellingserkenningen[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?volledigeNaam=2College voor Lyceum Havo Mavo Vbo'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.onderwijsinstellingserkenningen[*][?(@.volledigeNaam=='2College voor Lyceum Havo Mavo Vbo')]' terug
    #En geen enteiten met een andere code
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsinstellingserkenningen[*][?(@.volledigeNaam!='2College voor Lyceum Havo Mavo Vbo')]' terug

  Scenario: 2b. Zoeken op wet
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?wet=nietbestaandewet'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Er wordt geen enteit gevonden want wet is nietbestaand
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsinstellingserkenningen[*]' terug

  Scenario: 2c. Zoeken op soort
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?soort=VOS'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze soort
    En krijg ik minimaal aantal '1' jsonpath '_embedded.onderwijsinstellingserkenningen[*][?(@.soort=='VOS')]' terug
    #En geen enteiten met een andere soort
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsinstellingserkenningen[*][?(@.soort!='VOS')]' terug

  Scenario: 3a. Filter Examenlicentie ophalen obv onderwijsinstellingserkenning
    Stel het soort request in op GET met endpoint '/examenlicenties?onderwijsinstellingserkenning=00GT'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.examenlicenties[*]' terug

  Scenario: 3b. Filter Examenlicentie ophalen obv onderwijsinstellingserkenning, onderwijsinstellingserkenning bestaat niet
    Stel het soort request in op GET met endpoint '/examenlicenties?onderwijsinstellingserkenning=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.examenlicenties[*]' terug

  Scenario: 4a. Filter Onderwijsaanbieder ophalen obv onderwijsbestuur
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?onderwijsinstellingserkenning=25CM'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.onderwijsaanbieders[*]' terug

  Scenario: 4b. Filter Onderwijsaanbieder ophalen obv onderwijsbestuur, onderwijsinstellingserkenning bestaat niet
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?onderwijsinstellingserkenning=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsaanbieders[*]' terug

  Scenario: 5a. Filter MboOnderwijslicentie ophalen obv onderwijsinstellingserkenning
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties?onderwijsinstellingserkenning=27DV'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboOnderwijslicenties[*]' terug

  Scenario: 5b. Filter MboOnderwijslicentie ophalen obv onderwijsinstellingserkenning, onderwijsinstellingserkenning bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties?onderwijsinstellingserkenning=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboOnderwijslicenties[*]' terug

  Scenario: 6a. Filter VAVO-Onderwijslicentie ophalen obv onderwijsinstellingserkenning
    Stel het soort request in op GET met endpoint '/vavo-onderwijslicenties?onderwijsinstellingserkenning=00GT'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.vavoOnderwijslicenties[*]' terug

  Scenario: 6b. Filter VAVO-Onderwijslicentie ophalen obv onderwijsinstellingserkenning, onderwijsinstellingserkenning bestaat niet
    Stel het soort request in op GET met endpoint '/vavo-onderwijslicenties?onderwijsinstellingserkenning=aaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.vavoOnderwijslicenties[*]' terug

  Scenario: 7a:  Filter BevoegdGezagErkenning ophalen obv onderwijsinstellingserkenning
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen?onderwijsinstellingserkenning=29ZM'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.bevoegdGezagErkenningen[*]' terug

  Scenario: 7b:  Filter BevoegdGezagErkenning ophalen obv onderwijsinstellingserkenning
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen?onderwijsinstellingserkenning=aaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.bevoegdGezagErkenningen[*]' terug









