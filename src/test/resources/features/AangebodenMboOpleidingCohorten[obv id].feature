#language:nl

Functionaliteit: Aangeboden mbo opleiding cohorten obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleiding-cohorten/{id}'

  Scenario: 1. MBO opleiding Cohorten opvragen
    Als gezocht wordt op pathparam 'id' met waarde '0190-STD_7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.beginAanmeldperiode=='2018-08-26')]' de volgende inhoud
      | beginAanmeldperiode              | "2018-08-26"                                                                                                           |
      | code                             | "0190-STD"                                                                                                             |
      | toelichtingVereisteToestemming   | null                                                                                                                   |
      | eindeAanmeldperiode              | "2020-07-06"                                                                                                           |
      | eindeInstroomperiode             | null                                                                                                                   |
      | toestemmingVereistVoorAanmelding | "NEE"                                                                                                                  |
      | uri                              | "http://lod.onderwijsregistratie.nl/rio/id/AangebodenMboOpleidingCohort/0190-STD_7559bfac-5ba9-4be6-b14c-a227bf30f2af" |
      | instroommoment                   | "2019-08-01"                                                                                                           |
      | beginInstroomperiode             | null                                                                                                                   |
      | status                           | "O"                                                                                                                    |
    En bevat de jsonpath '_links.self' de waarde '/aangeboden-mbo-opleiding-cohorten/0190-STD_7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.aangebodenMboOpleiding' de waarde 'aangeboden-mbo-opleidingen?aangebodenMboOpleidingCohort=0190-STD_7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.bedrijfsopleiding' de waarde 'bedrijfsopleidingen?aangebodenMboOpleidingCohort=0190-STD_7559bfac-5ba9-4be6-b14c-a227bf30f2af'