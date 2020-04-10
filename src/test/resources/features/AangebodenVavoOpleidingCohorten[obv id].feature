#language:nl

Functionaliteit: Aangeboden vavo opleiding cohorten obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleiding-cohorten/{id}'

  Scenario: 1. Vavo opleiding Cohorten opvragen
    Als gezocht wordt op pathparam 'id' met waarde '2020-2021-1_af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.beginAanmeldperiode=='2010-08-01')]' de volgende inhoud
      | beginAanmeldperiode              | "2010-08-01"                                                                                                               |
      | code                             | "2020-2021-1"                                                                                                              |
      | toelichtingVereisteToestemming   | null                                                                                                                       |
      | eindeAanmeldperiode              | null                                                                                                                       |
      | eindeInstroomperiode             | "2021-07-31"                                                                                                               |
      | toestemmingVereistVoorAanmelding | "NEE"                                                                                                                      |
      | uri                              | "http://lod.onderwijsregistratie.nl/rio/id/AangebodenVavoOpleidingCohort/2020-2021-1_af90de25-b0e0-40f3-a6e5-b47f9a9d9e10" |
      | instroommoment                   | null                                                                                                                       |
      | beginInstroomperiode             | "2020-08-01"                                                                                                               |
      | status                           | "O"                                                                                                                        |
    En bevat de jsonpath '_links.aangebodenVavoOpleiding' de waarde 'aangeboden-vavo-opleidingen?aangebodenVavoOpleidingCohort=2020-2021-1_af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'