package nl.ocwduo.ggm.messageobjects;

import nl.ocwduo.ggm.testautomatisering.rest.LODRestMessageCall;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class LodApiMessage extends LODRestMessageCall {

    public LodApiMessage () {
        super ();
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        try (InputStream input = classloader.getResourceAsStream("test.properties")) {

            Properties prop = new Properties();

            // load a properties file
            prop.load(input);

            // get the property value and print it out
            this.setBaseUri(prop.getProperty("baseUri"));
            this.addHeader("x-api-key", prop.getProperty("x-api-key"));

        } catch (IOException ex) {
            ex.printStackTrace();
        }

    }

}

