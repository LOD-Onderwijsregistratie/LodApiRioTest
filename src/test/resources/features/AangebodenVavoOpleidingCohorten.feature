#language:nl

Functionaliteit: Aangeboden vavo opleiding cohorten

  Achtergrond:
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.aangebodenVavoOpleidingCohorten[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingCohorten[*]' terug

  Scenario: 2a. Zoeken op code
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten?opleidingcode=AAAAAA'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingCohorten[*]' terug

  Scenario: 3a. onderwijsaanbieders obv aangebodenVavoOpleidingCohort
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten?onderwijsaanbieder=100A236'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenVavoOpleidingCohorten[*]' terug

  Scenario: 3b. onderwijsaanbieders obv aangebodenVavoOpleidingCohort, niet bestaande onderwijsaanbieder
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten?onderwijsaanbieder=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingCohorten[*]' terug

  Scenario: 3. aangebodenVavoOpleidingen obv aangebodenVavoOpleidingCohort
    Stel het soort request in op GET met endpoint 'aangeboden-vavo-opleidingen?aangebodenVavoOpleidingCohort=2019-2020-1_0042e8ea-923e-42c3-8285-5219ea221ada'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.aangebodenVavoOpleidingen[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/AangebodenVavoOpleiding/0042e8ea-923e-42c3-8285-5219ea221ada')]' terug

  Scenario: 3b. aangebodenVavoOpleidingen obv aangebodenVavoOpleidingCohort, cohort bestaat niet
    Stel het soort request in op GET met endpoint 'aangeboden-vavo-opleidingen?aangebodenVavoOpleidingCohort=aaaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenVavoOpleidingen[*]' terug
