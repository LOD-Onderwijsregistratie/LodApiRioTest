package nl.ocwduo.ggm.testautomatisering.messageutils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.text.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.*;

import static org.apache.commons.lang3.StringUtils.trimToNull;

public class MessageFormatter {

    private static final Logger log = LoggerFactory.getLogger(MessageFormatter.class);

    /**
     * Format a message and make it safe for HTML (replace special characters with HTML safe versions for correct display)
     *
     * @param message the message as a String
     * @return formatted string with HTML characters escaped
     */
    public static String htmlFormatMessage(String message) {
        if (trimToNull(message) == null) {
            return message;
        }

        return StringEscapeUtils.ESCAPE_HTML4.translate(prettyFormatMessage(message)).replace(" ", "&nbsp;");

    }

    /**
     * Format a message with correct line indents for readability
     *
     * @param message the message as a String
     * @return formatted string
     */
    public static String prettyFormatMessage(String message) {
        if (trimToNull(message) == null) {
            return message;
        } else if (message.contains("<html>")) {
            return message;
        }
        else if (message.startsWith("<")) {
            message = prettyXmlFormat(message);
        } else if (message.startsWith("{") || message.startsWith("[")) {
            message = prettyJsonFormat(message);
        }
        return message;
    }

    /**
     * Deletes all the empty elements recursively in a Xml message
     *
     * @param message Xml message in plain text
     * @return formatted Xml in plain text
     */

    public static String deleteEmptyXmlElements(String message) {
        if (! trimToNull(message).startsWith("<")) {
            log.warn("MessageFormatter: You are trying to delete empty XML elements from a not XML message which is not possible.");
            return message;
        }
        String input = message.replace("\\r|\\n", "");

        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document document = db.parse(new InputSource(new StringReader(input)));

            while (getEmptyElements(document).getLength() > 0) {
                NodeList nl = getEmptyElements(document);
                for (int i = 0; i < nl.getLength(); ++ i) {
                    Node node = nl.item(i);
                    node.getParentNode().removeChild(node);
                }
            }

            Transformer transformer = TransformerFactory.newInstance().newTransformer();
            transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");
            StreamResult result = new StreamResult(new StringWriter());
            transformer.transform(new DOMSource(document), result);

            return result.getWriter().toString();
        } catch (Exception e) {
            throw new RuntimeException("MessageFormatter: Could not remove empty XML elements: ", e);
        }

    }

    /**
     * Removes illegal trailing comma's from JSON messages. Usually needed when building templates with
     * unclear conditional blocks which mean a comma may occur right before a closing bracket when some optional
     * variables are not filled.
     *
     * @param message JSON message as a String
     * @return the same message, but with illegal trailing commas removed
     */
    public static String deleteTrailingJsonCommas(String message) {
        StringBuilder stringBuilder = new StringBuilder(message);

        char[] charArray = message.toCharArray();

        char currentChar = ' ';
        char lastChar;
        int charIndex = 0;
        int quoteCounter = 0;

        List<Integer> deletions = new ArrayList<>();

        Set<Character> whitespaceCharacters = new HashSet<>(Arrays.asList(' ', '\t', '\n', '\r'));

        for (int i = 0; i < charArray.length; i++) {
            if (! whitespaceCharacters.contains(charArray[i])) {
                lastChar = currentChar;
                currentChar = charArray[i];
                if (lastChar == ',' && (currentChar == '}' || currentChar == ']') && (quoteCounter & 1) == 0) {
                    deletions.add(charIndex);
                } else if (currentChar == '"' && charArray[i - 1] != '\\') {
                    quoteCounter++;
                }
                charIndex = i;
            }
        }

        int offset = 0;
        for (Integer index : deletions) {
            //We need to offset our previous deletions, so we use the old value of offset and then increase it for this deletion
            stringBuilder.deleteCharAt(index - offset++);
        }

        return stringBuilder.toString();
    }

    private static NodeList getEmptyElements(Document document) throws XPathExpressionException {
        XPath xp = XPathFactory.newInstance().newXPath();
        return (NodeList) xp.evaluate("//*[normalize-space(.)=''and count(*) = 0]", document, XPathConstants.NODESET);
    }

    /**
     * Formats xml, removing white lines and
     * indents the xml correctly
     *
     * @param message Xml message in plain text with indent 4
     * @return formatted Xml in plain text
     */
    public static String prettyXmlFormat(String message) {
        return prettyXmlFormat(message, 4);
    }

    /**
     * Formats xml, removing white lines and
     * indents the xml correctly
     *
     * @param message Xml message in plain text
     * @param indent  integer how much you want your output to indent
     * @return formatted Xml in plain text
     */
    private static String prettyXmlFormat(String message, int indent) {
        try {
            String strippedXml = message.replace("\n", "").replace("\r", "").replaceAll(">\\s+<", "><");
            Source xmlInput = new StreamSource(new StringReader(strippedXml));

            // Setup pretty print options
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            //transformerFactory.setAttribute("indent-number", indent);
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", Integer.toString(indent));

            // Return pretty print xml string
            StringWriter stringWriter = new StringWriter();
            transformer.transform(xmlInput, new StreamResult(stringWriter));

            return stringWriter.toString();
        } catch (Exception e) {
            log.warn("[WARN] MessageFormatter: could not pretty format XML, returning unformatted message. Problem encountered: ",
                    e.getMessage());
        }
        return message;
    }

    /**
     * Formats Json, removing white lines and
     * indents the Json with the number you want
     *
     * @param message Json message in plain text
     * @return formatted Json as a string
     */
    public static String prettyJsonFormat(String message) {

        ObjectMapper mapper = new ObjectMapper();
        Object json;
        try {
            json = mapper.readValue(message, Object.class);
            return mapper.writerWithDefaultPrettyPrinter().writeValueAsString(json);
        } catch (IOException e) {
            log.warn("Exception while trying to pretty print: " + e.getMessage());
        }
        log.warn("JsonUtils: Message: " + message + " could not be pretty printed");
        return message;
    }

}


