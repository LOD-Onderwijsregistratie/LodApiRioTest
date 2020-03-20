#language:nl

Functionaliteit: Examenlicenties

  Achtergrond:
    Stel het soort request in op GET met endpoint '/examenlicenties'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/examenlicenties?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.examenlicenties[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/examenlicenties?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.examenlicenties[*]' terug

  Scenario: 2. Filtering onderwijsinstelling obv examenlicentie
    Stel het soort request in op GET met endpoint 'onderwijsinstellingserkenningen?examenlicentie=31PB-25579'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsinstellingserkenningen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsinstellingserkenning/31PB')]' terug

  Scenario: 3. Filtering mboOpleidingserkenning obv examenlicentie
    Stel het soort request in op GET met endpoint 'mbo-opleidingserkenningen?examenlicentie=31PB-25579'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboOpleidingserkenningen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/MboOpleidingserkenning/25579')]' terug
