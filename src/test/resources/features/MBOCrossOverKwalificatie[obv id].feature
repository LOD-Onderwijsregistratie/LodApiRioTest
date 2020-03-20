#language:nl

Functionaliteit: MBO Crossover Kwalificaties obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties/{id}'

  Scenario: 1. MboCrossoverKwalificatie opvragen
    Als gezocht wordt op pathparam 'id' met waarde '26013-SBB-MIDDENKADEROPLEIDING'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.startdatum=='2018-08-01')]' de volgende inhoud
      | structuur           | "HKS"                                                                                           |
      | code                | "26013"                                                                                       |
      | studielast          | "4800"                                                                                         |
      | waardedocumentsoort | "DIPLOMA"                                                                                  |
      | naamLang            | "AV-mediatechnoloog"                                                                  |
      | naam                | "AV-mediatechnoloog"                                                                                |
      | studielasteenheid   | "SBU"                                                                                          |
      | uri                 | "http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/26013-SBB-MIDDENKADEROPLEIDING" |
      | niveau              | "MBO-4"                                                                                        |
      | opleidingssoort     | "MIDDENKADEROPLEIDING"                                                                        |
      | internationaleNaam  | null                                                                                           |
      | afkorting           | "26013"                                                                                        |
      | startdatum          | "2018-08-01"                                                                                   |
      | herkomstOpleiding   | "SBB"                                                                                          |
      | wetEisendMinisterie | "DEF"                                                                                          |
      | opheffingsdatum     | null                                                                                   |
    En bevat de jsonpath '_links.self' de waarde '/mbo-cross-over-kwalificaties/26013-SBB-MIDDENKADEROPLEIDING'
    En bevat de jsonpath '_links.mboOpleidingserkenning' de waarde 'mbo-opleidingserkenningen?mboCrossOverKwalificatie=26013-SBB-MIDDENKADEROPLEIDING'
    En bevat de jsonpath '_links.aangebodenMboOpleiding' de waarde 'aangeboden-mbo-opleidingen?mboCrossOverKwalificatie=26013-SBB-MIDDENKADEROPLEIDING'

  Scenario: 2. MBOCrossOverKwalificatie komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/mbo-cross-over-kwalificaties/{id}?datumGeldigOp=2010-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '26013'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug

