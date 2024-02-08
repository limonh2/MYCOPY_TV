package runner;

import io.cucumber.testng.CucumberOptions;
import org.testng.ITestContext;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeTest;

@CucumberOptions(
        features = "src/test/java/feature/",
        glue = {"stepDefs","utils"},
        tags = "@StagingRegression", //Use to run specific test
        dryRun = false,
        plugin = {"json:target/reports/cucumber.json",
                "html:target/reports/index.html",
                "rerun:target/failed_testscenarios.txt",
                "pretty"})

public class StagingTestRunner extends AbstractTestNGCucumberParallelTests {
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