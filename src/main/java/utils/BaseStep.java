package utils;


import io.cucumber.java.Scenario;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.testng.Assert;

import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import static utils.Base.testLogger;

public class BaseStep {

    public static Scenario scenario;

    protected String url = System.getProperty("url");
    protected String userName = System.getProperty("EMAIL");
    protected String password = System.getProperty("PASSWORD");

    // Version PFC Automation
    protected static String releaseVersion = System.getProperty("PFC.version");
    protected static List<String> expectedcandidateTypes;

    //Docker container output
    protected static String targetOutputFolder = "target/";

    public static final String startTimeStamp = Helper.getCurrentTime();
    public static String projectName;

    public static String userGlobalId;

    public String dataSet;
    public static String dataSource;

    public static RemoteWebDriver driver;
    public WebDriver webDriver = DriverFactory.getDriver();

    protected void searchAndSelect(List<String> itemList) throws InterruptedException {
        for (String item : itemList) {
            searchAndSelect(item);
        }
    }

    protected void searchAndSelect(String item) throws InterruptedException {

    }

    public static void takeScreenShot() {
        final byte[] screenshot = ((TakesScreenshot) driver)
                .getScreenshotAs(OutputType.BYTES);
        scenario.attach(screenshot, "image/png", scenario.getName());
    }

    public void takeScreenShot(Scenario scenario) {
        webDriver.manage().window().setSize(new Dimension(1450, 800));
        byte[] img = ((TakesScreenshot) webDriver).getScreenshotAs(OutputType.BYTES);
        scenario.attach(img, "image/jpeg", scenario.getName());
        webDriver.manage().window().maximize();
    }


    public void assertListWithDuplicate(List<String> list) {
        Set<String> set = new HashSet<String>(list);
        Assert.assertEquals(list.size(), set.size(), "List has duplicate values: " + list);
    }


    protected List<String> filterData(List<String> lines, String startingText, String endingText, String discardColumns) {
        List<String> result = new ArrayList<String>();
        int startingLastIndex = 0;
        for (int i = 0; i < lines.size(); i++) {
            if (startingText != null && !startingText.isEmpty() && lines.get(i).contains(startingText)) {
                startingLastIndex = i;
            }
        }
        // Look for fist appearance of endingText after startingLastIndex
        int endingLastIndex = lines.size() - 1;
        for (int i = startingLastIndex; i < lines.size(); i++) {
            if (endingText != null && !endingText.isEmpty() && lines.get(i).contains(endingText)) {
                endingLastIndex = i;
            }
        }
        // Collect lines between startingLastIndex and endingLastIndex
        for (int i = startingLastIndex; i < endingLastIndex; i++) {
            String line = lines.get(i).trim();
//            result.add(StringEscapeUtils.unescapeXml(line));
            result.add(line);
        }
        return result;
    }

    private String discardColumns(String line, String discardColumns) {
        List<String> cc = Arrays.asList(discardColumns.split(" "));
        String[] originalColumns = line.split(",");
        List<String> filteredColumns = new ArrayList<>();
        for (int i = 0; i < originalColumns.length; i++) {
            if (!cc.contains(Integer.toString(i + 1))) {
                filteredColumns.add(originalColumns[i]);
            }
        }
        return String.join(",", filteredColumns);
    }


    public String convertDateFormat(String date, String fromPattern, String toPattern) {
        try {
            SimpleDateFormat from = new SimpleDateFormat(fromPattern);
            SimpleDateFormat to = new SimpleDateFormat(toPattern);
            return to.format(from.parse(date));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String convertToMillion(String number) {
        number = number.replaceAll(",", "");
        double amount = Double.parseDouble(number) / 1000000;
        DecimalFormat formatter = new DecimalFormat("#,###.0");
        return formatter.format(amount);
    }

    public Integer tryParse(String text) {
        try {
            return Integer.parseInt(text.replaceAll(",", ""));
        } catch (NumberFormatException e) {
            testLogger.warning(String.format("Unable to convert string to Integer, %s," +
                    "Defaulting to return null.", text));
            return null;
        }
    }
}