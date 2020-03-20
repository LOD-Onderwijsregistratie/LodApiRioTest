#language:nl

Functionaliteit: VoGroepen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/vo-groepen/{id}'

  Scenario: 1. VoGroepen opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde 'vo8509-VORAAD'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.code=='vo8509')]' de volgende inhoud
      | internationaleNaam | null                                                                   |
      | afkorting          | null                                                             |
      | code               | "vo8509"                                                                 |
      | startdatum         | "2019-08-01"                                                           |
      | herkomstOpleiding  | "VORAAD"                                                                  |
      | naamLang           | "European Secondary School"                   |
      | naam               | "ESS"                                                  |
      | uri                | "http://lod.onderwijsregistratie.nl/rio/id/Opleidingseenheid/vo8509-VORAAD" |
      | opheffingsdatum    | null                                                                   |
    En bevat de jsonpath '_links.self' de waarde '/vo-groepen/vo8509-VORAAD'
    En bevat de jsonpath '_links.voOpleiding' de waarde 'vo-opleidingen?voGroep=vo8509-VORAAD'
    En bevat de jsonpath '_links.aangebodenVavoOpleiding' de waarde 'aangeboden-vavo-opleidingen?voGroep=vo8509-VORAAD'

  Scenario: 2.  VoGroep komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/vo-groepen/{id}?datumGeldigOp=1998-07-01'
    Als gezocht wordt op pathparam 'id' met waarde 'vo8509-VORAAD'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug

