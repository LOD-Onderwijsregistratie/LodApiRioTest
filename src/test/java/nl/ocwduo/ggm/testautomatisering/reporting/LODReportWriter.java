package nl.ocwduo.ggm.testautomatisering.reporting;

import net.serenitybdd.core.Serenity;
import nl.ocwduo.ggm.testautomatisering.logger.LODLogger;
import nl.ocwduo.ggm.testautomatisering.logger.LODLoggerFactory;

import java.lang.reflect.Method;

public class LODReportWriter {

    private static final LODLogger log = LODLoggerFactory.getLogger(LODReportWriter.class);
    private static boolean serenityEnabled = classExists("net.serenitybdd.core.Serenity") && methodExists(Serenity.class, "recordReportData");

    public LODReportWriter() {
    }

    public static void writeToReport(String title, String message) {
        if (serenityEnabled && Serenity.getStepListener() != null) {
            try {
                Serenity.recordReportData().withTitle(title).andContents(message);
            } catch (NullPointerException var3) {
                log.debug("Error trying to write Serenity report, disabling writing to Serenity");
                serenityEnabled = false;
                writeToReport(title, message);
            }
        } else if (LODScenarioStorage.getScenario() != null) {
            LODScenarioStorage.getScenario().write("--------" + title + "--------\n" + message);
        }

    }

    private static boolean classExists(String canonicalName) {
        try {
            Class clazz = Class.forName(canonicalName);
            return clazz != null;
        } catch (ClassNotFoundException var2) {
            log.debug("Class not found: " + canonicalName);
            return false;
        }
    }

    private static boolean methodExists(Class clazz, String methodName) {
        try {
            Method method = clazz.getMethod(methodName);
            return method != null;
        } catch (NoSuchMethodException var3) {
            log.debug("Method not found: " + methodName);
            return false;
        }
    }


}
