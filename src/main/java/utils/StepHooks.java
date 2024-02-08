package utils;


import org.openqa.selenium.WebDriver;
import org.testng.annotations.BeforeTest;
import io.cucumber.java.*;

public class StepHooks extends BaseStep {

    static boolean isLastScenarioPassed = true;

    public DataReader dataReader = new DataReader();
    public WebDriver driver = DriverFactory.getDriver();

    @After
    public void teardown(Scenario scenario) {
        try {
            if (scenario.isFailed()) {
                takeScreenShot(scenario);
                scenario.log("Scenario failed on : " + driver.getCurrentUrl());
            }
        } catch (Exception e) {
            takeScreenShot(scenario);
            scenario.log("Scenario stopped on : " + driver.getCurrentUrl() + "With exception" + e.getMessage());
        }
    }
}

