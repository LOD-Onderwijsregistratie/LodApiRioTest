#language:nl

Functionaliteit: NederlandseAdressen

  Achtergrond:
    Stel het soort request in op GET met endpoint '/nederlands-adressen'

  Scenario: 1a. Pagina van 20 opvragen
    Stel het soort request in op GET met endpoint '/nederlands-adressen?pageSize=20'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '20' jsonpath '_embedded.nederlandsAdressen[*]' terug

  Scenario: 1b. Een pagina opvragen (pagina=9000000) die niet hoort te bestaan
    Stel het soort request in op GET met endpoint '/nederlands-adressen?page=9000000'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '0' jsonpath '_embedded.nederlandsAdressen[*]' terug

  Scenario: 2. Filter CommunicatieContexten obv nederlands post adres
    Stel het soort request in op GET met endpoint 'communicatiecontexten?nederlandsAdres=1077WV-59-100A003'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.communicatiecontexten[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Communicatiecontext/100A003_ALGEMEEN')]' terug

  Scenario: 3. Filter CommunicatieContexten obv nederlands bezoek adres
    Stel het soort request in op GET met endpoint 'communicatiecontexten?nederlandsAdres=1102MX-2-100A008'
    En ik verstuur het bericht
    Dan krijg ik een statuscode '200' terug
    En krijg ik aantal '1' jsonpath '_embedded.communicatiecontexten[?(@.uri=='http://lod.onderwijsregistratie.nl/rio/id/Communicatiecontext/100A008_ALGEMEEN')]' terug


#  Scenario: 3. RelatieType CommunicatieContext isViaPostBereikbaarOp (parameter gebruiken bij bovenstaande filtering)
#
#    Scenario: 4. RelatieType CommunicatieContext isTeBezoekenOp (parameter gebruiken bij bovenstaande filtering)

  #Hoe zit het precies met het onderscheid van de relatie tussen adres en communicatiecontext?