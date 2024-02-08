package utils;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import utils.DriverFactory;

import java.util.concurrent.TimeUnit;


public class SharedDriver {

    public SharedDriver() {
        if (DriverFactory.getDriver() == null) {
//            WebDriver driver = WebDriverManager.chromedriver().create();
            ChromeOptions options = new ChromeOptions();
            options.addArguments("--disable-popup-blocking");
            options.addArguments("disable-infobars");
            options.addArguments("start-maximized");
            WebDriver driver = new ChromeDriver(options);
            driver.manage().deleteAllCookies();
            driver.manage().timeouts().pageLoadTimeout(10, TimeUnit.SECONDS);
            driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
            DriverFactory.addDriver(driver);
        }
    }


}
