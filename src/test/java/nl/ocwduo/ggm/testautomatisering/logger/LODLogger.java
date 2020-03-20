package nl.ocwduo.ggm.testautomatisering.logger;

import nl.ocwduo.ggm.testautomatisering.reporting.LODReportWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.Marker;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

public class LODLogger implements Logger{

    private static boolean optionalAsInfo = true;
    private static final String trackAndTrace = UUID.randomUUID().toString();
    private static BufferedWriter bufferedWriter;
    private Logger baseLogger;
    private LODLogger.TraceEvent lastTrace;

    LODLogger(Class clazz) {
        this.baseLogger = LoggerFactory.getLogger(clazz);
    }

    public static boolean getOptionalAsInfo() {
        return optionalAsInfo;
    }

    public static void setOptionalAsInfo(boolean optionalAsInfo) {
        LODLogger.optionalAsInfo = optionalAsInfo;
    }

    public String getName() {
        return this.getClass().getName();
    }

    public boolean isTraceEnabled() {
        return this.baseLogger.isTraceEnabled();
    }

    public void trace(String s) {
        this.baseLogger.trace(s);
    }

    public void trace(String s, Object o) {
        this.baseLogger.trace(s, o);
    }

    public void trace(String s, Object o, Object o1) {
        this.baseLogger.trace(s, o, o1);
    }

    public void trace(String s, Object... objects) {
        this.baseLogger.trace(s, objects);
    }

    public void trace(String s, Throwable throwable) {
        this.baseLogger.trace(s, throwable);
    }

    public boolean isTraceEnabled(Marker marker) {
        return this.baseLogger.isTraceEnabled(marker);
    }

    public void trace(Marker marker, String s) {
        if (marker.equals(LODLogMarker.TRACE.getMarker())) {
            String[] traceArray = s.split("\\(");
            LODLogger.TraceEvent traceEvent = new LODLogger.TraceEvent(traceArray[0], traceArray.length > 1 ? (traceArray[1].split("\\)").length > 0 ? traceArray[1].split("\\)")[0] : "") : "", Instant.now());
            if (this.lastTrace != null && this.lastTrace.getLogTime().isBefore(Instant.now().minusMillis(500L))) {
                this.lastTrace = null;
            }

            try {
                if (bufferedWriter == null) {
                    File logDir = new File("target/logs");
                    if (!logDir.exists()) {
                        logDir.mkdirs();
                    }

                    File logFile = new File("target/logs/ta_logging.log");
                    if (!logFile.exists()) {
                        logFile.createNewFile();
                    }

                    bufferedWriter = new BufferedWriter(new FileWriter(logFile));
                    this.writeToFile(logFile.getAbsolutePath(), "ProjectPath");
                }

                if (this.lastTrace != null && this.lastTrace.getMethodName().equals(traceEvent.getMethodName()) && !this.lastTrace.getMethodArgs().equals(traceEvent.getMethodArgs())) {
                    this.writeToFile(s, "Overloading");
                } else {
                    this.writeToFile(s, "InitialCall");
                    this.lastTrace = traceEvent;
                }
            } catch (IOException var7) {
                this.baseLogger.trace(var7.getMessage());
            }
        } else {
            this.baseLogger.trace(marker, s);
        }

    }

    private void writeToFile(String s, String t) throws IOException {
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss,SSS");
        String separator = " ^ ";
        bufferedWriter.append(LocalDateTime.now().format(dateTimeFormatter) + " ^ " + "TRACE" + " ^ " + t + " ^ " + this.baseLogger.getName() + " ^ " + s + " ^ " + trackAndTrace + " ^ " + " ^ " + "TA" + " ^ " + "\n");
        bufferedWriter.flush();
    }

    public void trace(Marker marker, String s, Object o) {
        this.baseLogger.trace(marker, s, o);
    }

    public void trace(Marker marker, String s, Object o, Object o1) {
        this.baseLogger.trace(marker, s, o, o1);
    }

    public void trace(Marker marker, String s, Object... objects) {
        this.baseLogger.trace(marker, s, objects);
    }

    public void trace(LODLogMarker marker, String s) {
        this.trace(marker.getMarker(), s);
    }

    public void trace(Marker marker, String s, Throwable throwable) {
        this.baseLogger.trace(marker, s, throwable);
    }

    public void debugAndWriteToReport(String message) {
        this.debugAndWriteToReport("Detail", message);
    }

    public void debugAndWriteToReport(String title, String message) {
        LODReportWriter.writeToReport(title, message);
        this.debug(title + "\n" + message);
    }

    public boolean isDebugEnabled() {
        return this.baseLogger.isDebugEnabled();
    }

    public void debug(String s) {
        this.baseLogger.debug(s);
    }

    public void debug(String s, Object o) {
        this.baseLogger.debug(s, o);
    }

    public void debug(String s, Object o, Object o1) {
        this.baseLogger.debug(s, o, o1);
    }

    public void debug(String s, Object... objects) {
        this.baseLogger.debug(s, objects);
    }

    public void debug(String s, Throwable throwable) {
        this.baseLogger.debug(s, throwable);
    }

    public boolean isDebugEnabled(Marker marker) {
        return this.baseLogger.isDebugEnabled(marker);
    }

    public void debug(Marker marker, String s) {
        this.baseLogger.debug(marker, s);
    }

    public void debug(Marker marker, String s, Object o) {
        this.baseLogger.debug(marker, s, o);
    }

    public void debug(Marker marker, String s, Object o, Object o1) {
        this.baseLogger.debug(marker, s, o, o1);
    }

    public void debug(Marker marker, String s, Object... objects) {
        this.baseLogger.debug(marker, s, objects);
    }

    public void debug(Marker marker, String s, Throwable throwable) {
        this.baseLogger.debug(marker, s, throwable);
    }

    public boolean isInfoEnabled() {
        return this.baseLogger.isInfoEnabled();
    }

    public void info(String s) {
        this.baseLogger.info(s);
    }

    public void info(String s, Object o) {
        this.baseLogger.info(s, o);
    }

    public void info(String s, Object o, Object o1) {
        this.baseLogger.info(s, o, o1);
    }

    public void info(String s, Object... objects) {
        this.baseLogger.info(s, objects);
    }

    public void info(String s, Throwable throwable) {
        this.baseLogger.info(s, throwable);
    }

    public boolean isInfoEnabled(Marker marker) {
        return marker.getName().equals("TAOptional") && !optionalAsInfo ? this.baseLogger.isDebugEnabled() : this.baseLogger.isInfoEnabled(marker);
    }

    public void info(LODLogMarker marker, String s) {
        this.info(marker.getMarker(), s);
    }

    public void info(Marker marker, String s) {
        if (marker.getName().equals("TAOptional") && !optionalAsInfo) {
            this.baseLogger.debug(marker, s);
        } else {
            this.baseLogger.info(marker, s);
        }

    }

    public void info(Marker marker, String s, Object o) {
        if (marker.getName().equals("TAOptional") && !optionalAsInfo) {
            this.baseLogger.debug(marker, s, o);
        } else {
            this.baseLogger.info(marker, s, o);
        }

    }

    public void info(Marker marker, String s, Object o, Object o1) {
        if (marker.getName().equals("TAOptional") && !optionalAsInfo) {
            this.baseLogger.debug(marker, s, o, o1);
        } else {
            this.baseLogger.info(marker, s, o, o1);
        }

    }

    public void info(Marker marker, String s, Object... objects) {
        if (marker.getName().equals("TAOptional") && !optionalAsInfo) {
            this.baseLogger.info(marker, s, objects);
        } else {
            this.baseLogger.info(marker, s, objects);
        }

    }

    public void info(Marker marker, String s, Throwable throwable) {
        if (marker.getName().equals("TAOptional") && !optionalAsInfo) {
            this.baseLogger.info(marker, s, throwable);
        } else {
            this.baseLogger.info(marker, s, throwable);
        }

    }

    public boolean isWarnEnabled() {
        return this.baseLogger.isWarnEnabled();
    }

    public void warn(String s) {
        this.baseLogger.warn(s);
    }

    public void warn(String s, Object o) {
        this.baseLogger.warn(s, o);
    }

    public void warn(String s, Object... objects) {
        this.baseLogger.warn(s, objects);
    }

    public void warn(String s, Object o, Object o1) {
        this.baseLogger.warn(s, o, o1);
    }

    public void warn(String s, Throwable throwable) {
        this.baseLogger.warn(s, throwable);
    }

    public boolean isWarnEnabled(Marker marker) {
        return this.baseLogger.isWarnEnabled(marker);
    }

    public void warn(Marker marker, String s) {
        this.baseLogger.warn(marker, s);
    }

    public void warn(Marker marker, String s, Object o) {
        this.baseLogger.warn(marker, s, o);
    }

    public void warn(Marker marker, String s, Object o, Object o1) {
        this.baseLogger.warn(marker, s, o, o1);
    }

    public void warn(Marker marker, String s, Object... objects) {
        this.baseLogger.warn(marker, s, objects);
    }

    public void warn(Marker marker, String s, Throwable throwable) {
        this.baseLogger.warn(marker, s, throwable);
    }

    public boolean isErrorEnabled() {
        return this.baseLogger.isErrorEnabled();
    }

    public void error(String s) {
        this.baseLogger.error(s);
    }

    public void error(String s, Object o) {
        this.baseLogger.error(s, o);
    }

    public void error(String s, Object o, Object o1) {
        this.baseLogger.error(s, o1);
    }

    public void error(String s, Object... objects) {
        this.baseLogger.error(s, objects);
    }

    public void error(String s, Throwable throwable) {
        this.baseLogger.error(s, throwable);
    }

    public boolean isErrorEnabled(Marker marker) {
        return this.baseLogger.isErrorEnabled(marker);
    }

    public void error(Marker marker, String s) {
        this.baseLogger.error(marker, s);
    }

    public void error(Marker marker, String s, Object o) {
        this.baseLogger.error(marker, s, o);
    }

    public void error(Marker marker, String s, Object o, Object o1) {
        this.baseLogger.error(marker, s, o, o1);
    }

    public void error(Marker marker, String s, Object... objects) {
        this.baseLogger.error(marker, s, objects);
    }

    public void error(Marker marker, String s, Throwable throwable) {
        this.baseLogger.error(marker, s, throwable);
    }

    private class TraceEvent {
        private String methodName;
        private String methodArgs;
        private Instant logTime;

        public TraceEvent(String methodName, String methodArgs, Instant logTime) {
            this.methodName = methodName;
            this.methodArgs = methodArgs;
            this.logTime = logTime;
        }

        public String getMethodName() {
            return this.methodName;
        }

        public String getMethodArgs() {
            return this.methodArgs;
        }

        public Instant getLogTime() {
            return this.logTime;
        }
    }

}
