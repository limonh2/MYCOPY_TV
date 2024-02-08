package stepDefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.When;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import pages.ElectionPage;
import pages.HomePage;
import utils.DriverFactory;
import utils.Helper;
import utils.SharedDriver;

import java.text.ParseException;
import java.util.*;


public class ElectionSteps {

    public HomePage homePage;
    public ElectionPage electionPage;
    int candidate_count = 0;
    int contest_count = 0;

    public ElectionSteps(SharedDriver driver, HomePage homePage, ElectionPage electionPage) {
        this.homePage = homePage;
        this.electionPage = electionPage;
    }


    @And("User fill in the required information fields")
    public void andIFillInTheRequiredElectionInformationFields(DataTable dataTable) {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        WebElement input;
        // Iterate over each row in the DataTable
        for (Map<String, String> row : data) {
            String text = row.get("Text");
            String field = row.get("Field");
            try {
                if (electionPage.driver.findElements(By.xpath("//label[contains(text(), '" + field + "')]/parent::div/*[@type='text' or @type='number'] | //*[@placeholder='" + field + "']")).size() > 0) {
                    input = electionPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/parent::div/*[@type='text' or @type='number'] | //*[@placeholder='" + field + "']"));
                    input.sendKeys(text);
                } else if (electionPage.driver.findElements(By.xpath("//label[contains(text(), '" + field + "')]/parent::div//input")).size() > 0) {
                    input = electionPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/parent::div//input"));
                    //Add code to enter date in the field as normal sendkeys was not working properly
                    input.click();
                    input.sendKeys(text);
                    String s = input.getAttribute("value");
                    if (!input.getAttribute("value").equalsIgnoreCase(text)) {
                        try {
                            text = electionPage.getDateInFormat("MM/dd/yyyy", Integer.parseInt(text));
                            int len = text.split("/").length;
                            for (int i = len; i > 0; i--) {
                                input.click();
                                for (int j = len; j > i; j--) {
                                    input.sendKeys(Keys.LEFT);
                                }
                                String abc = text.split("/")[i - 1];
                                input.sendKeys(text.split("/")[i - 1]);
                            }
                        } catch (Exception ex) {
                        }
                    }
                } else {
                    input = electionPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/parent::div//iframe"));
                    electionPage.driver.switchTo().frame(input);
                    electionPage.driver.findElement(By.xpath("//p")).sendKeys(text);
                    electionPage.driver.switchTo().defaultContent();
                }

            } catch (Exception e) {
                if (electionPage.driver.findElements(By.xpath("//label[contains(text(), " + "'" + field + "'" + ")]/parent::div/*[contains(@class,'dropdown')]")).size() > 0) {
                    input = electionPage.driver.findElement(By.xpath("//label[contains(text(), " + "'" + field + "'" + ")]/parent::div/*[contains(@class,'dropdown')]"));
                    electionPage.htmlDropdownSelect(input, text);


                } else {
                    input = electionPage.driver.findElement(By.xpath("//label[contains(text(), " + "'" + field + "'" + ")]/parent::div/select"));
                    electionPage.nativeDropdownSelect(input, text);
                }
            }
        }
    }


    @And("User save the selection")
    public void iSaveTheSelection() {
        electionPage.waitAndClick(electionPage.saveButton);
        electionPage.waitForSpinner();
    }

    @Then("the new election should be created successfully")
    public void theNewElectionShouldBeCreatedSuccessfully() {
        homePage.waitForSpinner();
        homePage.waitUntilElementPresent(electionPage.success, 10);
        Assert.assertTrue(electionPage.success.isDisplayed());
        electionPage.waitAndClick(electionPage.okButton);
        electionPage.waitForSpinner();

    }

    @And("User enter {string} into {string} field")
    public void iEnterIntoField(String text, String field) {

        try {
            WebElement input = electionPage.driver.findElement(By.xpath("//input[@placeholder='" + field + "']"));
            input.sendKeys(text);
        } catch (Exception e) {
            WebElement input = electionPage.driver.findElement(By.xpath("//label[contains(text(), " + "'" + field + "'" + ")]/parent::div/select"));
            electionPage.nativeDropdownSelect(input, text);
        }
        electionPage.waitForSpinner();
    }

    @And("User set a valid election date")
    public void iSetAValidElectionDate() {
        electionPage.createElectionDate();
        electionPage.electionDateInput.sendKeys(electionPage.createElectionDate());
    }

    @And("User generate and use election abbreviation")
    public void iGenerateAndUseElectionAbbreviation() {
        String abbrv = electionPage.generateElectionEbbreviation();
        electionPage.electionAbbreviationInput.sendKeys(abbrv);
    }

    @Then("the new race should be added to the election successfully")
    public void theNewRaceShouldBeAddedToTheElectionSuccessfully() {
        Assert.assertTrue(electionPage.ballotRow.isDisplayed());
    }


    @And("User select following checkboxes")
    public void iSelectFollowingCheckboxes(List<String> checkboxes) {
        electionPage.selectCheckbox(checkboxes);
    }


    @And("User select the {string} checkbox")
    public void iSelectTheCheckbox(String checkbox) {
        WebElement checkboxElement = electionPage.driver.findElement(By.xpath("//label[contains(text(),'" + checkbox + "')]/parent::div//input[@type='checkbox']"));
        electionPage.waitAndClick(checkboxElement);
    }

    @And("User select the {string} checkbox in Polling Place")
    public void iSelectTheCheckboxInPollingPlace(String checkbox) {
        WebElement checkboxElement = electionPage.driver.findElement(By.xpath("//label[normalize-space()='" + checkbox + "']"));
        electionPage.waitAndClick(checkboxElement);
    }

    @And("User select {string} election")
    public void userSelectElection(String text) {
        electionPage.selectElection(text);
    }

    @And("User verify ballot styles were created successfully")
    public void userVerifyBallotStylesWereCreatedSuccessfully() {
        electionPage.waitForSpinner();
        String current_time = electionPage.getDateInFormat("M/d/yyyy", 0);
        String time = electionPage.driver.findElement(By.cssSelector("label[data-testid='styles_created_by']")).getText();
        String count = electionPage.driver.findElement(By.cssSelector("span[data-testid='count']")).getText();
        Assert.assertTrue(time.contains(current_time));
        Assert.assertTrue(Integer.parseInt(count) > 0);

    }

    @And("User click on County Ballot Question link")
    public void userClickOnCountyBallotQuestionLink() {
        electionPage.waitAndClick(electionPage.countyBallotQuestionLink);
    }

    @And("User click on Statewide Ballot Question link")
    public void userClickOnStatewideBallotQuestionLink() {
        electionPage.waitAndClick(electionPage.StatewideBallotQuestionLink);
    }

    @And("User click on Statewide Ballot Questions link")
    public void userClickOnStatewideBallotQuestionsLink() {
        electionPage.waitAndClick(electionPage.StatewideBallotQuestionLink);
    }

    @Then("the new polling place should be added to the election successfully")
    public void theNewPollingPlaceShouldBeAddedToTheElectionSuccessfully() {
        homePage.waitForSpinner();
        homePage.waitUntilElementPresent(electionPage.success, 10);
        Assert.assertTrue(electionPage.success.isDisplayed());
        electionPage.okButton.click();
        electionPage.waitForSpinner();
    }

    @And("User click the plus button to add candidate")
    public void userClickThePlusButtonToAddCandidate() {
        electionPage.waitForSpinner();
        if (electionPage.isElementPresent(electionPage.plusButton)) {
            electionPage.scrollToElement(electionPage.plusButton);
            electionPage.plusButton.click();
        }
        if (homePage.getButtonElementByText("Add Candidate") == null) {
            electionPage.scrollToElement(electionPage.plusButton);
            electionPage.plusButton.click();
        }
        electionPage.waitForSpinner();
    }

    @Then("User verify new candidate was added to the race successfully")
    public void userVerifyNewCandidateWasAddedToTheRaceSuccessfully() {
        electionPage.waitForSpinner();
        Assert.assertEquals(candidate_count + 1, Integer.parseInt(electionPage.candidate_count.getText()));
    }

    @Then("User verify new contest was added to the election successfully")
    public void userVerifyNewContestWasAddedToTheElectionSuccessfully() {
        electionPage.waitForSpinner();
        Assert.assertEquals(contest_count + 1, Integer.parseInt(electionPage.contest_count.getText()));
    }

    @And("User gets the current count of candidates")
    public void iGetTheCurrentCountOfCandidate() {
        candidate_count = Integer.parseInt(electionPage.candidate_count.getText());
    }

    @And("User gets the current count of contests")
    public void iGetTheCurrentCountOfContests() {
        contest_count = Integer.parseInt(electionPage.contest_count.getText());
    }

    @Then("User verify search results")
    public void userVerifySearchResults(DataTable dataTable) {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        electionPage.waitForSpinner();
        Assert.assertTrue(electionPage.searchedFields.isDisplayed());
        for (Map<String, String> row : data) {
            String key = row.get("Key");
            String value = row.get("Value");
            String customLocator = "//div[@data-testid='field' and text()='" + key + "']/following-sibling::div[text()='" + value + "']";
            Assert.assertTrue(electionPage.isElementPresent(By.xpath(customLocator)));
        }
    }

    @Then("User verify the addition was successful")
    public void userVerifyTheAdditionWasSuccessful() {
        homePage.waitForSpinner();
        homePage.waitUntilElementPresent(electionPage.success, 10);
        Assert.assertTrue(electionPage.success.isDisplayed());
        electionPage.okButton.click();
        electionPage.waitForSpinner();
    }

    @And("User fills in the required information fields for creating election related functions")
    public void userFillsInTheRequiredInformationFieldsForNewElection(DataTable dataTable) {
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
                    input = electionPage.driver.findElement(By.xpath("(//label[normalize-space()= \"" + field + "\"]//following-sibling::*)[last()]"));
                    if (input.getAttribute("class").contains("dropdownlist")) {
                        input = electionPage.waitUntilElementToBePresent(By.xpath("//label[normalize-space()= \"" + field + "\"]//following-sibling::*[contains(@class,'dropdown')]//button"), 15);
                        electionPage.clickElementByJS(input);

                        electionPage.sleep(2);
                        WebElement op = electionPage.waitUntilElementToBePresent(By.xpath("//li[@role='option']//*[normalize-space()='" + text + "']"), 15);
                        if (op != null) {
                            electionPage.clickElementByJS(op);
                        } else {
                            input = electionPage.waitUntilElementToBePresent(By.xpath("//label[normalize-space()= \"" + field + "\"]//following-sibling::*[contains(@class,'dropdown')]//button"), 15);
                            electionPage.clickElementByJS(input);
                            op = electionPage.waitUntilElementToBePresent(By.xpath("//li[@role='option']//*[normalize-space()='" + text + "']"), 15);
                            electionPage.clickElementByJS(op);
                        }
                        electionPage.sleep(2);
                    } else {
                        input = electionPage.driver.findElement(By.xpath("//label[normalize-space()= \"" + field + "\"]//following-sibling::select"));
                        electionPage.nativeDropdownSelect(input, text);
                    }
                    break;

                case "input":
                    input = electionPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*"));
                    if (!input.getTagName().equals("input") && !input.getTagName().equals("textarea")) {
                        input = electionPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*/*"));
                    }
                    input.click();
                    input.clear();
                    input.sendKeys(text);
                    break;

                default:
                    throw new RuntimeException("No element found->" + type);
            }
        }
    }

    @And("User fills in the required information fields for creating a new candidate")
    public void userFillsInTheRequiredInformationFieldsForNewCandidate(DataTable dataTable) throws InterruptedException {
//        electionPage.enterTextInInputFields(dataTable);
        System.out.println("From add " + DriverFactory.getDriver());
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
                    input = electionPage.driver.findElement(By.xpath("//label[normalize-space(text())= \"" + field + "\"]//preceding-sibling::select"));
                    electionPage.nativeDropdownSelect(input, text);
                    break;
                case "input":
                    input = electionPage.driver.findElement(By.xpath("//*[@placeholder=\"" + field + "\"]"));
                    input.click();
                    input.clear();
                    input.sendKeys(text);
                    break;
                default:
                    throw new RuntimeException("No element found->" + type);
            }
        }
    }

    @And("User fills in the required information fields for creating a new contest")
    public void userFillsInTheRequiredInformationFieldsForAddingAContest(DataTable dataTable) {
//        electionPage.enterTextInInputFields(dataTable);
        System.out.println("From add " + DriverFactory.getDriver());
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
                    input = electionPage.driver.findElement(By.xpath("//label[normalize-space()= \"" + field + "\"]//following-sibling::*"));
                    if (input.getAttribute("class").contains("dropdownlist")) {
                        input = (WebElement) electionPage.waitUntilElementToBePresent(By.xpath("//label[normalize-space()= \"" + field + "\"]//following-sibling::*[contains(@class,'dropdown')]//button"), 15);
                        electionPage.clickElementByJS(input);
                        electionPage.sleep(2);
                        Object op = electionPage.waitUntilElementToBePresent(By.xpath("//li[@role='option']//*[normalize-space()='" + text + "']"), 15);
                        if (op instanceof WebElement) {
                            electionPage.clickElementByJS((WebElement) op);
                        } else {
                            input = (WebElement) electionPage.waitUntilElementToBePresent(By.xpath("//label[normalize-space()= \"" + field + "\"]//following-sibling::*[contains(@class,'dropdown')]//button"), 15);
                            electionPage.clickElementByJS(input);
                            op = electionPage.waitUntilElementToBePresent(By.xpath("//li[@role='option']//*[normalize-space()='" + text + "']"), 15);
                            electionPage.clickElementByJS((WebElement) op);
                        }
                        electionPage.sleep(2);
                    } else {
                        input = electionPage.driver.findElement(By.xpath("//label[normalize-space()= \"" + field + "\"]//following-sibling::select"));
                        electionPage.nativeDropdownSelect(input, text);
                    }
                    break;

                case "input":
                    input = electionPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*"));
                    if (!input.getTagName().equals("input") && !input.getTagName().equals("textarea")) {
                        input = electionPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*/*"));
                    }
                    input.click();
                    input.clear();
                    input.sendKeys(text);
                    break;

                default:
                    throw new RuntimeException("No element found->" + type);
            }
        }
    }

    @And("User set a valid Filing Start and Filing End")
    public void userSetAValidFilingStartAndFilingEnd() {
        electionPage.contestFilingStart.sendKeys(electionPage.createElectionDate());
        electionPage.contestFilingEnd.sendKeys(electionPage.createElectionDate());
    }

    @And("User enters Description {string} for Election")
    public void userEntersDescriptionForElection(String text) {
        electionPage.enterTimeStampElection(text);
    }

    @Then("the {string} message should be populated successfully")
    public void theElectionAbbreviationAlreadyExistsMessageShouldBePopulatedSuccessfully(String type) {
        Assert.assertTrue(electionPage.ElectionAbbreviationAlreadyExists.isDisplayed());
    }

    @And("User click the Scan button in Ballot Setup")
    public void userClickTheScanButtonInBallotSetup() {
        electionPage.clickonScanBtnBallotSetup();
        electionPage.waitForSpinner();
    }

    @And("User click the View button in Ballot Setup")
    public void userClickTheViewButtonInBallotSetup() {
        electionPage.clickonViewBtnBallotSetup();
        electionPage.waitForSpinner();
    }

    @Then("User verify a form got scanned successfully")
    public void userVerifyAFormGotScannedSuccessfully() {
        electionPage.verifyViewDocumentHeaderisDisplayed();

    }

    @And("User selects {string} from election dropdown in Polling Place")
    public void userSelectsFromElectionDropdownInPollingPlace(String election) {
        electionPage.userSelectElectionFromDropPollingPlace(election);
    }

    @And("User selects any Election from dropdown menu in Polling Place")
    public void userSelectsAnyElectionFromDropdownMenuInPollingPlace() {
        electionPage.userSelectsAnyElectionFromDropPollingPlace();

    }

    @And("User check off {string} checkbox from list")
    public void userCheckOffCheckboxFromList(String text) {
        Helper.TEMP_DATA1 = text;
        electionPage.userSelectsTheCheckBoxFromList(text);
    }

    @And("User verify Polling Place Location is part of the list and checked off")
    public void userVerifyPollingPlaceLocationIsPartOfTheListOfCheckboxes() {
        electionPage.verifyPollingPlaceLocationIsPartOfTheList(Helper.TEMP_DATA1);
    }

    @And("User enters {string} search for Polling Place")
    public void iEnterIntoSearchFieldPollingPlace(String text) {
        Helper.TEMP_DATA = text;
        electionPage.waitForSpinner();
        WebElement input = electionPage.driver.findElement(By.xpath("//input[@placeholder=\"Search\"]"));
        input.clear();
        input.sendKeys(text);
        electionPage.waitForSpinner();
    }

    @And("User click on Edit button for Polling Place")
    public void userClickOnEditButtonForPollingPlace() {
        electionPage.userClickOnEditBtnInPollingPlace();
    }

    @And("User select {string} from Edit Polling Place dropdown")
    public void userSelectFromEditPollingPlaceDropdown(String status) {
        electionPage.userSelectsEditPollingPlace(status);
    }

    @And("User click on Save button in Polling Place")
    public void userClickOnSaveButtonInPollingPlace() {
        electionPage.clickSaveBtnPollingPlace();
    }

    @And("User verify Polling Place Location is no longer part of the list of checkboxes")
    public void userVerifyPollingPlaceLocationIsNoLongerPartOfTheListOfCheckboxes() {
        electionPage.verifyPollingPlaceLocationIsNoLongerPartOfTheList(Helper.TEMP_DATA);
    }

    @And("User expands Candidate, Campaign and Office Details Tab")
    public void userExpandsCandidatesCampaignAndOfficeDetailsTab() {
        electionPage.userExpandCandidateCampaignOfficeTab();
    }

    @And("User expands Candidate Details Tab")
    public void userExpandsCandidatesDetailsTab() {
        electionPage.userExpandCandidateTab();
    }

    @Then("User verify Ballot Question Title {string} matches")
    public void userVerifyBallotQuestionTitleIsDisplayProperly(String text) {
        electionPage.userVerifyBallotQuestionTitleMatches(text);
    }


    @Then("verify District Name {string} is displaying correctly")
    public void verifyDistrictNameIsDisplayingCorrectly(String text) {
        electionPage.verifyDistrictNameIsDisplayingCorrectly(text);
    }

    @Then("verify District Type {string} is displaying correctly")
    public void verifyDistrictTypeIsDisplayingCorrectly(String text) {
        electionPage.verifyDistrictTypeIsDisplayingCorrectly(text);
    }


    @And("User click on Town Ballot Question tab")
    public void userClickOnTownBallotQuestionTab() {
        electionPage.waitAndClick(electionPage.townBallotQuestionLink);
    }

    @And("User click the ADD NEW STATEWIDE BALLOT QUESTION link")
    public void userClickTheADDNEWSTATEWIDEBALLOTQUESTIONLink() {
        electionPage.waitForSpinner();
        electionPage.userClickTheADDNEWSTATEWIDEBALLOTQUESTIONLink();
        electionPage.waitForSpinner();
    }

    @And("User deletes any existing Ballot Questions")
    public void userDeletesAnyExistingBallotQuestions() {
        electionPage.userDeletesAnyExistingBallotQuestions();

    }

    @And("User click the Save button on the Add new Election Page")
    public void userClickTheSaveButtonOnTheAddNewElectionPage() {
        electionPage.waitForSpinner();
        electionPage.userClickOnSaveButton();
        electionPage.waitForSpinner();
    }

    @And("User click the Save button on the Statewide Ballot Page")
    public void userClickTheSaveButtonOnTheStatewideBallotPage() {
        electionPage.waitForSpinner();
        electionPage.userClickOnBallotQuestionSaveButton();
        electionPage.waitForSpinner();
    }

    @And("User clicks on Edit button on a Ballot")
    public void userClicksOnEditButton() {
        electionPage.userClicksOnBallotEditButton();
    }

    @And("User verifies you are unable to make Polling Place Inactive if used in an Election")
    public void userVerifiesYouAreUnableToMakePollingPlaceInactiveIfUsedInAnElection() {
        electionPage.pollingPlaceFutureElectionMessageIsDisplayed();
    }

    @And("User click the Save button on the Countywide Ballot Page")
    public void userClickTheSaveButtonOnTheCountywideBallotPage() {
        electionPage.waitForSpinner();
        electionPage.userClickOnCountyBallotQuestionSaveButton();
        electionPage.waitForSpinner();
    }

    @And("User navigates to User Preferences for OutBound Ballot Processing page")
    public void userNavigatesToUserPreferencesForOutBoundBallotProcessingPage() {
        electionPage.userNavigatesToUserPreferencesForOBP();
    }

    private List<Map<String, String>> dataToVerify;

    @And("User selects Preferences for Outbound Ballot Processing Avery_Dymo Labels")
    public void userSelectsPreferencesForOutboundBallotProcessingAveryDymoLabels(DataTable dataTable) {

        electionPage.userClicksOnResetButtonForUserPreferences();

        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        dataToVerify = new ArrayList<>(data);
        WebElement input;
        // Iterate over each row in the DataTable
        for (Map<String, String> row : data) {
            String field = row.get("Field");
            String text = row.get("Text");

            electionPage.waitForSpinner();
            input = electionPage.waitUntilElementToBePresent(By.xpath("//h3[normalize-space()= \"Outbound Ballot Processing Avery/Dymo Labels\"]//following-sibling::label[normalize-space()= \"" + field + "\"]//following-sibling::*[1][contains(@class,'dropdown')]//button"), 15);
            electionPage.clickElementByJS(input);
            electionPage.waitForSpinner();

            WebElement op = electionPage.waitUntilElementToBePresent(By.xpath("//li[@role='option']//*[normalize-space()='" + text + "']"), 15);
            electionPage.clickElementByJS(op);

        }
    }

    @And("User clicks on Save button for User Preferences")
    public void userClicksOnSaveButtonForUserPreferences() {
        electionPage.userClicksOnSaveButtonForUserPreferences();
    }

    @And("User verifies Preferences was saved for Outbound Ballot Processing Avery_Dymo Labels")
    public void userVerifiesPreferencesWasSavedForOutboundBallotProcessingAvery_DymoLabels() {
        // Iterate over each row in the DataTable
        for (Map<String, String> row : dataToVerify) {
            String field = row.get("Field");
            String text = row.get("Text");

            WebElement input = electionPage.waitUntilElementToBePresent(By.xpath("//h3[normalize-space()= 'Outbound Ballot Processing Avery/Dymo Labels']//following-sibling::label[normalize-space()= '" + field + "']//following-sibling::span[1]"), 15);
            Assert.assertEquals(text, input.getText(), "Failed to verify the saved text for field :" + field);
        }
    }

    @And("I validate following error message on the page")
    public void iValidateFollowingErrorMessageOnThePage(DataTable dataTable) {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        // Iterate over each row in the DataTable
        for (Map<String, String> row : data) {
            String errorMessage = row.get("Required Fields");
            boolean displayed = Boolean.parseBoolean(row.get("displayed"));
            electionPage.waitForSpinner();
            WebElement input = electionPage.waitUntilElementToBePresent(By.xpath("//li[@data-testid='error' and text()='" + errorMessage + "']"), 5);
            if (displayed)
                Assert.assertNotNull(input);
            else
                Assert.assertNull(input);
        }
    }

    @And("User set following date for early voting")
    public void userSetFollowingDateForEarlyVoting(DataTable dataTable) throws ParseException {
        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
        WebElement input;

        for (Map<String, String> row : data) {
            int days = Integer.parseInt(row.get("days prior election"));
            String field = row.get("Field");
            String earlyVotingDate = electionPage.earlyVotingDate(days);
            input = electionPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*"));
            electionPage.waitForSpinner();
            input.click();
            input.clear();
            input.sendKeys(earlyVotingDate);
        }
    }


    @When("I upload a file with path {string}")
    public void iUploadAFileWithPath(String filePath) {
        electionPage.uploadFile(filePath);

    }

    @Then("User verify that the Contract is uploaded")
    public void userVerifyThatTheContractIsUploaded() {
        electionPage.contractIsDisplayed();
    }

    @And("User get the current count of contracts before")
    public void userGetTheCurrentCountOfContractsBefore() {
        electionPage.captureCountractCountBefore();
    }

    @And("User get the current count of contracts after")
    public void userGetTheCurrentCountOfContractsAfter() {
        electionPage.captureCountractCountAfter();

    }

    @And("User set a valid date for Early Voting fields")
    public void UserSetaValidDateForEarlyVotingFields() {
        electionPage.electionEarlyVotingbyMailopenDateInput.sendKeys(electionPage.getDateInFormat("MMdd", 1));
        electionPage.electionEarlyVotinginPersonopenDateInput.sendKeys(electionPage.getDateInFormat("MMdd", 1));
        electionPage.electionEarlyVotinginPersonclosedDateInput.sendKeys(electionPage.getDateInFormat("MMddyyyy", 1));
    }

    @And("User click on the {string} button in contract window")
    public void userClickOnTheButtonInContractWindow(String field) {
        electionPage.waitForSpinner();
        electionPage.clickOnSaveButtonInContractWindow();
    }
}