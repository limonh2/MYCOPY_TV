package pages;


import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;
import utils.Base;
import utils.DriverFactory;

import java.util.Random;
import java.util.List;


public class UtilitiesPage extends Base {

    JavascriptExecutor js = ((JavascriptExecutor) DriverFactory.getDriver());

    public UtilitiesPage() {
        PageFactory.initElements(DriverFactory.getDriver(), this);
    }

    @FindBy(xpath = "//div[@style='display: block;']//select[@id='notice-template-select']")
    public WebElement drpNoticeName;

    @FindBy(xpath = "//input[@value=\"Save\"]")
    public WebElement saveBtnNotice;
    @FindBy(xpath = "//td[contains(@class, 'k-state-selected')]")
    public WebElement currentDate;

    @FindBy(xpath = "//input[@id='rcbCounty']")
    public WebElement countyListBox;

    @FindBy(xpath = "//input[@id=\"_Apache\"]")
    public WebElement countyListBoxOption;


    public void verifyValuePresentInDropDown(String noticeType) {
        nativeDropdownSelect(drpNoticeName, noticeType);
        Assert.assertTrue(isNativeDropdownSelected(drpNoticeName, noticeType));
    }

    public void clickSaveBtnNoticeMgmt() {
        saveBtnNotice.click();
        waitForSpinner();
    }

    public void selectRandomValuesFromDropdown(String dropdownText) {
        // Create the dynamic locator based on the provided text
        By dynamicLocator = By.xpath("//label[text()='" + dropdownText + "']/following-sibling::select[@class='form-control p-2']");

        // Find the dropdown element using the dynamic locator
        WebElement dropdownElement = driver.findElement(dynamicLocator);

        // Use the Select class to work with the dropdown
        Select dropdown = new Select(dropdownElement);
        List<WebElement> options = dropdown.getOptions();

        if (options.size() > 1) {

            int randomIndex = new Random().nextInt(options.size() - 1) + 1;
            dropdown.selectByIndex(randomIndex);

        } else if (options.size() == 1) {
            dropdown.selectByIndex(0);
        } else {
            throw new RuntimeException("Dropdown has no options to select");
        }
    }

    public void selectCurrentDateFromCalendar(List<String> fieldNames) {
        for (String fieldName : fieldNames) {
            By dynamicLocator = By.xpath("//div[@class='col-lg-4 col-sm-12']/label[contains(text(), '" + fieldName + "')]/following-sibling::*/button");
            WebElement element = driver.findElement(dynamicLocator);
            element.click();
            clickCurrentCalendarDate();
        }
    }

    public void clickCurrentCalendarDate() {
        currentDate.click();
        waitForSpinner();
    }

    public void enterCountiesText(String countListBox) {
        waitForSpinner();
        countyListBox.click();
    }

    public void clickCountyListBox() {
        waitForSpinner();
        hoverClick(countyListBoxOption, countyListBox);
    }
}