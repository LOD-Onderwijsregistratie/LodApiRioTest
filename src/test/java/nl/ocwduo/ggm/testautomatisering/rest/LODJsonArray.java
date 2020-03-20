package nl.ocwduo.ggm.testautomatisering.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import net.minidev.json.reader.JsonWriter;
import wiremock.net.minidev.json.*;


public class LODJsonArray extends ArrayList<Object> implements List<Object>, JSONAwareEx, JSONStreamAwareEx {
    private static final long serialVersionUID = 9106884089231309568L;

    //
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

        public LODJsonArray() {
        }

    public static String toJSONString(List<? extends Object> list) {
        return toJSONString(list, net.minidev.json.JSONValue.COMPRESSION);
    }

    public static String toJSONString(List<? extends Object> list, net.minidev.json.JSONStyle compression) {
        StringBuilder sb = new StringBuilder();

        try {
            writeJSONString(list, sb, compression);
        } catch (IOException var4) {
        }

        return sb.toString();
    }

    public static void writeJSONString(Iterable<? extends Object> list, Appendable out, net.minidev.json.JSONStyle compression) throws IOException {
        if (list == null) {
            out.append("null");
        } else {
            JsonWriter.JSONIterableWriter.writeJSONString(list, out, compression);
        }
    }

    public static void writeJSONString(List<? extends Object> list, Appendable out) throws IOException {
        writeJSONString(list, out, net.minidev.json.JSONValue.COMPRESSION);
    }

    public LODJsonArray appendElement(Object element) {
        this.add(element);
        return this;
    }

    public void merge(Object o2) {
        LODJsonObject.merge(this, o2);
    }

    public String toJSONString() {
        return toJSONString(this, net.minidev.json.JSONValue.COMPRESSION);
    }

    public String toJSONString(net.minidev.json.JSONStyle compression) {
        return toJSONString(this, compression);
    }

    public String toString() {
        return this.toJSONString();
    }

    public String toString(net.minidev.json.JSONStyle compression) {
        return this.toJSONString(compression);
    }

    public void writeJSONString(Appendable out) throws IOException {
        writeJSONString(this, out, net.minidev.json.JSONValue.COMPRESSION);
    }

    public void writeJSONString(Appendable out, net.minidev.json.JSONStyle compression) throws IOException {
        writeJSONString(this, out, compression);
    }

    @Override
    public String toJSONString(JSONStyle jsonStyle) {
        return null;
    }

    @Override
    public void writeJSONString(Appendable appendable, JSONStyle jsonStyle) throws IOException {

    }
}
