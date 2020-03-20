package nl.ocwduo.ggm.messagesteps;

import cucumber.api.DataTable;
import net.thucydides.core.annotations.Shared;
import nl.ocwduo.ggm.messageobjects.LodApiMessage;
import nl.ocwduo.ggm.testautomatisering.rest.RestCallType;

import static nl.ocwduo.ggm.testautomatisering.rest.LODJsonUtils.getJsonPathResultAsString;
import static nl.ocwduo.ggm.testautomatisering.rest.LODJsonUtils.getJsonPathResultAsJsonArray;
import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.number.OrderingComparison.greaterThanOrEqualTo;
import static org.hamcrest.number.OrderingComparison.lessThan;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class SharedMessageSteps {

    @Shared
    LodApiMessage lodApiMessage;

//    public GGMRestMessage getRestMessage(){
//        return lodApiMessage;
//    }



    public void instellenSoortRequest(RestCallType request) {
        lodApiMessage.setRestCallType(request);
    }

    public void instellenEndpoint(String endpoint) {
        lodApiMessage.clearAllParams();
        lodApiMessage.setEndpoint(endpoint);
    }

    public void verstuurLodApiRequest() {
        lodApiMessage.sendMessage();
    }

    public void controlerenStatuscodeLodApi(int statuscode) {
        assertThat(lodApiMessage.getResponse().getStatusCode(), equalTo(statuscode));
    }

    public void controleerInhoudVanDeResponse(DataTable attribuutWaardeMap, String jsonPath) {
        attribuutWaardeMap
                .asMap(String.class, String.class)
                .forEach((attribuut, waarde) -> controleerVoorkomenAttribuutMetWaarde(attribuut, waarde, jsonPath));
    }

    private void controleerVoorkomenAttribuutMetWaarde(String attribuut, String waarde, String jsonPath) {
        boolean isLeeg = getJsonPathResultAsJsonArray(
                lodApiMessage.getResponseBody(), "$.." + jsonPath + "[?(@." + attribuut + " == " + waarde + ")]").isEmpty();
        assertFalse("Attribuut " + attribuut + " met waarde: " + waarde + " is niet gevonden", isLeeg);
    }

    public void opvragenGegevensObvQueryparam(String parameter, String inhoud) {
        lodApiMessage.addQueryParam(parameter, inhoud);
    }
    public void opvragenGegevensObvPathparam(String pathParam, String paramWaarde) {
        lodApiMessage.addPathParam(pathParam, paramWaarde);
    }

    public void controlerenResponseBevatMelding(String bevatMelding) {
        assertThat(lodApiMessage.getResponseAsString(), containsString(bevatMelding));
    }

    public void controlerenResponseBevatNiet(String bevatNiet) {
        assertThat(lodApiMessage.getResponseAsString(), not(containsString(bevatNiet)));
    }

    public void controlerenAantal(int aantal, String jsonPath) {
        assertEquals(aantal, getJsonPathResultAsJsonArray(lodApiMessage.getResponseBody(), jsonPath).size());
    }

    public void controlerenMinimumAantal(int aantal, String jsonPath) {
        assertThat(getJsonPathResultAsJsonArray(lodApiMessage.getResponseBody(), jsonPath).size(), is(greaterThanOrEqualTo(aantal)));
    }

    public void contrelerenJsonPathBevatWaarde(String jsonPath, String waarde) {
        assertThat(getJsonPathResultAsString(lodApiMessage.getResponseBody(), jsonPath), containsString(waarde));
    }

}

