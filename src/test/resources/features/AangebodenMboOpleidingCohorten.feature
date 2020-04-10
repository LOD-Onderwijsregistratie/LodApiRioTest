#language:nl

Functionaliteit: Aangeboden mbo opleiding cohorten

  Achtergrond:
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

  Scenario: 2a. Zoeken op code
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?opleidingcode=AAAAAAA'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

  Scenario: 3a. aangebodenMboOpleiding obv aangebodenMboOpleidingCohort
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?aangebodenMboOpleidingCohort=0110-AUG_09474686-580e-43d3-9eec-ebf85984ad39'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.aangebodenMboOpleidingen[*][?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/AangebodenMboOpleiding/09474686-580e-43d3-9eec-ebf85984ad39')]' terug

  Scenario: 3b. aangebodenMboOpleiding obv aangebodenMboOpleidingCohort, cohort bestaat niet
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?aangebodenMboOpleidingCohort=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingen[*][*]' terug

  Scenario: 4a. Onderwijsaanbieder obv aangebodenMboOpleidingCohort
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?onderwijsaanbieder=100A070'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

  Scenario: 4b. Onderwijsaanbieder obv aangebodenMboOpleidingCohort, onderwijsaanbieder bestaat niet
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?onderwijsaanbieder=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

  Scenario: 5a. Filter opleidingcode
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?opleidingcode=25286'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

  Scenario: 5b. Filter opleidingcode, code bestaat niet
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?opleidingcode=aangeboden-mbo-opleiding-cohorten?opleidingcode=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

