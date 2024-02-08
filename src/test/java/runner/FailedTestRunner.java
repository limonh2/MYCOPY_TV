package runner;

import io.cucumber.testng.CucumberOptions;
import org.testng.ITestContext;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeTest;

@CucumberOptions(
        features = "@target/failed_testscenarios.txt",
        glue = {"stepDefs","utils"},
        dryRun = false,
        plugin = {"json:target/reports/cucumber.json",
                "html:target/reports/index.html",
                "rerun:target/failed_testscenarios_1.txt",
                "pretty"})

public class FailedTestRunner extends AbstractTestNGCucumberParallelTests {
    @BeforeTest
    public void threadCount(ITestContext context) {
        context.getCurrentXmlTest().getSuite().setDataProviderThreadCount(3);
        context.getCurrentXmlTest().getSuite().setPreserveOrder(false);
    }

    @AfterSuite
    public void report() {
        GenerateHtmlReport.main(new String[1]);
    }
}