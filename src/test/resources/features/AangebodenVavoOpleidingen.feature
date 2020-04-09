#language:nl

Functionaliteit: Aangeboden Vavo Opleidingen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.aangebodenVavoOpleidingen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingen[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen?naam=ATH zonder profiel'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenVavoOpleidingen[*][?(@.eigenNaam=='ATH zonder profiel')]' terug
    #En geen enteiten met een andere naam
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingen[*][?(@.eigenNaam!='ATH zonder profiel')]' terug

  Scenario: 2b. Zoeken op code
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen?opleidingcode=AAAAAAA'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingen[*]' terug

  Scenario: 3a. Onderwijsaanbieder ophalen obv aangebodenVavoOpleiding
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?aangebodenVavoOpleiding=0042e8ea-923e-42c3-8285-5219ea221ada'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsaanbieders[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijsaanbieder/100A236')]' terug

  Scenario: 3b. Onderwijsaanbieder ophalen obv aangebodenVavoOpleiding
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?aangebodenVavoOpleiding=aaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsaanbieders[*]' terug

  Scenario: 4a. Onderwijslocaties ophalen obv aangebodenVavoOpleiding
    Stel het soort request in op GET met endpoint '/onderwijslocaties?aangebodenVavoOpleiding=0042e8ea-923e-42c3-8285-5219ea221ada'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijslocaties[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijslocatie/100X790')]' terug

  Scenario: 4b. Onderwijslocaties ophalen obv aangebodenVavoOpleiding, aangebodenvavoopleiding bestaat niet
    Stel het soort request in op GET met endpoint '/onderwijslocaties?aangebodenVavoOpleiding=aaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijslocaties[*]' terug

  Scenario: 5a. AangebodenVavoOpleidingCohort ophalen obv aangebodenVavoOpleiding
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten?aangebodenVavoOpleiding=0042e8ea-923e-42c3-8285-5219ea221ada'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenVavoOpleidingCohorten[*]' terug

  Scenario: 5b. AangebodenVavoOpleidingCohort ophalen obv aangebodenVavoOpleiding, aangebodenvavoopleiding bestaat niet
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten?aangebodenVavoOpleiding=aaaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingCohorten[*]' terug
