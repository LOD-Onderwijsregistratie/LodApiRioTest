#language:nl

Functionaliteit: Opvragen Onderwijslocatiegebruiken obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken/{id}'

  Scenario: 1. Onderwijslocatiegebruik opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '101B408-101X071'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.inBedrijfdatum=='2019-08-01')]' de volgende inhoud
      | inBedrijfdatum                      | "2019-08-01"                                                                        |
      | uitBedrijfdatum                     | null                                                                                |
      | naam                                | "'s Gravendreef College \"op de hoek\""                                             |
      | uri                                 | "http://lod.onderwijsregistratie.nl/rio/id/Onderwijslocatiegebruik/101B408-101X071" |
      | eigenOnderwijslocatiegebruikSleutel | null                                                                                |
    En bevat de jsonpath '_links.self' de waarde '/onderwijslocatiegebruiken/101B408-101X071'
    En bevat de jsonpath '_links.onderwijslocaties' de waarde 'onderwijslocaties?onderwijslocatiegebruik=101B408-101X071'
    En bevat de jsonpath '_links.onderwijsbestuur' de waarde 'onderwijsbesturen?onderwijslocatiegebruik=101B408-101X071'


  Scenario: 2.  Onderwijslocatiegebruik komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/onderwijslocatiegebruiken/{id}?datumGeldigOp=1000-07-01'
    Als gezocht wordt op pathparam 'id' met waarde '101B408-101X071'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug



