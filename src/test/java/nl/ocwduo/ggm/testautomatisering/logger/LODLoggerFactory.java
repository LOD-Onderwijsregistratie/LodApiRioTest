package nl.ocwduo.ggm.testautomatisering.logger;

import java.util.HashMap;
import java.util.Map;

public class LODLoggerFactory {
    private static Map<Class, LODLogger> lodLoggerMap = new HashMap();

    public LODLoggerFactory() {
    }

    public static LODLogger getLogger(Class clazz) {
        if (!lodLoggerMap.keySet().contains(clazz)) {
            lodLoggerMap.put(clazz, new LODLogger(clazz));
        }

        return (LODLogger)lodLoggerMap.get(clazz);
    }
    
}
