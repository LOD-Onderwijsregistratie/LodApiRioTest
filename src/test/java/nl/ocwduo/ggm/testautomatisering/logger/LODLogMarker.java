package nl.ocwduo.ggm.testautomatisering.logger;

import org.slf4j.Marker;
import org.slf4j.MarkerFactory;

public enum LODLogMarker {

    OPTIONAL("LODOptional"),
    TRACE("LODTrace");

    private Marker marker;

    private LODLogMarker(String value) {

        this.marker = MarkerFactory.getMarker(value);
    }

    public Marker getMarker() {

        return this.marker;
    }

}
