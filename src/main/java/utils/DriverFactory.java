package utils;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;

public class DriverFactory {

    public static ThreadLocal<WebDriver> drivers = new ThreadLocal<>();
    public static List<WebDriver>  storedDrivers = new ArrayList<>();



    static {

        Runtime.getRuntime().addShutdownHook(new Thread() {
            public void run() {
                removeDriver();
                storedDrivers.forEach(WebDriver::quit);
            }
        });
    }

    public DriverFactory() {
    }

    public static WebDriver getDriver() {
        return drivers.get();
    }

    public static void addDriver(WebDriver driver) {
        storedDrivers.add(driver);
        drivers.set(driver);
    }

    public static void removeDriver() {
//        screenshotTaker.takeScreenshot();
        storedDrivers.remove(drivers.get());
        drivers.remove();
    }
}
