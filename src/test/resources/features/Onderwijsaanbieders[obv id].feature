#language:nl

Functionaliteit: Opvragen Onderwijsaanbieders obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders/{id}'

  Scenario: 1. Onderwijsaanbieders opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '100A003'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.inBedrijfdatum=='2019-08-01')]' de volgende inhoud
      | internationaleNaam             | null                                                                   |
      | onderwijsmethode               | null                                                                   |
      | eigenOnderwijsaanbiederSleutel | null                                                                   |
      | inBedrijfdatum                 | "2019-08-01"                                                           |
      | onderwijsaanbiederID           | "100A003"                                                              |
      | uitBedrijfdatum                | null                                                                   |
      | naam                           | "Berlage Lyceum"                                                       |
      | uri                            | "http://lod.onderwijsregistratie.nl/rio/id/Onderwijsaanbieder/100A003" |
    En bevat de jsonpath '_links.onderwijsinstellingserkenning' de waarde 'onderwijsinstellingserkenningen?onderwijsaanbieder=100A003'
    En bevat de jsonpath '_links.communicatiecontext' de waarde 'communicatiecontexten?onderwijsaanbieder=100A003'
    En bevat de jsonpath '_links.onderwijsbestuur' de waarde 'onderwijsbesturen?onderwijsaanbieder=100A003'
    En bevat de jsonpath '_links.aangebodenVavoOpleiding' de waarde 'aangeboden-vavo-opleidingen?onderwijsaanbieder=100A003'
    En bevat de jsonpath '_links.aangebodenMboOpleiding' de waarde 'aangeboden-mbo-opleidingen?onderwijsaanbieder=100A003'
    En bevat de jsonpath '_links.self' de waarde '/onderwijsaanbieders/100A003'

  Scenario: 2.  Onderwijsaanbieder komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/onderwijsaanbieders/{id}?datumGeldigOp=1999-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '100A003'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug
    Dan bevat de response niet '111A004'