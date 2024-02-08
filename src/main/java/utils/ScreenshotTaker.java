package utils;

import io.cucumber.messages.types.Scenario;
import org.apache.commons.io.FileUtils;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.TakesScreenshot;

import java.io.File;
import java.io.IOException;

public class ScreenshotTaker {

    private WebDriver driver;

    public ScreenshotTaker() {
        this.driver = DriverFactory.getDriver();
    }

    public void takeScreenshot(Scenario scenario) {
        TakesScreenshot takesScreenshot = (TakesScreenshot) driver;
        File screenshot = takesScreenshot.getScreenshotAs(OutputType.FILE);
        try {
            FileUtils.copyFile(screenshot, new File("target/screenshot.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

