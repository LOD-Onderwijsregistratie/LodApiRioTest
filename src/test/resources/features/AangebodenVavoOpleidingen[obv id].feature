#language:nl

Functionaliteit: Aangeboden Vavo Opleidingen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen/{id}'

  Scenario: 1. Vavo opleidingen opvragen
    Als gezocht wordt op pathparam 'id' met waarde 'af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.code=='af90de25-b0e0-40f3-a6e5-b47f9a9d9e10')]' de volgende inhoud
      | eigenNaam                       | "Atheneum zonder profiel"                                                                                |
      | code                            | "af90de25-b0e0-40f3-a6e5-b47f9a9d9e10"                                                                   |
      | startdatum                      | "2010-08-01"                                                                                             |
      | toegankelijkheid                | "ALL"                                                                                                    |
      | toelatingseisen                 | "NEE"                                                                                                    |
      | uri                             | "http://lod.onderwijsregistratie.nl/rio/id/AangebodenVavoOpleiding/af90de25-b0e0-40f3-a6e5-b47f9a9d9e10" |
      | eigenInternationaleNaam         | null                                                                             |
      | eigenAangebodenOpleidingSleutel | null                                                                                          |
      | opheffingsdatum                 | null                                                                                            |
    En bevat de jsonpath '_links.self' de waarde '/aangeboden-vavo-opleidingen/af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'
    En bevat de jsonpath '_links.aangebodenVavoOpleidingCohort' de waarde 'aangeboden-vavo-opleiding-cohorten?aangebodenVavoOpleiding=af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'
    En bevat de jsonpath '_links.onderwijsaanbieder' de waarde 'onderwijsaanbieders?aangebodenVavoOpleiding=af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'
    En bevat de jsonpath '_links.onderwijslocatie' de waarde 'onderwijslocaties?aangebodenVavoOpleiding=af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'
    En bevat de jsonpath '_links.voGroep' de waarde 'vo-groepen?aangebodenVavoOpleiding=af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'
    En bevat de jsonpath '_links.voOpleiding' de waarde 'vo-opleidingen?aangebodenVavoOpleiding=af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'

  Scenario: 2. AangebodenVavoOpleiding komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/aangeboden-vavo-opleidingen/{id}?datumGeldigOp=1010-08-01'
    Als gezocht wordt op pathparam 'id' met waarde 'af90de25-b0e0-40f3-a6e5-b47f9a9d9e10'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug




