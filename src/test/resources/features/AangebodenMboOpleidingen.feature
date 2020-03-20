#language:nl

Functionaliteit: Aangeboden Mbo Opleidingen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingen[*]' terug

  Scenario: 2a. Zoeken op naam
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen?naam=Verzorgende-IG'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Dan krijg ik enteiten terug deze naam
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenMboOpleidingen[*][?(@.eigenNaam=='Verzorgende-IG')]' terug
    #En geen enteiten met een andere eigenNaam
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingen[*][?(@.eigenNaam!='Verzorgende-IG')]' terug

  Scenario: 2a. AangebodenMboOpleidingCohorten obv aangebodenMboOpleiding
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?aangebodenMboOpleiding=09474686-580e-43d3-9eec-ebf85984ad39'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

  Scenario: 2b. AangebodenMboOpleidingCohorten obv aangebodenMboOpleiding, niet bestaande mbo opleiding
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten?aangebodenMboOpleiding=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.aangebodenMboOpleidingCohorten[*]' terug

  Scenario: 3a. Onderwijsaanbieders obv aangebodenMboOpleiding
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?aangebodenMboOpleiding=09474686-580e-43d3-9eec-ebf85984ad39'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijsaanbieders[*]' terug

  Scenario: 3b. Onderwijsaanbieders obv aangebodenMboOpleiding, niet bestaande mbo opleiding
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders?aangebodenMboOpleiding=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijsaanbieders[*]' terug

  Scenario: 4a. onderwijslocaties obv aangebodenMboOpleiding
    Stel het soort request in op GET met endpoint '/onderwijslocaties?aangebodenMboOpleiding=09474686-580e-43d3-9eec-ebf85984ad39'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.onderwijslocaties[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Onderwijslocatie/100X694')]' terug

  Scenario: 4b. onderwijslocaties obv aangebodenMboOpleiding, niet bestaande mbo opleiding
    Stel het soort request in op GET met endpoint '/onderwijslocaties?aangebodenMboOpleiding=aaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.onderwijslocaties[*]' terug

  Scenario: 5a. mboCrossOverKwalificaties obv aangebodenMboOpleiding
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties?aangebodenMboOpleiding=4c41d41f-c985-42e7-bea9-fffd186ea642'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboCrossOverKwalificaties[*]' terug

  Scenario: 5b. mboCrossOverKwalificaties obv aangebodenMboOpleiding, niet bestaande mbo opleiding
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties?aangebodenMboOpleiding=aaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboCrossOverKwalificaties[*]' terug

  Scenario: 7a. mboKwalificaties obv aangebodenMboOpleiding
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?aangebodenMboOpleiding=09474686-580e-43d3-9eec-ebf85984ad39'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboKwalificaties[*]' terug

  Scenario: 7b. mboKwalificaties obv aangebodenMboOpleiding, niet bestaande mbo opleiding
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?aangebodenMboOpleiding=aaaaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificaties[*]' terug

    Scenario: 8a. mboKwalificatiedossiers obv aangebodenMboOpleiding
      Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers?aangebodenMboOpleiding=045f02aa-b115-4b87-8954-031fd55e1dbc'
      En ik verstuur het bericht
      Dan krijg ik een statuscode '200' terug
      En krijg ik aantal '1' jsonpath '_embedded.mboKwalificatiedossiers[*]' terug

  Scenario: 8b. mboKwalificatiedossiers obv aangebodenMboOpleiding, aangebodenopleiding bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers?aangebodenMboOpleiding=aaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboKwalificatiedossiers[*]' terug

