package nl.ocwduo.ggm.scenariosteps;

import cucumber.api.DataTable;
import cucumber.api.java.nl.Als;
import cucumber.api.java.nl.Dan;
import cucumber.api.java.nl.En;
import cucumber.api.java.nl.Stel;
import net.thucydides.core.annotations.Steps;
import nl.ocwduo.ggm.testautomatisering.rest.RestCallType;
import nl.ocwduo.ggm.messagesteps.SharedMessageSteps;


public class SharedScenarioSteps {

    @Steps
    SharedMessageSteps sharedMessageSteps;


    @Stel("^het soort request in op GET met endpoint '(.*)'$")
    public void hetSoortRequestInOpGETMetEndpointOrganisatorischeEenhedenId(String endpoint) {
        sharedMessageSteps.instellenSoortRequest(RestCallType.GET);
        sharedMessageSteps.instellenEndpoint(endpoint);
    }

    @En("^ik verstuur het bericht$")
    public void ikVerstuurHetBericht() {
        sharedMessageSteps.verstuurLodApiRequest();
    }

    @Dan("^krijg ik een statuscode '(\\d+)' terug$")
    public void krijgIkEenStatuscodeTerug(int statuscode) {
        sharedMessageSteps.controlerenStatuscodeLodApi(statuscode);
    }

    @En("^bevat de response op jsonpath '(.*)' de volgende inhoud$")
    public void bevatDeResponseOpJsonpathDeVolgendeInhoud(String jsonPath, DataTable inhoud) {
        sharedMessageSteps.controleerInhoudVanDeResponse(inhoud, jsonPath);
    }

    @Als("^gezocht wordt op queryparam '(.*)' met waarde '(.*)'$")
    public void addQueryParameterToRequest(String parameter, String inhoud) {
        sharedMessageSteps.opvragenGegevensObvQueryparam(parameter, inhoud);
    }

    @Als("^gezocht wordt op pathparam '(.*)' met waarde '(.*)'$")
    public void addPathParameterToRequest(String parameter, String inhoud) {
        sharedMessageSteps.opvragenGegevensObvPathparam(parameter, inhoud);
    }

    @En("^bevat de response '(.*)'$")
    public void bevatDeResponseGGMGpslatitudeminMoetGevuldZijn(String bevatMelding) {
        sharedMessageSteps.controlerenResponseBevatMelding(bevatMelding);
    }

    @En("^bevat de response niet '(.*)'$")
    public void bevatDeResponseNietAregar(String bevatNiet) {
        sharedMessageSteps.controlerenResponseBevatNiet(bevatNiet);
    }

    @En("^krijg ik aantal '(\\d+)' jsonpath '(.*)' terug$")
    public void krijgIkAantalJsonpathTerug(int aantal, String jsonPath) {
        sharedMessageSteps.controlerenAantal(aantal, jsonPath);
    }

    @En("^krijg ik minimaal aantal '(\\d+)' jsonpath '(.*)' terug$")
    public void krijgIkMinimaalAantalJsonpathTerug(int aantal, String jsonPath) {
        sharedMessageSteps.controlerenMinimumAantal(aantal, jsonPath);
    }

    @En("^bevat de jsonpath '(.*)' de waarde '(.*)'$")
    public void contrelerenJsonPathBevatWaarde(String jsonPath, String waarde) {
        sharedMessageSteps.contrelerenJsonPathBevatWaarde(jsonPath, waarde);
    }

}