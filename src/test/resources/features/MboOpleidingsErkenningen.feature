#language:nl

Functionaliteit: MBO Opleidingserkenningen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.mboOpleidingserkenningen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboOpleidingserkenningen[*]' terug

  Scenario: 2a. Zoeken op wet
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen?wet=WEB&page=10'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Er wordt geen enteit gevonden want wet is nietbestaand
    En krijg ik aantal '10' jsonpath '_embedded.mboOpleidingserkenningen[*][?(@.wet=='WEB')]' terug

  Scenario: 2b. Zoeken op wet, niet bestaande wet
    Stel het soort request in op GET met endpoint '/mbo-opleidingserkenningen?wet=nietbestaandewet'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    #Er wordt geen enteit gevonden want wet is nietbestaand
    En krijg ik aantal '0' jsonpath '_embedded.mboOpleidingserkenningen[*]' terug

  Scenario: 2. Filter MboDomein ophalen obv MboOpleidingserkenning
    Stel het soort request in op GET met endpoint '/mbo-domeinen?mboOpleidingserkenning=79000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboDomeinen[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/79000-SBB')]' terug

  Scenario: 3: Filter MboKwalificatieDossier obv MboOpleidingserkenning
    Stel het soort request in op GET met endpoint '/mbo-kwalificatiedossiers?mboOpleidingserkenning=22001'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboKwalificatiedossiers[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/22001-SBB')]' terug

  Scenario: 4. Filter MboCrossOverKwalificatie obv MboOpleidingserkenning
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties?mboOpleidingserkenning=26000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboCrossOverKwalificaties[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/26000-SBB-MIDDENKADEROPLEIDING')]' terug

  Scenario: 5. Filter MboKwalificatie obv MboOpleidingserkenning
    Stel het soort request in op GET met endpoint '/mbo-kwalificaties?mboOpleidingserkenning=25001'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.mboKwalificaties[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/25001-SBB-BASISBEROEPSOPLEIDING')]' terug

  Scenario: 6a. Filter ExamenLicenties obv MboOpleidingserkenning
    Stel het soort request in op GET met endpoint '/examenlicenties?mboOpleidingserkenning=25149'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.examenlicenties[*]' terug

  Scenario: 6b. Filter ExamenLicenties obv MboOpleidingserkenning, mboOpleidingserkenning bestaat niet
    Stel het soort request in op GET met endpoint '/examenlicenties?mboOpleidingserkenning=aaaaaaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.examenlicenties[*]' terug

  Scenario: 7a. Filter Mbo OnderwijsLicenties obv MboOpleidingserkenning
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties?mboOpleidingserkenning=91690'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik minimaal aantal '1' jsonpath '_embedded.mboOnderwijslicenties[*]' terug

  Scenario: 7b. Filter Mbo OnderwijsLicenties obv MboOpleidingserkenning, mboOpleidingserkenning bestaat niet
    Stel het soort request in op GET met endpoint '/mbo-onderwijslicenties?mboOpleidingserkenning=aaaaaaa'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.mboOnderwijslicenties[*]' terug