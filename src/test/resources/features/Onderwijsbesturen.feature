#language:nl

Functionaliteit: Opvragen Onderwijsbesturen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijsbesturen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/onderwijsbesturen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.onderwijsbesturen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/onderwijsbesturen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsbesturen[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/onderwijsbesturen?naam=Academie Louman'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.onderwijsbesturen[*][?(@.naam=='Academie Louman')]' terug
    #En geen enteiten met een andere code
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsbesturen[*][?(@.naam!='Academie Louman')]' terug

  Scenario: 2. Filter Onderwijslocatiegebruik ophalen obv onderwijsbestuur
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken?onderwijsbestuur=100B414'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijslocatiegebruiken[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijslocatiegebruik/100B414-100X945')]' terug

  Scenario: 3:  Filter BevoegdGezagErkenning ophalen obv onderwijsbestuur
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen?onderwijsbestuur=100B414'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.bevoegdGezagErkenningen[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/BevoegdGezagErkenning/31121')]' terug

  Scenario: 4. Filter CommunicatieContext ophalen obv onderwijsbestuur
    Stel het soort request in op GET met endpoint '/communicatiecontexten?onderwijsbestuur=100B414'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.communicatiecontexten[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Communicatiecontext/100B414_ALGEMEEN')]' terug

  Scenario: 5a. Filter Onderwijsaanbieder ophalen obv onderwijsbestuur
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?onderwijsbestuur=100B481'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.onderwijsaanbieders[*]' terug

  Scenario: 5b. Filter Onderwijsaanbieder ophalen obv onderwijsbestuur, onderwijsbestuur bestaat niet
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?onderwijsbestuur=aaaaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsaanbieders[*]' terug



