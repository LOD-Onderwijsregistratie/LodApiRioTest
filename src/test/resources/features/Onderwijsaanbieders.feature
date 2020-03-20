#language:nl

Functionaliteit: Opvragen Onderwijsaanbieders

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.onderwijsaanbieders[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsaanbieders[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?naam='s Gravendreef College Leidschenveen'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.onderwijsaanbieders[*][?(@.naam=='\'s Gravendreef College Leidschenveen')]' terug
    #En geen enteiten met een andere code
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsaanbieders[*][?(@.naam!='\'s Gravendreef College Leidschenveen')]' terug

  Scenario: 2a. Zoeken op plaatsnaam
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?plaatsnaam=Apeldoorn'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Er mag maar 1 uri voor komen, maar uri komt dubbel terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsaanbieders[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsaanbieder/100A939')]' terug

  Scenario: 3. Filter CommunicatieContexten obv onderwijsaanbieder
    Stel het soort request in op GET met endpoint 'communicatiecontexten?onderwijsaanbieder=100A003'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.communicatiecontexten[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Communicatiecontext/100A003_ALGEMEEN')]' terug

  Scenario: 4. Filter Onderwijsbesturen obv onderwijsaanbieder
    Stel het soort request in op GET met endpoint 'onderwijsbesturen?onderwijsaanbieder=101A099'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsbesturen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsbestuur/101B408')]' terug

  Scenario: 5a. Filter AangebodenMboOpleidingen obv onderwijsaanbieder
    Stel het soort request in op GET met endpoint 'aangeboden-mbo-opleidingen?onderwijsaanbieder=100A429'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 5b. Filter AangebodenMboOpleidingen obv onderwijsaanbieder, onderwijsaanbieder bestaat niet
    Stel het soort request in op GET met endpoint 'aangeboden-mbo-opleidingen?onderwijsaanbieder=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '0' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 6a. Filter AangebodenVavoOpleidingen obv onderwijsaanbieder
    Stel het soort request in op GET met endpoint 'aangeboden-vavo-opleidingen?onderwijsaanbieder=100A236'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenVavoOpleidingen[*]' terug

  Scenario: 6b. Filter AangebodenVavoOpleidingen obv onderwijsaanbieder, onderwijsaanbieder bestaat niet
    Stel het soort request in op GET met endpoint 'aangeboden-vavo-opleidingen?onderwijsaanbieder=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingen[*]' terug