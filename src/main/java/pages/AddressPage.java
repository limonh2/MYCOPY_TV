package pages;


import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import utils.Base;
import utils.DriverFactory;
import org.openqa.selenium.support.ui.Select;

import java.util.List;
import java.util.stream.Collectors;


public class AddressPage extends Base {

    JavascriptExecutor js = ((JavascriptExecutor) DriverFactory.getDriver());

    public AddressPage() {
        PageFactory.initElements(DriverFactory.getDriver(), this);
    }


    @FindBy(css = "div.leaflet-control-zoom-display")
    public WebElement zoomDisplay;

    @FindBy(css = "a.leaflet-control-zoom-in")
    public WebElement zoomIn;

    @FindBy(css = "div.leaflet-marker-icon.leaflet-zoom-animated")
    public WebElement addressMarker;

    @FindBy(css = "div.awesome-marker-icon-blue")
    public WebElement addressDropMarker;
    @FindBy(id = "voter-info")
    public WebElement registrantsButton;

    @FindBy(xpath = "//select[@id='PrecinctNum']")
    public WebElement precintDropdown;


    public void zoomTillGivenLevel(int level) {
        while (Integer.parseInt(zoomDisplay.getText()) < level) {
            zoomIn.click();
            sleep(1);
        }
    }

    public void clickMapTab(String tabName) {
        driver.findElement(By.cssSelector("i[data-original-title='" + tabName + "']")).click();
    }

    public WebElement getFieldByText(String fieldText) {
        try {
            if (driver.findElements(By.xpath("//*[text()='" + fieldText + "']")).size() > 0)
                return driver.findElement(By.xpath("//*[text()='" + fieldText + "']"));
            else
                return null;
        } catch (NoSuchElementException e) {
            return null;
        }
    }
    public void verifyPrecinctfield(String undefineDropDownValue) {

        Select dropdown = new Select(precintDropdown);

        // Get the selected option
        WebElement selectedOption = dropdown.getFirstSelectedOption();

        // Get the text of the selected option
        String selectedText = selectedOption.getText();
        Assert.assertNotEquals(selectedOption, undefineDropDownValue, "Precinct does not exist");
    }

    public void userValidatesMapDisplayOptions(String mapDisplay,String status) {
        WebElement element = driver.findElement(By.xpath("//label[normalize-space()='" + mapDisplay + "']"));
        waitForSpinner();
        Assert.assertEquals(element.getText(), mapDisplay);
        String classAttr= driver.findElement(By.xpath("//label[normalize-space()='"+mapDisplay+"']/preceding-sibling::div")).getAttribute("class");
        System.out.println("The class attribute is ->"+classAttr);
        if(status.toLowerCase().equals("off")){
            Assert.assertTrue(classAttr.contains("btn-default off"),"verifying map display option as off");
        }
        else {
            Assert.assertTrue(classAttr.contains("btn-primary"),"verifying map display option as ON");
        }
    }

    public void clickOnToggermapDisplay(String mapDisplay) {
        hoverAndClick(driver.findElement(By.xpath("//label[normalize-space()='"+mapDisplay+"']/preceding-sibling::div")));
        waitForSpinner();
    }

}
