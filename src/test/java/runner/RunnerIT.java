package runner;


import io.cucumber.core.options.RuntimeOptions;
import io.cucumber.testng.CucumberOptions;
import io.cucumber.testng.FeatureWrapper;
import io.cucumber.testng.PickleWrapper;
import org.checkerframework.checker.units.qual.C;

@CucumberOptions(
        features = "src/test/java/feature/",
        glue = {"stepDefs"},
        tags = "@CoreRegression", //Use to run specific test
        dryRun = false,
        plugin = {"json:target/reports/cucumber.json",
                "html:target/reports/index.html",
                "pretty"})
public class RunnerIT extends AbstractTestNGCucumberParallelTests {


    RunnerIT() {
        RuntimeOptions runtimeOptions = RuntimeOptions.defaultOptions();

    }

    @Override
    public void runScenario(PickleWrapper pickleWrapper, FeatureWrapper featureWrapper) {
        super.runScenario(pickleWrapper, featureWrapper);
    }

    public static void main(String[] args) {
        RunnerIT obj = new RunnerIT();
    }

}
