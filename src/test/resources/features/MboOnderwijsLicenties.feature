#language:nl

Functionaliteit: MBO OnderwijsLicenties

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.mboOnderwijslicenties[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboOnderwijslicenties[*]' terug

  Scenario: 3a. Mbo Opleidingserkenningen ophalen die hoort bij een mbo onderwijslicentie
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen?mboOnderwijslicentie=27DV-91690-BOL'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboOpleidingserkenningen[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/MboOpleidingserkenning/91690')]' terug

  Scenario: 3b. Mbo Opleidingserkenningen ophalen die hoort bij een mbo onderwijslicentie, onderwijslicentie bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen?mboOnderwijslicentie=aaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboOpleidingserkenningen[*]' terug

  Scenario: 4a. Onderwijsinstellingserkenningen ophalen die hoort bij een mbo onderwijslicentie
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?mboOnderwijslicentie=27DV-91690-BOL'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsinstellingserkenningen[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsinstellingserkenning/27DV')]' terug

  Scenario: 4b. Onderwijsinstellingserkenningen ophalen die hoort bij een mbo onderwijslicentie, onderwijslicentie bestaat niet
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?mboOnderwijslicentie=aaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsinstellingserkenningen[*]' terug