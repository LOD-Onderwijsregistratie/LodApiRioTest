#language:nl

Functionaliteit: VavoOnderwijsLicenties

  Achtergrond:
    Stel het soort request in op GET met endpoint '/vavo-onderwijslicenties'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/vavo-onderwijslicenties?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.vavoOnderwijslicenties[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/vavo-onderwijslicenties?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.vavoOnderwijslicenties[*]' terug

#  Scenario: 2. Filter VavoOpleidingserkenning ophalen obv vavoOnderwijslicentie
# helaas nog geen data aanwezig

  Scenario: 3. Filter Onderwijsinstellingserkenning ophalen obv vavoOnderwijslicentie
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?vavoOnderwijslicentie=00GT-5100'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsinstellingserkenningen[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsinstellingserkenning/00GT')]' terug

