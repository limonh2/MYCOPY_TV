package stepDefs;


import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.Given;
import io.cucumber.datatable.DataTable;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pages.AddressPage;
import utils.DriverFactory;
import utils.Helper;
import utils.SharedDriver;

import java.util.List;
import java.util.Map;


public class AddressSteps {
    public AddressPage addressPage;

    public AddressSteps(SharedDriver driver, AddressPage addressPage) {
        this.addressPage = addressPage;
    }

    @And("switch to {string} tab")
    public void switchToTab(String tabName) {
        addressPage.moveToWindowTab(tabName);
    }

    @And("zoom in to at least a zoom of level {int}")
    public void zoomInToAtLeastAZoomOfLevel(int level) {
        addressPage.zoomTillGivenLevel(level);
    }

    @And("User click the map {string} tab")
    public void userClickTheMapTab(String tabName) {
        addressPage.clickMapTab(tabName);
    }

    @And("select {string}")
    public void select(String fieldText) {
        addressPage.getFieldByText(fieldText).click();
        addressPage.waitForSpinner();
    }

    @And("User move the cursor and click on the map")
    public void userMoveTheCursorAndClickOnTheMap() {
        addressPage.hover(addressPage.addressMarker);
        addressPage.hoverAndClick(addressPage.addressMarker);
        addressPage.click(addressPage.addressDropMarker);
        addressPage.waitForSpinner();
    }

    @And("User fill in the required information map fields")
    public void andIFillInTheRequiredElectionInformationMapFields(DataTable dataTable) {
        List<Map<String, String>> data = dataTable.asMaps();
        WebElement input;
        // Iterate over each row in the DataTable
        for (Map<String, String> row : data) {
            String text = row.get("Text");
            String field = row.get("Field");
            if (text.contains("UNIQUE")) {
                text = text.replace("UNIQUE", Helper.getTime());
            }
            try {
                if (addressPage.driver.findElements(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//*[@type='text']")).size() > 0) {
                    input = addressPage.driver.findElement(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//*[@type='text']"));
                } else if (addressPage.driver.findElements(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//input")).size() > 0) {
                    input = addressPage.driver.findElement(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//input"));
                } else
                    input = addressPage.driver.findElement(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//textarea"));
                input.sendKeys(text);
            } catch (Exception e) {
                if (addressPage.driver.findElements(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//*[contains(@class,'dropdown')]")).size() > 0) {
                    input = addressPage.driver.findElement(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//*[contains(@class,'dropdown')]"));
                    addressPage.htmlDropdownSelect(input, text);
                } else {
                    input = addressPage.driver.findElement(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//select"));
                    addressPage.nativeDropdownSelect(input, text);
                }
            }
        }
    }

    @Then("User verify the new address point was added successfully")
    public void userVerifyTheNewAddressPointWasAddedSuccessfully() {
        addressPage.waitForSpinner();
        Assert.assertTrue(addressPage.registrantsButton.isDisplayed());
    }

    @Then("verify the precinct field is populated and not {string}")
    public void verifyThePrecinctFieldIsPopulatedAndNot(String undefineDropDownValue) {
        addressPage.verifyPrecinctfield(undefineDropDownValue);
    }


    @And("user validates {string} is displaying with toggle {string}")
    public void userValidatesIsDisplaying(String mapDisplay,String status) {
        addressPage.userValidatesMapDisplayOptions(mapDisplay,status);

    }

    @And("user clicks toggle button in TA for {string}")
    public void userClicksToggleButtonInTAFor(String arg0) {
        addressPage.clickOnToggermapDisplay(arg0);
    }

}