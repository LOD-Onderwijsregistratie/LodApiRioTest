#language:nl

Functionaliteit: Opvragen Onderwijsbesturen obv id

  Achtergrond:
    Stel het soort request in op GET met endpoint '/onderwijsbesturen/{id}'

  Scenario: 1. Onderwijsbesturen opvragen obv id
    Als gezocht wordt op pathparam 'id' met waarde '101B584'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En bevat de response op jsonpath '[?(@.bestuurID=='101B584')]' de volgende inhoud
      | internationaleNaam | null                                                                 |
      | inBedrijfdatum     | "2009-05-01"                                                         |
      | rSIN               | null                                                                 |
      | bestuurID          | "101B584"                                                            |
      | uitBedrijfdatum    | null                                                                 |
      | naam               | "\'NTTA' Nautical Technical Training Academy B.V."                                         |
      | uri                | "http://lod.onderwijsregistratie.nl/rio/id/Onderwijsbestuur/101B584" |
      | kVKnummer          | null                                                                 |
    En bevat de jsonpath '_links.self' de waarde '/onderwijsbesturen/101B584'
    En bevat de jsonpath '_links.bevoegdGezagErkenning' de waarde 'bevoegd-gezag-erkenningen?onderwijsbestuur=101B584'
    En bevat de jsonpath '_links.communicatiecontext' de waarde 'communicatiecontexten?onderwijsbestuur=101B584'
    En bevat de jsonpath '_links.onderwijsaanbieder' de waarde 'onderwijsaanbieders?onderwijsbestuur=101B584'
    En bevat de jsonpath '_links.onderwijslocatiegebruik' de waarde 'onderwijslocatiegebruiken?onderwijsbestuur=101B584'

  Scenario: 2.  Onderwijsbestuur komt niet terug want filter datumGeldigOp niet geldig
    Stel het soort request in op GET met endpoint '/onderwijsbesturen/{id}?datumGeldigOp=1999-08-01'
    Als gezocht wordt op pathparam 'id' met waarde '101B584'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '404' terug
    Dan bevat de response niet '222B004'