package nl.ocwduo.ggm.testautomatisering.rest;


import com.jayway.jsonpath.Predicate;
import io.restassured.response.ResponseBodyData;
import net.minidev.json.JSONArray;
import com.jayway.jsonpath.JsonPath;

public class LODJsonUtils {


        /**
         * Get the value of a node from a JSON message
         *
         * @param response The ResponseBodyData in which to search for a value - will match any TMF or RestAssured Response
         * @param jsonNode The string presentation of the to find node
         * @return the found value
         */
        public static String getJsonValue(ResponseBodyData response, String jsonNode) {
            return getJsonValue(response.asString(), jsonNode);
        }


        /**
         * Get the value of a node from a JSON message
         *
         * @param jsonMsg  The message in which to search
         * @param jsonNode The string presentation of the node to find
         * @return the found value
         */
        public static String getJsonValue(String jsonMsg, String jsonNode) {
            return getJsonValue(jsonMsg, jsonNode, 0);
        }

        /**
         * Get the value of a [index]nth found node from a JSON message
         *
         * @param response The ResponseBodyData in which to search for a value - will match any TMF or RestAssured Response
         * @param jsonNode The to find node
         * @param index    get the [index]nth found element
         * @return the found value
         */
        public static String getJsonValue(ResponseBodyData response, String jsonNode, int index) {
            return getJsonValue(response.asString(), jsonNode, index);
        }

        /**
         * Get a value from a JSON with a JsonPath
         * <p>
         * Explanation of JsonPath: http://goessner.net/articles/JsonPath/
         *
         * @param jsonMsg  The message in which to search
         * @param jsonPath The string presentation of the node to find
         * @return the found value as a string
         */
        public static String getJsonPathResultAsString(String jsonMsg, String jsonPath) {
            return (JsonPath.read(jsonMsg, jsonPath, new Predicate[10])).toString();
        }

        /**
         * Get a value from a JSON with a JsonPath
         * <p>
         * Explanation of JsonPath: http://goessner.net/articles/JsonPath/
         *
         * @param response The ResponseBodyData in which to search for a value - will match any TMF or RestAssured Response
         * @param jsonPath The string presentation of the to find node
         * @return the found value as a string
         */
        public static String getJsonPathResultAsString(ResponseBodyData response, String jsonPath) {
            return getJsonPathResultAsString(response.asString(), jsonPath);
        }

        /**
         * Get an object from a JSON with a JsonPath
         * <p>
         * Explanation of JsonPath: http://goessner.net/articles/JsonPath/
         *
         * @param jsonMsg  The response in which to search for a value
         * @param jsonPath The string presentation of the node to find
         * @return the found value as an object
         */
        public static <T> T getJsonPathResultAsObject(String jsonMsg, String jsonPath) {
            return JsonPath.read(jsonMsg, jsonPath, new Predicate[10]);
        }

        /**
         * Get an object from a JSON with a JsonPath
         * <p>
         * Explanation of JsonPath: http://goessner.net/articles/JsonPath/
         *
         * @param response The ResponseBodyData in which to search for a value - will match any TMF or RestAssured Response
         * @param jsonPath he string presentation of the to find node
         * @return the found value as an object
         */
        public static <T> T getJsonPathResultAsObject(ResponseBodyData response, String jsonPath) {
            return getJsonPathResultAsObject(response.asString(), jsonPath);
        }

        /**
         * Get  a Json Array from a JSON with a JsonPath
         * <p>
         * Explanation of JsonPath: http://goessner.net/articles/JsonPath/
         *
         * @param jsonMsg  The message in which to search
         * @param jsonPath The string presentation of the node to find
         * @return the found value as an array
         */
        public static JSONArray getJsonPathResultAsJsonArray(String jsonMsg, String jsonPath) {
            return JsonPath.read(jsonMsg, jsonPath, new Predicate[10]);
        }

        /**
         * Get a Json Array from a JSON with a JsonPath
         * <p>
         * Explanation of JsonPath: http://goessner.net/articles/JsonPath/
         *
         * @param response The response in which to search for a value
         * @param jsonPath The string presentation of the node to find
         * @return the found value as an array
         */
        public static JSONArray getJsonPathResultAsJsonArray(ResponseBodyData response, String jsonPath) {
            return getJsonPathResultAsObject(response.asString(), jsonPath);
        }

        /**
         * Get a value of a node from a JSON message
         *
         * @param jsonMsg  The JSON message in which to search for a value
         * @param jsonNode The string presentation of the node to find
         * @param index    get the [index]nth found element
         * @return the found value
         */
        public static String getJsonValue(String jsonMsg, String jsonNode, int index) {
            String jsonPath = "$..['" + jsonNode + "']";
            JSONArray resultList = JsonPath.read(jsonMsg, jsonPath, new Predicate[10]);
            if (resultList == null || resultList.isEmpty()) {
                throw new RuntimeException("JsonUtils: Invalid jsonNode, no results found");
            }
            if (index < 0 || index >= resultList.size()) {
                throw new RuntimeException(
                        "JsonUtils: Invalid index[" + index + "], size of results: " + resultList.size()
                                + ". Reminder: Element indexes start at 0.");
            }
            return String.valueOf(resultList.get(index));
        }

        /**
         * @param response   The JSON respons object you want to validate
         * @param schemaName to validate the the json message
         * @return true if the json is valid according to the schema
         * false if not
         */
//        public static Boolean validateJsonWithSubScheme(ResponseBodyData response, String schemaName) {
//            return validateJsonWithSubScheme(response.asString(), schemaName);
//        }

        /**
         * @param jsonMsg    The JSON message to validate as a string
         * @param schemaName to validate the the json message
         * @return true if the json is valid according to the schema
         * false if not
         */
//        public static Boolean validateJsonWithSubScheme(String jsonMsg, String schemaName) {
//            JsonSchemaFactory factory = JsonSchemaFactory.byDefault();
//            File jsonSchemaFile = new File(FileUtils.SCHEME_PATH + schemaName);
//            JsonNode response;
//            try {
//                response = JsonLoader.fromString(jsonMsg);
//            } catch (IOException e) {
//                throw new RuntimeException("JsonUtils: error reading JSON from String", e);
//            }
//
//            URI uri = jsonSchemaFile.toURI();
//            JsonSchema schema;
//            try {
//                schema = factory.getJsonSchema(uri.toString());
//                ProcessingReport report;
//                report = schema.validate(response);
//                if (report.isSuccess()) {
//                    log.debug("json is succesvol gevalideerd tegen schema '" + schemaName + "'");
//                    return true;
//                }
//
//                String warningText = report.toString();
//                warningText = warningText.substring(warningText.indexOf("--- BEGIN MESSAGES ---"));
//                log.warn("De json faalde bij validatie tegen schema '" + schemaName + "'");
//                int reportsize = 0;
//                for (Object obj : report)
//                    reportsize++;
//                log.warn("aantal foutmeldingen: " + reportsize);
//                log.warn("Rapport van schema validatie:\n\n" + warningText + "\n\n");
//            } catch (ProcessingException e) {
//                throw new MessageUtilsConfigurationRuntimeException(
//                        "JsonUtils: Could not validate JSON, make sure that this file: " + schemaName
//                                + " ,is an exact match with the filename (incl. extension) in the schemas directory", e);
//            }
//            return false;
//        }
    }




