package stepDefs;


import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.testng.Assert;
import pages.UtilitiesPage;
import pages.VoterPage;
import utils.Helper;
import utils.SharedDriver;

import java.util.List;
import java.util.Map;


public class UtilitiesSteps {


    public UtilitiesPage utilitiesPage;

    public UtilitiesSteps(SharedDriver driver, UtilitiesPage utilitiesPage) {
        this.utilitiesPage = utilitiesPage;
    }


    @And("User fills in the required information fields for creating a Notice")
    public void userFillsInTheRequiredInformationFieldsForCreatingANotice(DataTable dataTable) {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        WebElement input;
        // Iterate over each row in the DataTable
        for (Map<String, String> row : data) {
            String text = row.get("Text");
            String field = row.get("Field");
            String type = row.get("Type");
            //System.out.println("Adding data for :" + field + " -> " + text);
            switch (type) {

                case "dropdown":
                    input = utilitiesPage.driver.findElement(By.xpath("//div[normalize-space(text())='" + field + "']/following-sibling::div[1]//select"));
                    utilitiesPage.nativeDropdownSelect(input, text);
                    break;
                case "input":
                    input = utilitiesPage.driver.findElement(By.xpath("//div[normalize-space(text())='" + field + "']/following-sibling::div[1]//input"));
                    input.click();
                    input.clear();
                    if (text.contains("random")) {
                        Helper.TEMPLATE_NAME = text.replace("random", Helper.getRandomNumber(3));
                        input.sendKeys(Helper.TEMPLATE_NAME);
                    } else {
                        input.sendKeys(text);
                    }

                    break;
                default:
                    throw new RuntimeException("No element found->" + type);
            }
        }
    }

    @Then("User verifies dropdown Notice Name has newly created value")
    public void userVerifiesTemplateValueDisplayedInDropdown() {
        utilitiesPage.verifyValuePresentInDropDown(Helper.TEMPLATE_NAME);
    }

    @And("User click on Save button in Notice Management")
    public void userClickOnSaveButtonInNoticeManagement() {
        utilitiesPage.clickSaveBtnNoticeMgmt();
    }

    @When("I select a random value from the dropdown with name {string}")
    public void iSelectARandomValueFromTheDropdownWithName(String dropdownName) {
        utilitiesPage.selectRandomValuesFromDropdown(dropdownName);
    }

    @When("I select the current date from the dropdown with name {string}")
    public void iSelectTheCurrentDateFromTheDropdownWithName(List<String> calendarName) {
        utilitiesPage.selectCurrentDateFromCalendar(calendarName);
    }

    @When("User enter {string} into Counties field")
    public void userEnterIntoCountiesField(String countListBox) {
        utilitiesPage.enterCountiesText(countListBox);
    }

    @And("User click the Apache icon button")
    public void userClickTheApacheIconButton() {
        utilitiesPage.clickCountyListBox();
    }

    @When("I select the current date for the following date fields:")
    public void iSelectTheCurrentDateForTheFollowingDateFields(List<String> fieldNames) {
        utilitiesPage.selectCurrentDateFromCalendar(fieldNames);
    }
}