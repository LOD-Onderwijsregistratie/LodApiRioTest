package nl.ocwduo.ggm.testautomatisering.rest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Iterator;

import com.jayway.jsonpath.*;
import com.jayway.jsonpath.Configuration;
import com.jayway.jsonpath.internal.EvaluationContext;
import com.jayway.jsonpath.internal.ParseContextImpl;
import com.jayway.jsonpath.internal.Path;
import com.jayway.jsonpath.internal.PathRef;
import com.jayway.jsonpath.internal.Utils;
import com.jayway.jsonpath.internal.path.PathCompiler;
import com.jayway.jsonpath.spi.json.JsonProvider;

public class LODJsonPath {
    private final Path path;

    private LODJsonPath(String jsonPath, com.jayway.jsonpath.Predicate[] filters) {
        Utils.notNull(jsonPath, "path can not be null", new Object[0]);
        this.path = PathCompiler.compile(jsonPath, filters);
    }

    //
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//



    public String getPath() {
        return this.path.toString();
    }

    public static boolean isPathDefinite(String path) {
        return compile(path).isDefinite();
    }

    public boolean isDefinite() {
        return this.path.isDefinite();
    }

    public <T> T read(Object jsonObject) {
        return this.read(jsonObject, Configuration.defaultConfiguration());
    }

    public <T> T read(Object jsonObject, Configuration configuration) {
        boolean optAsPathList = configuration.containsOption(com.jayway.jsonpath.Option.AS_PATH_LIST);
        boolean optAlwaysReturnList = configuration.containsOption(com.jayway.jsonpath.Option.ALWAYS_RETURN_LIST);
        boolean optSuppressExceptions = configuration.containsOption(com.jayway.jsonpath.Option.SUPPRESS_EXCEPTIONS);

        try {
            if (this.path.isFunctionPath()) {
                if (!optAsPathList && !optAlwaysReturnList) {
                    return this.path.evaluate(jsonObject, jsonObject, configuration).getValue(true);
                } else {
                    throw new JsonPathException("Options " + com.jayway.jsonpath.Option.AS_PATH_LIST + " and " + com.jayway.jsonpath.Option.ALWAYS_RETURN_LIST + " are not allowed when using path functions!");
                }
            } else if (optAsPathList) {
                return this.path.evaluate(jsonObject, jsonObject, configuration).getPath();
            } else {
                Object res = this.path.evaluate(jsonObject, jsonObject, configuration).getValue(false);
                if (optAlwaysReturnList && this.path.isDefinite()) {
                    Object array = configuration.jsonProvider().createArray();
                    configuration.jsonProvider().setArrayIndex(array, 0, res);
                    return (T) array;
                } else {
                    return (T) res;
                }
            }
        } catch (RuntimeException var8) {
            if (!optSuppressExceptions) {
                throw var8;
            } else if (optAsPathList) {
                return (T) configuration.jsonProvider().createArray();
            } else if (optAlwaysReturnList) {
                return (T) configuration.jsonProvider().createArray();
            } else {
                return this.path.isDefinite() ? null : (T) configuration.jsonProvider().createArray();
            }
        }
    }

    public <T> T set(Object jsonObject, Object newVal, Configuration configuration) {
        Utils.notNull(jsonObject, "json can not be null", new Object[0]);
        Utils.notNull(configuration, "configuration can not be null", new Object[0]);
        EvaluationContext evaluationContext = this.path.evaluate(jsonObject, jsonObject, configuration, true);
        Iterator var5 = evaluationContext.updateOperations().iterator();

        while(var5.hasNext()) {
            PathRef updateOperation = (PathRef)var5.next();
            updateOperation.set(newVal, configuration);
        }

        return this.resultByConfiguration(jsonObject, configuration, evaluationContext);
    }

    public <T> T map(Object jsonObject, MapFunction mapFunction, Configuration configuration) {
        Utils.notNull(jsonObject, "json can not be null", new Object[0]);
        Utils.notNull(configuration, "configuration can not be null", new Object[0]);
        Utils.notNull(mapFunction, "mapFunction can not be null", new Object[0]);
        EvaluationContext evaluationContext = this.path.evaluate(jsonObject, jsonObject, configuration, true);
        Iterator var5 = evaluationContext.updateOperations().iterator();

        while(var5.hasNext()) {
            PathRef updateOperation = (PathRef)var5.next();
            updateOperation.convert(mapFunction, configuration);
        }

        return this.resultByConfiguration(jsonObject, configuration, evaluationContext);
    }

    public <T> T delete(Object jsonObject, Configuration configuration) {
        Utils.notNull(jsonObject, "json can not be null", new Object[0]);
        Utils.notNull(configuration, "configuration can not be null", new Object[0]);
        EvaluationContext evaluationContext = this.path.evaluate(jsonObject, jsonObject, configuration, true);
        Iterator var4 = evaluationContext.updateOperations().iterator();

        while(var4.hasNext()) {
            PathRef updateOperation = (PathRef)var4.next();
            updateOperation.delete(configuration);
        }

        return this.resultByConfiguration(jsonObject, configuration, evaluationContext);
    }

    public <T> T add(Object jsonObject, Object value, Configuration configuration) {
        Utils.notNull(jsonObject, "json can not be null", new Object[0]);
        Utils.notNull(configuration, "configuration can not be null", new Object[0]);
        EvaluationContext evaluationContext = this.path.evaluate(jsonObject, jsonObject, configuration, true);
        Iterator var5 = evaluationContext.updateOperations().iterator();

        while(var5.hasNext()) {
            PathRef updateOperation = (PathRef)var5.next();
            updateOperation.add(value, configuration);
        }

        return this.resultByConfiguration(jsonObject, configuration, evaluationContext);
    }

    public <T> T put(Object jsonObject, String key, Object value, Configuration configuration) {
        Utils.notNull(jsonObject, "json can not be null", new Object[0]);
        Utils.notEmpty(key, "key can not be null or empty", new Object[0]);
        Utils.notNull(configuration, "configuration can not be null", new Object[0]);
        EvaluationContext evaluationContext = this.path.evaluate(jsonObject, jsonObject, configuration, true);
        Iterator var6 = evaluationContext.updateOperations().iterator();

        while(var6.hasNext()) {
            PathRef updateOperation = (PathRef)var6.next();
            updateOperation.put(key, value, configuration);
        }

        return this.resultByConfiguration(jsonObject, configuration, evaluationContext);
    }

    public <T> T renameKey(Object jsonObject, String oldKeyName, String newKeyName, Configuration configuration) {
        Utils.notNull(jsonObject, "json can not be null", new Object[0]);
        Utils.notEmpty(newKeyName, "newKeyName can not be null or empty", new Object[0]);
        Utils.notNull(configuration, "configuration can not be null", new Object[0]);
        EvaluationContext evaluationContext = this.path.evaluate(jsonObject, jsonObject, configuration, true);
        Iterator var6 = evaluationContext.updateOperations().iterator();

        while(var6.hasNext()) {
            PathRef updateOperation = (PathRef)var6.next();
            updateOperation.renameKey(oldKeyName, newKeyName, configuration);
        }

        return this.resultByConfiguration(jsonObject, configuration, evaluationContext);
    }

    public <T> T read(String json) {
        return this.read(json, Configuration.defaultConfiguration());
    }

    public <T> T read(String json, Configuration configuration) {
        Utils.notEmpty(json, "json can not be null or empty", new Object[0]);
        Utils.notNull(configuration, "jsonProvider can not be null", new Object[0]);
        return this.read(configuration.jsonProvider().parse(json), configuration);
    }

    public <T> T read(URL jsonURL) throws IOException {
        return this.read((Object)jsonURL, Configuration.defaultConfiguration());
    }

    public <T> T read(File jsonFile) throws IOException {
        return this.read(jsonFile, Configuration.defaultConfiguration());
    }

    public <T> T read(File jsonFile, Configuration configuration) throws IOException {
        Utils.notNull(jsonFile, "json file can not be null", new Object[0]);
        Utils.isTrue(jsonFile.exists(), "json file does not exist");
        Utils.notNull(configuration, "jsonProvider can not be null", new Object[0]);
        FileInputStream fis = null;

        Object var4;
        try {
            fis = new FileInputStream(jsonFile);
            var4 = this.read((InputStream)fis, configuration);
        } finally {
            Utils.closeQuietly(fis);
        }

        return (T) var4;
    }

    public <T> T read(InputStream jsonInputStream) throws IOException {
        return this.read(jsonInputStream, Configuration.defaultConfiguration());
    }

    public <T> T read(InputStream jsonInputStream, Configuration configuration) throws IOException {
        Utils.notNull(jsonInputStream, "json input stream can not be null", new Object[0]);
        Utils.notNull(configuration, "configuration can not be null", new Object[0]);
        return this.read(jsonInputStream, "UTF-8", configuration);
    }

    public <T> T read(InputStream jsonInputStream, String charset, Configuration configuration) throws IOException {
        Utils.notNull(jsonInputStream, "json input stream can not be null", new Object[0]);
        Utils.notNull(charset, "charset can not be null", new Object[0]);
        Utils.notNull(configuration, "configuration can not be null", new Object[0]);

        Object var4;
        try {
            var4 = this.read(configuration.jsonProvider().parse(jsonInputStream, charset), configuration);
        } finally {
            Utils.closeQuietly(jsonInputStream);
        }

        return (T) var4;
    }

    public static LODJsonPath compile(String jsonPath, Predicate... filters) {
        Utils.notEmpty(jsonPath, "json can not be null or empty", new Object[0]);
        return new LODJsonPath(jsonPath, filters);
    }

    public static <T> T read(Object json, String jsonPath, com.jayway.jsonpath.Predicate... filters) {
        return parse(json).read(jsonPath, filters);
    }

    public static <T> T read(String json, String jsonPath, com.jayway.jsonpath.Predicate... filters) {
        return (new ParseContextImpl()).parse(json).read(jsonPath, filters);
    }

    /** @deprecated */
    @Deprecated
    public static <T> T read(URL jsonURL, String jsonPath, com.jayway.jsonpath.Predicate... filters) throws IOException {
        return (new ParseContextImpl()).parse(jsonURL).read(jsonPath, filters);
    }

    public static <T> T read(File jsonFile, String jsonPath, com.jayway.jsonpath.Predicate... filters) throws IOException {
        return (new ParseContextImpl()).parse(jsonFile).read(jsonPath, filters);
    }

    public static <T> T read(InputStream jsonInputStream, String jsonPath, Predicate... filters) throws IOException {
        return (new ParseContextImpl()).parse(jsonInputStream).read(jsonPath, filters);
    }

    public static ParseContext using(Configuration configuration) {
        return new ParseContextImpl(configuration);
    }

    /** @deprecated */
    @Deprecated
    public static ParseContext using(JsonProvider provider) {
        return new ParseContextImpl(Configuration.builder().jsonProvider(provider).build());
    }

    public static DocumentContext parse(Object json) {
        return (new ParseContextImpl()).parse(json);
    }

    public static DocumentContext parse(String json) {
        return (new ParseContextImpl()).parse(json);
    }

    public static DocumentContext parse(InputStream json) {
        return (new ParseContextImpl()).parse(json);
    }

    public static DocumentContext parse(File json) throws IOException {
        return (new ParseContextImpl()).parse(json);
    }

    public static DocumentContext parse(URL json) throws IOException {
        return (new ParseContextImpl()).parse(json);
    }

    public static DocumentContext parse(Object json, Configuration configuration) {
        return (new ParseContextImpl(configuration)).parse(json);
    }

    public static DocumentContext parse(String json, Configuration configuration) {
        return (new ParseContextImpl(configuration)).parse(json);
    }

    public static DocumentContext parse(InputStream json, Configuration configuration) {
        return (new ParseContextImpl(configuration)).parse(json);
    }

    public static DocumentContext parse(File json, Configuration configuration) throws IOException {
        return (new ParseContextImpl(configuration)).parse(json);
    }

    public static DocumentContext parse(URL json, Configuration configuration) throws IOException {
        return (new ParseContextImpl(configuration)).parse(json);
    }

    private <T> T resultByConfiguration(Object jsonObject, Configuration configuration, EvaluationContext evaluationContext) {
        return configuration.containsOption(Option.AS_PATH_LIST) ? (T) evaluationContext.getPathList() : (T) jsonObject;
    }
}
