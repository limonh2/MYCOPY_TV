package runner;


import io.cucumber.core.options.RuntimeOptions;
import io.cucumber.tagexpressions.Expression;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.ITestContext;
import org.testng.Reporter;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.DataProvider;

import java.io.File;
import java.io.FilenameFilter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class GenerateHtmlReport {
    Logger logger = LoggerFactory.getLogger(GenerateHtmlReport.class);

    private String dateString;
    public static final int DEFAULT_MAX_STRING_LEN =
            Integer.getInteger("com.fasterxml.jackson.core.StreamReadConstraints.maxStringLen", 60_000_000);

    public static void main(String[] args) {
        try {
            Thread.sleep(2500);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        GenerateHtmlReport generateHtmlReport = new GenerateHtmlReport();
        generateHtmlReport.call();
    }


    public void call() {
        GenerateAllRunReports("DefaultRun", "Test1");
    }


    public void GenerateAllRunReports(String runName, String testName) {
        try {
            File[] jsons = null;
            if (testName.equalsIgnoreCase("Test1")) {
                jsons = finder("target/reports/");
            }
            if (runName.equalsIgnoreCase("DefaultRun")) {
                Date date = new Date();
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd_MM_yyyy_H_m_s_a");
                dateString = simpleDateFormat.format(date);
                List<File> defaultRunJSONs = new ArrayList<File>();
                for (File f : jsons) {
                    if (f.getName().contains("cucumber") && f.getName().endsWith(".json")) {
                        defaultRunJSONs.add(f);
                    }
                }
                if (!defaultRunJSONs.isEmpty()) {
                    generateRunWiseReport(defaultRunJSONs, "Default_Run", testName);
                }
            } else if (runName.equalsIgnoreCase("FirstRun")) {
                List<File> firstRunJSONs = new ArrayList<File>();
                for (File f : jsons) {
                    if (f.getName().contains("cucumber1") && f.getName().endsWith(".json")) {
                        firstRunJSONs.add(f);
                    }
                }
                if (firstRunJSONs.size() != 0) {
                    generateRunWiseReport(firstRunJSONs, "First_Re-Run", testName);
                }
            } else if (runName.equalsIgnoreCase("SecondRun")) {
                List<File> secondRunJSONs = new ArrayList<File>();
                for (File f : jsons) {
                    if (f.getName().contains("cucumber2") && f.getName().endsWith(".json")) {
                        secondRunJSONs.add(f);
                    }
                }
                if (secondRunJSONs.size() != 0) {
                    generateRunWiseReport(secondRunJSONs, "Second_Re-Run", testName);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void generateRunWiseReport(List<File> jsons, String run, String testName) {
        String projectDir = System.getProperty("user.dir");
        String reportsDir = null;
        if (projectDir != null) {
            String[] ss = projectDir.split("\\\\");
            if (ss.length != 0) {
                String[] stimestamp = ss[ss.length - 1].split("_");
                reportsDir = stimestamp[stimestamp.length - 1];
            }
        }
        try {
            //Adding tag name to the Reports folder name in case there is a single tag.
            RuntimeOptions runtimeOptions = RuntimeOptions.defaultOptions();

            List<Expression> tags = runtimeOptions.getTagExpressions();
            String folderName = "./TestReport/Reports_";
            if (tags.size() == 1) {
                folderName = "./TestReport/Reports_" + tags.get(0).toString().replace("@", "") + "_";
            }
            File rd = new File(folderName + dateString);
            List<String> jsonReports = new ArrayList<String>();
            for (File json : jsons) {
                jsonReports.add(json.getAbsolutePath());
            }
            Configuration configuration = new Configuration(rd, "Total Vote");
            //configuration.addClassifications("Browser", "chrome");
            //configuration.addClassifications("Version", "1.0.0");
            // configuration.addClassifications("User", "User Demo");
            // configuration.addClassifications("Environment", "Beta");
            //List<String> jsonReports, File reportDirectory, String pluginUrlPath, String buildNumber, String buildProject, boolean skippedFails, boolean undefinedFails, boolean flashCharts, boolean runWithJenkins, boolean artifactsEnabled, String artifactConfig, boolean highCharts
            ReportBuilder reportBuilder = new ReportBuilder(jsonReports, configuration);
            reportBuilder.generateReports();
            System.out.println(run + " Consolidated reports are generated under directory " + rd.getPath());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public File[] finder(String dirName) {
        File dir = new File(dirName);
        return dir.listFiles(new FilenameFilter() {
            public boolean accept(File dir, String filename) {
                return filename.endsWith(".json");
            }
        });
    }
}