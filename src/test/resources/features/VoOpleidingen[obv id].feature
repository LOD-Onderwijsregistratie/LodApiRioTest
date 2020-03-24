#language:nl

Functionaliteit: VoOpleidingen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/vo-opleidingen/{id}'

  Scenario: 1. VoOpleidingen opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '0373-OCW'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.code=='0373')]' de volgende inhoud
      | code                     | "0373"                                                                 |
      | waardedocumentsoort      | "DIPLOMA"                                                            |
      | naamLang                 | "HAVO Profiel Cultuur en Maatschappij"                                      |
      | vWOrichting              | null                                                               |
      | naam                     | "HAVO Prf Cul/Maat"                                                          |
      | uri                      | "http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/0373-OCW" |
      | niveau                   | "VO-HAVO"                                                                 |
      | leerwerktrajectIndicatie | false                                                                     |
      | internationaleNaam       | null                                                                     |
      | afkorting                | "HAVO-NW-CM"                                                                  |
      | startdatum               | "2007-08-01"                                                             |
      | herkomstOpleiding        | "OCW"                                                                    |
      | opheffingsdatum          | null                                                             |
    En bevat de jsonpath '_links.self' de waarde '/vo-opleidingen/0373-OCW'
    En bevat de jsonpath '_links.voGroep' de waarde 'vo-groepen?voOpleiding=0373-OCW'
    En bevat de jsonpath '_links.aangebodenVavoOpleiding' de waarde 'aangeboden-vavo-opleidingen?voOpleiding=0373-OCW'

  Scenario: 2.  VoOpleiding komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/vo-opleidingen/{id}?datumGeldigOp=2015-07-01'
    Als gezocht wordt op pathparam 'id' met waarde '0373-OCW'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug