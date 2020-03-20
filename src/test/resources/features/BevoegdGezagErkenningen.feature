#language:nl

Functionaliteit: BevoegdGezagErkenningen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.bevoegdGezagErkenningen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.bevoegdGezagErkenningen[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/bevoegd-gezag-erkenningen?volledigeNaam=A Line Opl Inst v Huid Verz en Schoonh Verz'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.bevoegdGezagErkenningen[*][?(@.volledigeNaam=='A Line Opl Inst v Huid Verz en Schoonh Verz')]' terug
    #En geen enteiten met een andere volledigeNaam
    En krijg ik aantal '0' jsonpath '_embedded.bevoegdGezagErkenningen[*][?(@.volledigeNaam!='A Line Opl Inst v Huid Verz en Schoonh Verz')]' terug

  Scenario: 3. Filtering op onderwijsbestuur
    Stel het soort request in op GET met endpoint '/onderwijsbesturen?bevoegdGezagErkenning=18542'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsbesturen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsbestuur/100B583')]' terug

  Scenario: 4. Filtering onderwijsinstelling levert 1 resultaat
    Stel het soort request in op GET met endpoint '/onderwijsinstellingserkenningen?bevoegdGezagErkenning=41298'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsinstellingserkenningen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsinstellingserkenning/31EW')]' terug
