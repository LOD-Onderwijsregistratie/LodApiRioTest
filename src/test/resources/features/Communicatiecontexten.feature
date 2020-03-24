#language:nl

Functionaliteit: Communicatiecontexten

  Achtergrond:
    Stel het soort request in op GET met endpoint '/communicatiecontexten'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/communicatiecontexten?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.communicatiecontexten[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/communicatiecontexten?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.communicatiecontexten[*]' terug
    
    #links/filters nog niet werkend voor deze opvraging

  Scenario: 2. onderwijsbesturen opvragen op filter communicatiecontext werkt nog niet
    Stel het soort request in op GET met endpoint 'onderwijsbesturen?communicatiecontext=100B001_ALGEMEEN'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsbesturen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsbestuur/100B001')]' terug

  Scenario: 3. nederlands post adres opvragen op filter communicatiecontext
    Stel het soort request in op GET met endpoint 'nederlands-adressen?communicatiecontext=100A003_ALGEMEEN'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.nederlandsAdressen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/NederlandsAdres/1077WV-59-100A003')]' terug

  Scenario: 4. onderwijsaanbieder obv communicatiecontext
    Stel het soort request in op GET met endpoint 'onderwijsaanbieders?communicatiecontext=100A003_ALGEMEEN'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsaanbieders[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsaanbieder/100A003')]' terug



