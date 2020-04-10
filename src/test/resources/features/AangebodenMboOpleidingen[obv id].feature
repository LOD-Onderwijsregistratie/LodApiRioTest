#language:nl

Functionaliteit: Aangeboden mbo opleidingen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen/{id}'

  Scenario: 1. MBO opleidingen opvragen
    Als gezocht wordt op pathparam 'id' met waarde '7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.code=='7559bfac-5ba9-4be6-b14c-a227bf30f2af')]' de volgende inhoud
      | eigenNaam                       | "Allround constructiewerker – verkort"                                                                  |
      | code                            | "7559bfac-5ba9-4be6-b14c-a227bf30f2af"                                                                  |
      | startdatum                      | "2016-06-01"                                                                                            |
      | leertraject                     | "BBL"                                                                                                   |
      | toegankelijkheid                | "ALL"                                                                                                   |
      | toelatingseisen                 | "NEE"                                                                                                   |
      | mboNiveau                       | null                                                                                                    |
      | uri                             | "http://lod.onderwijsregistratie.nl/rio/id/AangebodenMboOpleiding/7559bfac-5ba9-4be6-b14c-a227bf30f2af" |
      | eigenInternationaleNaam         | null                                                                                                    |
      | eigenAangebodenOpleidingSleutel | "02047-301-B"                                                                                           |
      | opheffingsdatum                 | null                                                                                                    |
    En bevat de jsonpath '_links.self' de waarde '/aangeboden-mbo-opleidingen/7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.aangebodenMboOpleidingCohort' de waarde 'aangeboden-mbo-opleiding-cohorten?aangebodenMboOpleiding=7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.onderwijsaanbieder' de waarde 'onderwijsaanbieders?aangebodenMboOpleiding=7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.onderwijslocatie' de waarde 'onderwijslocaties?aangebodenMboOpleiding=7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.mboCrossOverKwalificatie' de waarde 'mbo-cross-over-kwalificaties?aangebodenMboOpleiding=7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.mboKwalificatie' de waarde 'mbo-kwalificaties?aangebodenMboOpleiding=7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.mboKwalificatiedossier' de waarde 'mbo-kwalificatiedossiers?aangebodenMboOpleiding=7559bfac-5ba9-4be6-b14c-a227bf30f2af'
    En bevat de jsonpath '_links.mboDomein' de waarde 'mbo-domeinen?aangebodenMboOpleiding=7559bfac-5ba9-4be6-b14c-a227bf30f2af'

  Scenario: 2. AangebodenMboOpleiding komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/aangeboden-mbo-opleidingen/{id}?datumGeldigOp=1010-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '7559bfac-5ba9-4be6-b14c-a227bf30f2a'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug


