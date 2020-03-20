#language:nl

Functionaliteit: Nederlandse adressen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/nederlands-adressen/{id}'

  Scenario: 1.NL adres obv id
    Als gezocht wordt op pathparam 'id' met waarde '1000AE-202-100B213'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.huisnummer=='202')]' de volgende inhoud
      | plaatsnaam           | "AMSTERDAM"                                                            |
      | huisnummer           | 202                                                                     |
      | huisnummertoevoeging | null                                                                   |
      | postcode             | "1000AE"                                                              |
      | straatnaam           | "Postbus"                                          |
      | uri                  | "http://lod.onderwijsregistratie.nl/rio/id/NederlandsAdres/1000AE-202-100B213" |
    En bevat de jsonpath '_links.communicatiecontext' de waarde 'communicatiecontexten?nederlandsAdres=1000AE-202-100B213'
    En bevat de jsonpath '_links.self' de waarde '/nederlands-adressen/1000AE-202-100B213'