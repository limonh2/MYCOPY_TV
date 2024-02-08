package runner;

import io.cucumber.testng.CucumberOptions;
import org.testng.ITestContext;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeTest;

@CucumberOptions(
        features = "src/test/java/feature/",
        glue = {"stepDefs", "utils"},
        tags = "@CoreRegression and not @bug and not @ignore",
        dryRun = false,
        plugin = {"json:target/reports/cucumber.json",
                "html:target/reports/index.html",
                "rerun:target/failed_testscenarios.txt",
                "pretty"})

public class TestRunner extends AbstractTestNGCucumberParallelTests {
    @BeforeTest
    public void threadCount(ITestContext context) {
        context.getCurrentXmlTest().getSuite().setDataProviderThreadCount(6);
        context.getCurrentXmlTest().getSuite().setPreserveOrder(false);
    }

    @AfterSuite
    public void report() {
        GenerateHtmlReport.main(new String[1]);
    }
}