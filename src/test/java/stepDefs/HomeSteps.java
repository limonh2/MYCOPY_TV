package stepDefs;


import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.When;
import net.bytebuddy.implementation.bytecode.Throw;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import utils.SharedDriver;
import org.testng.Assert;
import pages.*;

import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;


public class HomeSteps {

    public HomePage homePage;

    public HomeSteps(SharedDriver driver, HomePage homePage) {
        this.homePage = homePage;
    }


    @And("User select {string} from {string}")
    public void iSelectFrom(String option, String dropdown) {
        try {
            homePage.htmlDropdownSelect(homePage.getElementByText(dropdown), option);
        } catch (Exception e) {
            homePage.nativeDropdownSelect(homePage.getSelectDropdownByLabel(dropdown), option);
        }
    }

    @And("User select following data from dropdown")
    public void iSelectFromFollowingDataFromDropDown(DataTable dataTable) {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);

        for (Map<String, String> row : data) {
            String text = row.get("Text");
            String field = row.get("Field");

            try {
                homePage.htmlDropdownSelect(homePage.getElementByText(field), text);
            } catch (NoSuchElementException e) {
                homePage.nativeDropdownSelect(homePage.getElementByText(field), text);
            } catch (Exception ex){
                throw new AssertionError(text + " in " + field + " not found");
            }
        }
    }

    @And("User input following data")
    public void userInputFollowingData(DataTable dataTable) {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        WebElement input;
        for (Map<String, String> row : data) {
            String text = row.get("Text");
            String field = row.get("Field");

            try {
                input = homePage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*"));
                if (!input.getTagName().equals("input") && !input.getTagName().equals("textarea")) {
                    input = homePage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*/*"));
                }
                input.click();
                input.clear();
                input.sendKeys(text);
            } catch (NoSuchElementException e) {
                e.getMessage();
            }
        }
    }

    @And("User select {string} from {string} menu")
    public void iSelectFromMenu(String option, String dropdown) {
        homePage.htmlDropdownSelectLinkText(homePage.getElementByText(dropdown), option);
    }

    @And("User select {string} from {string} on {string} page")
    public void iSelectFromOnPage(String option, String dropdown, String page) {
        Assert.assertTrue(homePage.verifyTitle(page));
        homePage.htmlDropdownSelect(homePage.getElementByText(dropdown), option);
    }

    @And("User click on {string}")
    public void iClickOn(String field) {
        homePage.waitForSpinner();
        homePage.getElementByText(field).click();
        homePage.waitForSpinner();
    }

    @And("User validate the {string} is loaded")
    public void iValidateTheIsLoaded(String pageHeader) {
        homePage.verifyCardTitle(pageHeader);
    }

    @And("User click the {string} button")
    public void iClickTheButton(String field) {
        homePage.waitForSpinner();
        homePage.getButtonElementByText(field).click();
        homePage.waitForSpinner();
    }

    @Then("the mail correspondence should be created successfully")
    public void theMailCorrespondenceShouldBeCreatedSuccessfully() {
        Assert.assertTrue(homePage.verifyTitle("Correspondence"), "");
    }

    @And("User select {string} from {string} native dropdown")
    public void userSelectFromNativeDropdown(String text, String field) {
        WebElement input = homePage.getSelectDropdownByLabel(field);
        homePage.nativeDropdownSelect(input, text);
    }

    @And("User click on {string} button")
    public void userClickOnButton(String button) {
        homePage.clickButton(button);
        homePage.waitForSpinner();
    }


    @And("User validate following options are visible:")
    public void iValidateFollowingOptionsAreVisible(List<String> selections) {
        selections.forEach(o -> Assert.assertTrue(homePage.getElementByText(o).isDisplayed(), "The text " + o + " was not found"));
    }

    @And("User should see the following options under {string}")
    public void iShouldSeeTheFollowingOptionsUnder(String button, List<String> options) {
        homePage.clickButton(button);
        options.forEach(o -> Assert.assertTrue(homePage.getElementByText(o).isDisplayed(), "The text " + o + " was not found"));
    }


    @And("User click on {string} radio button")
    public void userClickOnRadioButton(String field) {
        if (homePage.driver.findElements(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//span")).size() > 0)
            homePage.driver.findElement(By.xpath("//label[contains(text(),'" + field + "')]/parent::div//span")).click();
        homePage.waitForSpinner();
    }

    @And("User navigate to home page")
    public void userNavigateToHomePage() {
        homePage.navigateToHomePage();
    }

    @And("User click on job queue")
    public void userClickOnJobQueue() {
        homePage.clickOnJobQueue();
    }

    @And("User click on Notices Queue")
    public void userClickOnNoticeQueue() {
        homePage.clickOnNoticeQueue();
    }

    @And("User clicks on report builder link")
    public void userClicksOnReportBuilderLink() {
        homePage.clickOnReportBuilder();
    }

    @And("User verifies the report name displayed on report builder with status finished")
    public void userVerifiesTheReportNameDisplayedOnReportBuilder() {
        homePage.verifyReportName();
    }

    @And("User waits {int} seconds for background requests to load")
    public void userWaitsSecondsForBackgroundRequestsToLoad(int sec) {
        homePage.sleep(sec);
    }

    @And("User switch to new window")
    public void userSwitchToNewWindow() {
        homePage.switchToNewWindow();
    }

    @And("User switch to new tab")
    public void userSwitchToNewTab() {
    }

    @And("User switch to Home window")
    public void userSwitchToHomeWindow() {
        homePage.switchToParentWindow();
    }


    @And("User get the current count of ballots after")
    public void user_get_the_current_count_of_ballots_after() {

        homePage.captureBallotCountAfter();

    }
    @And("User compares the Before and After Values of the Ballot")
    public void user_compares_the_before_and_after_values_of_the_ballot() {
        homePage.compareBallotCounts();

    }

    @And("User get the current count of Ballots")
    public void userGetTheCurrentCountOfBallots() {
        homePage.captureBallotCountBefore();
    }

    @Then("User verify the {string} is displaying")
    public void userVerifyTheIsDisplaying(String field) {
        homePage.verifyBallotToBeSent();
    }


    @And("I click on {string} page in pagination")
    public void iClickOnPageInPagination(String pageNumber)
    {
        homePage.clickPageInPagination(pageNumber);
    }

    @Then("User verifies all data is displaying properly in the table")
    public void userVerifiesAllDataIsDisplayingProperlyInTheTable() {
        homePage.verifiesAllDataIsDisplayingProperlyInTheTable();
    }

}
