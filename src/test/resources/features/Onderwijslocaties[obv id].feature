#language:nl

Functionaliteit: Opvragen Onderwijslocaties obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijslocaties/{id}'

  Scenario: 1. Onderwijslocaties opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '100X501'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.code=='100X501')]' de volgende inhoud
      | gpsLongitude         | 6.119                                                                              |
      | code                 | "100X501"                                                                          |
      | bagUri               | "http://bag.basisregistraties.overheid.nl/bag/id/verblijfsobject/0090010000684396" |
      | huisnummer           | 1                                                                                |
      | bagcode              | "0090010000684396"                                                                 |
      | postcode             | "9202LE"                                                                           |
      | huisnummertoevoeging | null                                                                               |
      | uri                  | "http://lod.onderwijsregistratie.nl/rio/id/Onderwijslocatie/100X501"               |
      | gpsLatitude          | 53.107                                                                             |
    En bevat de jsonpath '_links.self' de waarde '/onderwijslocaties/100X501'
    En bevat de jsonpath '_links.onderwijslocatiegebruik' de waarde 'onderwijslocatiegebruiken?onderwijslocatie=100X501'
    En bevat de jsonpath '_links.aangebodenMboOpleiding' de waarde 'aangeboden-mbo-opleidingen?onderwijslocatie=100X501'
    En bevat de jsonpath '_links.aangebodenVavoOpleiding' de waarde 'aangeboden-vavo-opleidingen?onderwijslocatie=100X501'

#  Scenario: 2. Onderwijslocatie komt niet terug want filter datumGeldigOp niet geldig
#    Op welke data gaat gefilterd worden????
