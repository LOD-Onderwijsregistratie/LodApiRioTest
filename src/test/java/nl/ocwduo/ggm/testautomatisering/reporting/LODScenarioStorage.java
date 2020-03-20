package nl.ocwduo.ggm.testautomatisering.reporting;

import cucumber.api.Scenario;

public class LODScenarioStorage {

    private static ThreadLocal<Scenario> scenario = new ThreadLocal();

    public LODScenarioStorage() {
    }

    public static Scenario getScenario() {
        return (Scenario)scenario.get();
    }

    public static void setScenario(Scenario scenario) {
        LODScenarioStorage.scenario.set(scenario);
    }

}
