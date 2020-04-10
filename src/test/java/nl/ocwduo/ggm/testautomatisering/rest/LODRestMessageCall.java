package nl.ocwduo.ggm.testautomatisering.rest;

import io.restassured.RestAssured;
import io.restassured.config.LogConfig;
import io.restassured.internal.RestAssuredResponseImpl;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import nl.ocwduo.ggm.testautomatisering.logger.LODLogMarker;
import nl.ocwduo.ggm.testautomatisering.logger.LODLogger;
import nl.ocwduo.ggm.testautomatisering.logger.LODLoggerFactory;
import nl.ocwduo.ggm.testautomatisering.messageutils.MessageFormatter;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.MarkerFactory;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;
import static io.restassured.RestAssured.given;

/**
 * The REST message that can be used to fill and send to an endpoint.
 */
public class LODRestMessageCall {

    private RestCallType restCallType = null;
    private boolean isInitialized;
    private boolean useAuthentication = false;
    private Response response;
    private String endpoint = "";
    private String baseUri = "";
    private String body = "";
    private String accept = "";
    private File multiPartFile;
    private String multiPartKey = "";
    private String usr = "";
    private String pwd = "";
    private Map<String, String> headers = new HashMap<>();
    private Map<String, String> pathParams = new HashMap<>();
    private Map<String, String> params = new HashMap<>();
    private Map<String, String> formParams = new HashMap<>();
    private Map<String, Object> queryParams = new HashMap<>();
    private RequestSpecification reqSpec;

    private String requestMessage;
    private String responsMessage;

    private static final LODLogger log = LODLoggerFactory.getLogger(LODRestMessageCall.class);
    ByteArrayOutputStream outContent = new ByteArrayOutputStream();

    static {
        RestAssured.useRelaxedHTTPSValidation();
    }

    /**
     * Creating a messageCall
     */
    public LODRestMessageCall() {
        reqSpec = given();
        log.trace(LODLogMarker.TRACE, "LODRestMessageCall()");

    }
    
    /**
     * {@inheritDoc}
     */
    public boolean initialize() {

        if (! isInitialized) {
            if (null == endpoint || endpoint.isEmpty()) {
                throw new RuntimeException("Cannot send a Restmessage without endpoint. Please fill in a Endpoint");
            }
            if (pathParams.size() > 0) {
                addRequestSpecifications().pathParams(pathParams);
            }
            if (params.size() > 0) {
                addRequestSpecifications().params(params);
            }
            if (queryParams.size() > 0) {
                for (Map.Entry<String, Object> entry : queryParams.entrySet()) {
                    String key = entry.getKey();
                    Object[] qValues = ((Object[]) queryParams.get(key));

                    StringJoiner sj = new StringJoiner(",");
                    for (Object val : qValues) {
                        sj.add("" + val);
                        this.addRequestSpecifications().queryParam(key, val.toString());
                    }
                }
            }
            if (useAuthentication) {
                this.addRequestSpecifications().auth().preemptive().basic(usr, pwd);
            }
            addRequestSpecifications().baseUri(baseUri).headers(headers).accept(accept);

            this.isInitialized = true;
        }
        return true;
    }

    /**
     * {@inheritDoc}
     */
    public boolean sendMessage() {
        log.trace(LODLogMarker.TRACE, "sendMessage()");
        initialize();
        if (restCallType == null) {
            throw new RuntimeException("Please set restCallType before calling sendMessage");
        }

        // ByteArrayOutputStream outContent = new ByteArrayOutputStream();
        this.addRequestSpecifications().config(RestAssured.config().logConfig(new LogConfig().defaultStream(new PrintStream(outContent))));
        this.addRequestSpecifications().request().log().all();
        switch (restCallType) {
            case GET:
                response = addRequestSpecifications()
                        .get(endpoint).andReturn();
                break;
            case POST:
                if (formParams.size() > 0) {
                    response = addRequestSpecifications()
                            .formParams(formParams)
                            .when()
                            .post(endpoint).andReturn();
                } else {
                    response = addRequestSpecifications()
                            .body(body).when()
                            .post(endpoint).andReturn();
                }
                break;
            case DELETE:
                response = addRequestSpecifications()
                        .body(body).when()
                        .delete(endpoint).andReturn();
                break;
            case PUT:
                response = addRequestSpecifications()
                        .body(body).when()
                        .put(endpoint).andReturn();
                break;
            case POST_MP_FILE:
                if (multiPartKey.equals("")) {
                    response = addRequestSpecifications()
                            .multiPart(multiPartFile).when()
                            .post(endpoint).andReturn();
                } else {
                    if (formParams.size() > 0) {
                        addRequestSpecifications().formParams(formParams);
                    }
                    response = addRequestSpecifications()
                            .multiPart(multiPartKey, multiPartFile).when()
                            .post(endpoint).andReturn();
                }
                break;
            case PATCH:
                response = addRequestSpecifications()
                        .body(body).when()
                        .patch(endpoint).andReturn();
        }

        // Haal de gegevens uit het response voor het rapport en maak er een nette string van
        String status = "\nStatus: " + ((RestAssuredResponseImpl) this.response).getGroovyResponse().getStatusLine();
        String headers = "\nHeaders: " + ((RestAssuredResponseImpl) this.response).getGroovyResponse().getResponseHeaders();
        headers = headers.replace("\n", "\n         ").replace("\n         Headers:", "\nHeaders:");
        String content = "\nResponsBody:\n" + MessageFormatter.prettyFormatMessage(((RestAssuredResponseImpl) this.response).getGroovyResponse().asString());
        StringBuilder responsBuilder = new StringBuilder();
        responsBuilder.append("\n--------Response--------").append(status).append(headers).append(content);

        // Request voor het rapport
        log.debugAndWriteToReport("Request", MessageFormatter.prettyFormatMessage(outContent.toString()));
        setLockStockAndBarrelRequestMessage(MessageFormatter.prettyFormatMessage("\n--------Request--------\n" + outContent.toString()));
        // Log request voor console
        log.info(MarkerFactory.getMarker("TAOptional"), MessageFormatter.prettyFormatMessage("\n--------REQUEST--------\n" + outContent.toString()));

        outContent.reset();

        // Response voor het rapport
        log.debugAndWriteToReport("Response", MessageFormatter.htmlFormatMessage(responsBuilder.toString()));
        setLockStockAndBarrelResponsMessage(responsBuilder.toString());
        // Log request voor console
        log.info(MarkerFactory.getMarker("TAOptional"), MessageFormatter.prettyFormatMessage(responsBuilder.toString()));


        return true;

    }

    /**
     * {@inheritDoc}
     */
    public boolean sendMessage(RestCallType restCallType) {
        log.trace(LODLogMarker.TRACE, "sendMessage(RestCallType restCallType)");
        setRestCallType(restCallType);
        return sendMessage();
    }

    /**
     * {@inheritDoc}
     */
    public boolean sendMessage(String body) {
        log.trace(LODLogMarker.TRACE, "sendMessage(String body)");
        this.body = body;
        return sendMessage();
    }

    /**
     * {@inheritDoc}
     */
    public boolean sendMessage(String body, RestCallType restCallType) {
        log.trace(LODLogMarker.TRACE, "sendMessage(String body, RestCallType restCallType)");
        this.body = body;
        setRestCallType(restCallType);
        return sendMessage();
    }

    /**
     * Set the restcall type (For example: GET or POST)
     * if this function is used to change the restcallType
     * all parameters will be cleared
     *
     * @param restCallType enum for the types
     */
    public void setRestCallType(RestCallType restCallType) {
        log.trace(LODLogMarker.TRACE, "setRestCallType(RestCallType restCallType)");
        this.restCallType = restCallType;
    }

    /**
     * Clear the params, pathParams and queryParams on this messageCall. All other values, such
     * as Endpoint and RestCallType are kept.
     * Except items that are added via addRequestSpecifications()
     */
    public void clearAllParams() {
        log.trace(LODLogMarker.TRACE, "clearAllParams()");
        pathParams.clear();
        params.clear();
        formParams.clear();
        queryParams.clear();
        this.isInitialized = false;
        reqSpec = given();
    }

    /**
     * The endpoint to where to calls get send to.
     * This is required for a correct call
     * proper use is to set the path and the query
     * part of the URL via setEndpoint, and the rest
     * (hostname and port for example) via setBaseUri
     *
     * @param endpoint the String presentation of the endpoint
     */
    public void setEndpoint(String endpoint) {
        log.trace(LODLogMarker.TRACE, "setBody(String body)");
        this.endpoint = endpoint;
    }

    /**
     * The content of the message as a string
     *
     * @param body body of the message as a String
     */
    public void setBody(String body) {
        log.trace(LODLogMarker.TRACE, "getRequestBody()");
        this.body = body;
    }

    /**
     * Return the original body from the request
     *
     * @return a string containing the request body
     */
    public String getRequestBody() {

        return this.body;
    }

    /**
     * The content of the message as a File (for MultiPart sending)
     *
     * @param multiPartFile The MultiPart File
     */
    public void setBody(File multiPartFile) {
        log.trace(LODLogMarker.TRACE, "setBody(File multiPartFile)");
        this.multiPartFile = multiPartFile;
    }

    /**
     * Set the content to send a message as multi-part formdata with a key as well as a file
     *
     * @param key           the formdata key for the file
     * @param multiPartFile The MultiPart File
     */
    public void setBody(String key, File multiPartFile) {
        log.trace(LODLogMarker.TRACE, "setBody(String key, File multiPartFile)");
        this.multiPartKey = key;
        this.multiPartFile = multiPartFile;
    }

    /**
     * Set the accept criteria for the response
     *
     * @param accept value in String
     */
    public void setAccept(String accept) {
        log.trace(LODLogMarker.TRACE, "setAccept(String accept)");
        this.accept = accept;
    }

    /**
     * Get the accept value
     *
     * @return accept value as a String
     */
    public String getAccept() {
        log.trace(LODLogMarker.TRACE, "getAccept()");
        return this.accept;
    }

    /**
     * Add a header to the call
     *
     * @param key   key of the header
     * @param value value of the header
     */
    public void addHeader(String key, String value) {
        log.trace(LODLogMarker.TRACE, "addHeader(String key, String value)");
        this.headers.put(key, value);
    }

    /**
     * Add a Query parameter to the call.
     *
     * @param key    key as string
     * @param values one to many values allowed
     */
    public void addQueryParam(String key, Object... values) {
        log.trace(LODLogMarker.TRACE, "addQueryParam(String key, Object... values)");
        this.queryParams.put(key, values);
    }

    /**
     * Add a Query parameter to the call.
     *
     * @param params map with key values of te params that must be add
     */

    public void addQueryParams(Map<String, Object> params) {
        log.trace(LODLogMarker.TRACE, "addQueryParam(Map<String, String> params)");
        for (Map.Entry<String, Object> param : params.entrySet()) {
            Object[] values = new Object[1];
            values[0] = param.getValue();
            this.queryParams.put(param.getKey(), values);

        }
    }

    /**
     * Add a form parameter to the call, use if your call needs to send 'form-data'
     *
     * @param key   key as string
     * @param value value as string
     */
    public void addFormParam(String key, String value) {
        log.trace(LODLogMarker.TRACE, "addFormParam(String key, String value)");
        this.formParams.put(key, value);
    }

    /**
     * Identical to the setBody with key and file, but better name for a formdata context
     *
     * @param key           key as string
     * @param multiPartFile the file that will be the value for this key
     */
    public void addFormParam(String key, File multiPartFile) {
        log.trace(LODLogMarker.TRACE, "(String key, File multiPartFile)");
        this.setBody(key, multiPartFile);
    }

    /**
     * Add Basic Authentication to the call.
     *
     * @param username username as string
     * @param password password as string
     */
    public void addBasicAuthentication(String username, String password) {
        log.trace(LODLogMarker.TRACE, "addBasicAuthentication(String username, String password)");
        if (StringUtils.isBlank(username)) {
            log.warn("Username is blank, make sure you use a valid username");
        }
        if (StringUtils.isBlank(password)) {
            log.warn("Password is blank, make sure you use a valid Password");
        }
        this.usr = username;
        this.pwd = password;
        this.useAuthentication = true;
    }

    /**
     * Return the original baseUri
     *
     * @return a string containing the baseUri
     */
    public String getBaseUri() {
        log.trace(LODLogMarker.TRACE, "getBaseUri()");
        return baseUri;
    }

    /**
     * Add the baseUri for the RestMessage calls
     * is to be used in combination with setEndpoint
     *
     * @param baseUri baseUri as string
     */
    public void setBaseUri(String baseUri) {
        log.trace(LODLogMarker.TRACE, "setBaseUri(String baseUri)");
        this.baseUri = baseUri;
    }

    /**
     * Add a Path parameter to the call
     *
     * @param key   key as string
     * @param value value as string
     */
    public void addPathParam(String key, String value) {
        log.trace(LODLogMarker.TRACE, "addPathParam(String key, String value)");
        pathParams.put(key, value);
    }

    /**
     * Add a parameter to the call.
     *
     * @param key   key as string
     * @param value one to many values allowed
     */
    public void addParam(String key, String value) {
        log.trace(LODLogMarker.TRACE, "addParam(String key, String value)");
        params.put(key, value);
    }

    /**
     * Return the original set of params
     *
     * @return the map of header params
     */
    public Map<String, String> getParams() {
        log.trace(LODLogMarker.TRACE, "getParams()");
        return this.params;
    }

    /**
     * Return the original set of queryparams
     *
     * @return the map of header queryparams
     */
    public Map<String, Object> getQueryParams() {
        log.trace(LODLogMarker.TRACE, "getQueryParams()");
        return this.queryParams;
    }

    /**
     * Return the formdata params added to this messagecall
     *
     * @return Map of FormData params
     */
    public Map<String, String> getFormParams() {
        log.trace(LODLogMarker.TRACE, "getFormParams()");
        return this.formParams;
    }

    /**
     * Return the username and password which has been used for basic authentication
     *
     * @return the username and password which has been used for basic authentication
     */
    public String getBasicAuthentication() {
        log.trace(LODLogMarker.TRACE, "getBasicAuthentication()");
        return ("You are trying to athenticate with username: " + usr + " and password: " + pwd);
    }

    /**
     * Return the original set of Headers
     *
     * @return the map of header params
     */
    public Map<String, String> getHeaders() {
        log.trace(LODLogMarker.TRACE, "getHeaders()");
        return this.headers;
    }

    /**
     * Return the original set of PathParams
     *
     * @return the map of header params
     */
    public Map<String, String> getPathParams() {
        log.trace(LODLogMarker.TRACE, "getPathParams()");
        return this.pathParams;
    }

    /**
     * {@inheritDoc}
     */
    public Response getResponse() {
        log.trace(LODLogMarker.TRACE, "getResponse()");
        return this.response;
    }

    /**
     * Get the response of the message as a String
     *
     * @return response as String
     */
    public String getResponseAsString() {
        log.trace(LODLogMarker.TRACE, "getResponseAsString()");
        return this.response.asString();
    }

    /**
     * Get the body of the response as a readable String
     *
     * @return body as String
     */
    public String getResponseBody() {
        log.trace(LODLogMarker.TRACE, "getResponseBody()");
        return this.response.getBody().asString();
    }

    /**
     * Get the body of the response as a readable String
     *
     * @return body as String
     */
    public String getEndpoint() {
        log.trace(LODLogMarker.TRACE, "getEndpoint()");
        return this.endpoint;
    }

    /**
     * Get the body of the response as a readable String
     *
     * @return body as String
     */
    public RestCallType getRestCallType() {
        log.trace(LODLogMarker.TRACE, "getRestCallType()");
        return this.restCallType;
    }

    /**
     * Reset the restMessageCall, by clearing
     * endpoint, baseUri, body, accept, multiPartFile,
     * restCallType, headers, authentication, pathParams,
     * queryParams and params
     * <p>
     * most of the time a change of restCallType
     * will be sufficient for testing restMessageCalls
     */
    public void resetRestMessage() {
        this.endpoint = "";
        this.baseUri = "";
        this.body = "";
        this.accept = "";
        this.multiPartFile = null;
        this.multiPartKey = "";
        this.headers.clear();
        this.pathParams.clear();
        this.params.clear();
        this.formParams.clear();
        this.queryParams.clear();
        this.restCallType = null;
        isInitialized = false;
        useAuthentication = false;
        reqSpec = given();
        log.trace(LODLogMarker.TRACE, "resetRestMessage()");

    }

    /**
     * Avoid using this method if possible. This should only be used when the basic functionality doesn't offer the needed functionality
     * Please inform us what you are missing.
     *
     * @return io.restassured.specification.RequestSpecification
     */
    public RequestSpecification addRequestSpecifications() {
        log.trace(LODLogMarker.TRACE, "addRequestSpecifications()");
        return this.reqSpec;
    }

    /**
     * Get the body and the headers
     * from the message that is sent
     * to a queue as a readable String.
     * Ideal for logging purposes
     *
     * @return requestmessage as String
     */
    public String getLockStockAndBarrelRequestMessage() {
        log.trace(LODLogMarker.TRACE, "getLockStockAndBarrelRequestMessage()");
        return this.requestMessage;
    }

    private void setLockStockAndBarrelRequestMessage(String requestMessage) {
        this.requestMessage = requestMessage;
    }

    /**
     * Get the body and the headers
     * from the message which is received
     * from a queue as a readable String.
     * Ideal for logging purposes
     *
     * @return responsMessage as String
     */
    public String getLockStockAndBarrelResponsMessage() {
        log.trace(LODLogMarker.TRACE, "getLockStockAndBarrelResponsMessage()");
        return responsMessage;
    }

    private void setLockStockAndBarrelResponsMessage(String responsMessage) {
        this.responsMessage = responsMessage;
    }
}
