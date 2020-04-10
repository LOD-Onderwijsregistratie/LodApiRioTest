#language:nl

Functionaliteit: CommunicatieContexten obv id

    #niet gerealiseerd
  #collectie respons bevat ook geen identificerend gegeven
  #id moet bestaan uit samengesteld gegeven, te vinden in trig

  Scenario: 1. Filter communicatieContext obv id
    Stel het soort request in op GET met endpoint '/communicatiecontexten/{id}'
    Als gezocht wordt op pathparam 'id' met waarde '100A003_ALGEMEEN'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.telefoonnummer=='0205854811')]' de volgende inhoud
      | eMailadres     | "mailto:facturen@cb.espritscholen.nl"                                                       |
      | telefoonnummer | "0205854811"                                                                                |
      | context        | "http://lod.onderwijsregistratie.nl/cat/cdm/def/CommunicatiecontextsoortLOD-v03.1/ALGEMEEN" |
      | webadres       | null                                                                                        |
      | uri            | "http://lod.onderwijsregistratie.nl/rio/id/Communicatiecontext/100A003_ALGEMEEN"            |
    En bevat de jsonpath '_links.self' de waarde '/communicatiecontexten/100A003_ALGEMEEN'
    En bevat de jsonpath '_links.nederlandsPostAdres' de waarde 'nederlands-adressen?communicatiecontext=100A003_ALGEMEEN'
    En bevat de jsonpath '_links.nederlandsBezoekAdres' de waarde 'nederlands-adressen?communicatiecontext=100A003_ALGEMEEN'
    En bevat de jsonpath '_links.onderwijsbestuur' de waarde 'onderwijsbesturen?communicatiecontext=100A003_ALGEMEEN'
    En bevat de jsonpath '_links.onderwijsaanbieder' de waarde 'onderwijsaanbieders?communicatiecontext=100A003_ALGEMEEN'