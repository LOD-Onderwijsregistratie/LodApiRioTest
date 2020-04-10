# RIO API test project

Dit project heeft als doel om de [RIO API](https://lod.onderwijsregistratie.nl/rio-api) geautomatiseerd te testen. De tests zijn geschreven in Selenium Cucumber. De testcases zijn uitegeschreven in src/test/resources/features


# Setup

## Certificaten

Om contact te kunnen maken met de API moet je overheidscertificaten laden.

Draai dit commando vanuit de hoofdmap van dit project:

```
keytool -import -alias gca -file certs.pem -keystore {JOUW JAVA HOME HIER}/jre/lib/security/cacerts
```

## Configuratie

Om de tests te kunnen draaien dien je  een bestand aan te maken in **src/main/resources** genaamd **test.properties** met de volgende inhoud:

baseUri={base uri van de te testen api, bv: https://lod-test.onderwijsregistratie.nl/api/rio/v1-rio-beta/}  
x-api-key={api key die nodig is voor authorisatie}

## Runnen van de tests

Benodigdheden voor het draaien van de tests zijn Java 8 (minimaal) en Maven 3 (minimaal).

### Maven 

Via maven kun je de tests runnen met **mvn clean install**.  Uiteindelijk is het testrapport te vinden onder target/site/serenity.

### IntelliJ

Het bekijken van de feature files en het individueel testen van een testcase is het gebruik van een IDE aanbevolen. Als je gebruik maakt van de IntelliJ community edition dien je de [cucumber for java](https://plugins.jetbrains.com/plugin/7212-cucumber-for-java) te installeren.
