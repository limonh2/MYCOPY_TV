package utils;

import io.cucumber.messages.types.Scenario;
import io.cucumber.messages.types.Tag;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.*;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;


import static io.github.bonigarcia.wdm.config.DriverManagerType.CHROME;
import static utils.Base.testLogger;
//import static io.github.bonigarcia.wdm.DriverManagerType.CHROME;

public class Driver {
    public static String downloadDir;
    public static DataReader dataReader = new DataReader();
    public WebDriver driver = DriverFactory.getDriver();


    public ChromeDriver openDriver(Scenario scenario) throws Throwable {
        String testIDTag = dataReader.prop.getProperty("testIdTag");


        String idTag = "(missing)";
        for (Tag currentTag : scenario.getTags()) {
            if (currentTag.getName().contains(testIDTag)) {
                idTag = currentTag.getName();
                break;
            }
        }


        idTag = idTag.replace("@", "");


        String current = Paths.get(".").toAbsolutePath().normalize().toString();
        downloadDir = current + "/target/downloads/" + idTag + "-" + Helper.getTime();
        FileSystem fileSystem = FileSystems.getDefault();
        Files.createDirectories(fileSystem.getPath(downloadDir));


        ChromeOptions options = new ChromeOptions();
        String fullscreen = DataReader.prop.getProperty("fullscreen");


        options.addArguments("--no-sandbox");


        if (Objects.equals(fullscreen, "") || Boolean.parseBoolean(fullscreen)) {
            options.addArguments("window-size=1680,1050");
        }


        if (Boolean.parseBoolean(System.getProperty("java.awt.headless"))) {
            options.addArguments("--headless");
            options.addArguments("window-size=1680,1050");
        }


        if (System.getProperty("isDockerized") != null && Boolean.parseBoolean(System.getProperty("isDockerized"))) {
            //https://stackoverflow.com/questions/48450594/selenium-timed-out-receiving-message-from-renderer
            options.setPageLoadStrategy(PageLoadStrategy.NONE);
            options.addArguments("start-maximized");
            options.addArguments("enable-automation");
            options.addArguments("--disable-dev-shm-usage");
            options.addArguments("--disable-infobars");
            options.addArguments("--disable-gpu");
            options.addArguments("--dns-prefetch-disable");
            options.addArguments("--disable-browser-side-navigation");
            options.addArguments("--disable-dev-shm-usage");
            options.addArguments("chrome.switches", "--disable-extensions");
            if (!Boolean.parseBoolean(System.getProperty("java.awt.headless"))) {
                options.addArguments("--headless");
                options.addArguments("window-size=1680,1050");
            }
        }


        if (Objects.equals(fullscreen, "") || Boolean.parseBoolean(fullscreen)) {
            options.addArguments("window-size=1680,1050");
        }


        if (Boolean.parseBoolean(System.getProperty("java.awt.headless"))) {
            options.addArguments("--headless");
            options.addArguments("window-size=1680,1050");
        }


        HashMap<String, Object> chromePrefs = new HashMap<>();
        chromePrefs.put("savefile.default_directory", downloadDir);
        chromePrefs.put("download.default_directory", downloadDir);
        chromePrefs.put("download.prompt_for_download", false);
        chromePrefs.put("download.open_pdf_in_system_reader", false);
        chromePrefs.put("download.directory_upgrade", true);
        chromePrefs.put("safebrowsing.enabled", false);
        chromePrefs.put("safebrowsing.disable_download_protection", true);
        options.setExperimentalOption("prefs", chromePrefs);


        driver = new ChromeDriver(options);
        driver.manage().deleteAllCookies();
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        driver.manage().timeouts().pageLoadTimeout(2, TimeUnit.MINUTES);
        return (ChromeDriver) driver;
    }


    public void setupBrowser() {
        WebDriverManager.getInstance(CHROME).setup();
    }


    public boolean isElementDisplayed(WebDriver driver, By by, int index) {
        WebDriverWait webDriverWait = new WebDriverWait(driver, Duration.ofSeconds(20));
        try {
            webDriverWait.until((WebDriver drv) -> drv.findElements(by).get(index).isDisplayed());
            return true;
        } catch (Exception e) {
            testLogger.fine("isElementDisplayed: Exception found - " + Arrays.toString(e.getStackTrace()));
            return false;
        }
    }


    public int ElementDisplayed(WebDriver driver, By by) {
        WebDriverWait webDriverWait = new WebDriverWait(driver, Duration.ofSeconds(20));
        int elementIndex = -1;
        try {
            elementIndex = webDriverWait.until((WebDriver drv) ->
            {
                for (int i = 0; i < drv.findElements(by).size(); i++) {
                    if (drv.findElements(by).get(i).isDisplayed()) {
                        return i;
                    }
                }
                return -1;
            });
            return elementIndex;
        } catch (Exception e) {
            testLogger.fine("isElementDisplayed: Exception found - " + Arrays.toString(e.getStackTrace()));
            return -1;
        }
    }


    public int ElementDisplayed(List<WebElement> elements) {
        WebDriverWait webDriverWait = new WebDriverWait(driver, Duration.ofSeconds(20));
        int elementIndex = -1;
        try {
            elementIndex = webDriverWait.until((WebDriver drv) ->
            {
                for (int i = 0; i < elements.size(); i++) {
                    if (elements.get(i).isDisplayed()) {
                        return i;
                    }
                }
                return -1;
            });
            return elementIndex;
        } catch (Exception e) {
            testLogger.fine("isElementDisplayed: Exception found - " + Arrays.toString(e.getStackTrace()));
            return -1;
        }
    }


    public boolean isElementDisplayed(WebElement element) {
        return isElementDisplayed(element, 30);
    }


    public boolean isElementDisplayed(WebElement element, int timeout) {
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(timeout));
            wait.until(ExpectedConditions.visibilityOf(element));
            return element.isDisplayed();
        } catch (WebDriverException e) {
            testLogger.fine("isElementDisplayed: Selenium exception found - " + e.getMessage());
        } catch (Exception e) {
            testLogger.log(Level.SEVERE, "isElementDisplayed: Exception found - ", e);
        }
        return false;
    }


    public WebElement getElementByPartialText(List<WebElement> els, String text) {
        return els.stream()
                .filter(el -> el.isDisplayed() && el.getText().contains(text))
                .findFirst()
                .orElseThrow(() -> new AssertionError("Web element not found for not containing text: " + text));
    }


    public void sleep(int timeInSeconds) {
        try {
            Thread.sleep(timeInSeconds * 1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }


    public boolean oneElementTextContains(List<WebElement> elements, String text, boolean caseInsensitive) {
        return elements.stream()
                .filter(b -> {
                    if (caseInsensitive) {
                        return b.getText().toUpperCase().contains(text.trim().toUpperCase());
                    } else {
                        return b.getText().contains(text);
                    }
                })
                .count() > 0;
    }


    public boolean oneElementTextContains(List<WebElement> elements, String text) {
        return oneElementTextContains(elements, text, false);
    }


    public boolean oneElementTextEquals(List<WebElement> elements, String text) {
        return elements.stream()
                .filter(b -> b.isDisplayed() && b.getText().equals(text))
                .count() > 0;
    }


    public String getDownloadDirectory() {
        return Driver.downloadDir;
    }


    public void setDownloadDirectory(String downloadDirectory) {
        Driver.downloadDir = downloadDirectory;
    }
}



