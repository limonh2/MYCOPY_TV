package stepDefs;


import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import pages.ElectionPage;
import pages.VoterPage;
import utils.Helper;
import utils.SharedDriver;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class VoterSteps {


    public VoterPage voterPage;
    public ElectionPage electionPage;

    public VoterSteps(SharedDriver driver, VoterPage voterPage) {
        this.voterPage = voterPage;
    }


    @Then("User select {string} from Notice Name dropdown and enter {string} in Notes")
    public void userSelectsNoticeNameAndEnterComments(String noticeType, String comments) {
        voterPage.selectNoticeNameAndAddComments(noticeType, comments);
    }

    @Then("User verify {string} was created successfully")
    public void userVerifyCorrespondenceWasCreatedSuccessfully(String type) {
        voterPage.verifyCorrespondenceTitleCreated(type);
    }

    @When("User enter {string} into Quick Search field")
    public void userEnterIntoQuickSearchField(String text) {
        voterPage.enterIntoQuickSearchField(text);

    }

    @And("User click on Add Registrant button")
    public void userClickOnAddRegistrantButton() {
        voterPage.userClickOnAddRegistrantButton();
        voterPage.waitForSpinner();
    }

    @Then("the new registrant should be added successfully")
    public void theNewRegistrantShouldBeAddedSuccessfully() {
        Assert.assertTrue(voterPage.voterInformationBtn.isDisplayed());
    }

    @And("User deletes any existing Correspondences")
    public void userVerifyYouCanYouDeleteTheCorrespondenceCreated() {
        voterPage.deleteCorrespondenceNotice();
    }

    @And("User updates Mailing Address")
    public void userUpdatesMailngAddress() {
        voterPage.clickUpdateAddressBtn();

        String addressField = Helper.getRandomNumber(3) + " " + Helper.getRandomString(5);
        String citField = Helper.getRandomString(6);
        String zipField = Helper.getRandomNumber(5);

        voterPage.updateAddressField(addressField);
        voterPage.updateCityField(citField);
        voterPage.updateZipField(zipField);
        VoterPage.COMPLETE_ADDRESS = String.format("%s %s AZ %s", addressField, citField, zipField).toUpperCase();
    }

    @Then("User verify Address fields were updated successfully")
    public void userVerifyAddressFieldsWereUpdatedSuccessfully() {
        voterPage.verifyResidentialAddress();
    }


    @Then("the new UOCAVA military overseas registrant should be added successfully")
    public void theNewUOCAVAMilitaryOverseasRegistrantShouldBeAddedSuccessfully() {
        Assert.assertTrue(voterPage.overseasMilitaryFlag.isDisplayed());
    }

    @And("User select {string} from Form Type dropdown")
    public void userSelectFromFormTypeDropdown(String formType) {
        voterPage.selectFormTypeDropDown(formType);
    }

    @Then("User verify {string} form was created successfully")
    public void userVerifyFormWasCreatedSuccessfully(String type) {
        voterPage.verifyScanFormWasCreated(type);
    }


    @And("User updates Mailing Address in NV")
    public void userUpdatesMailingAddressInNV() {
        voterPage.clickUpdateAddressBtn();

        String addressField = Helper.getRandomNumber(3) + " " + Helper.getRandomString(5);
        String citField = Helper.getRandomString(6);
        String zipField = Helper.getRandomNumber(5);

        voterPage.updateAddressField(addressField);
        voterPage.updateCityField(citField);
        voterPage.updateZipField(zipField);
        VoterPage.COMPLETE_ADDRESS = String.format("%s %s NV %s", addressField, citField, zipField).toUpperCase();
    }

    @Then("User verify Address fields were updated successfully in NV")
    public void userVerifyAddressFieldsWereUpdatedSuccessfullyInNV() {
        voterPage.verifyResidentialAddress();
    }

    @Then("User validates the Registration Status is set to {string}")
    public void userValidatesTheStatusIsSetTo(String status) {
        String voterStatus = voterPage.voterStatus.getText().trim();
        Assert.assertEquals(voterStatus, status);
    }

    @And("User enter {string} into Note field")
    public void userEnterIntoNoteField(String text) {
        voterPage.enterIntoNoteField(text);
    }

    @When("User enter {string} into Barcode or Registration ID field")
    public void userEnterIntoRegistrationIDField(String text) {
        voterPage.setBarcode(text);
    }

    @And("User click on {string} link")
    public void userClickOnLink(String link) {
        voterPage.getElementByLinkText(link);
    }

    @And("User creates unique data for a Registrant")
    public void userCreatesUniqueDataForARegistrant(DataTable dataTable) {
        List<Map<String, String>> originalData = dataTable.asMaps(String.class, String.class);
        List<Map<String, String>> newData = new ArrayList<>();

        for (Map<String, String> originalRow : originalData) {
            Map<String, String> newRow = new HashMap<>();

            String field = originalRow.get("Field");
            WebElement input;
            String value = originalRow.get("Text");;

            switch (field) {
                case "Last Name":
                case "First Name":
                    value = Helper.getRandomString(6);
                    newRow.put(field, value); // Use the correct key for First Name
                    break;
                case "SSN4":
                    value = Helper.getRandomNumber(4);
                    newRow.put("SSN4", value);
                    break;
                case "DL/ID #":
                    value = Helper.getRandomNumber(8);
                    newRow.put("DL/ID #", value);
                    break;
                case "Application Number":
                    value = Helper.getRandomNumber(8);
                    newRow.put("Application Number", value);
                    break;
                default:
                    value = originalRow.get("Text");
                    newRow.put(field, value);
            }
            if (value.contains("lower"))
                value = value.toLowerCase();

            input = voterPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*"));
            if (!input.getTagName().equals("input") && !input.getTagName().equals("textarea")) {
                input = voterPage.driver.findElement(By.xpath("//label[contains(text(), '" + field + "')]/following-sibling::*/*"));
            }
            input.click();
            input.clear();
            input.sendKeys(value);

            newData.add(newRow);
        }
        Helper.setRegistrantData(newData);
        System.out.println("Helper data set to: " + Helper.getRegistrantData());

        String firstName = Helper.getRegistrantData().get(1).get("First Name");
        String lastName = Helper.getRegistrantData().get(0).get("Last Name");
        String lastNameFirstName = lastName + ", " + firstName;

        Helper.setLastNameFirstName(lastNameFirstName);
    }

    @Then("User should see the registrants name matches")
    public void userShouldSeeTheRegistrantsNameMatches() {
        List<Map<String, String>> voterData = Helper.getRegistrantData();
        String firstName = "";
        String lastName = "";
        String fullName = "";

        for (Map<String, String> voterRow : voterData) {
            String tempFirstName = voterRow.get("First Name");
            String tempLastName = voterRow.get("Last Name");

            if (tempFirstName != null && !tempFirstName.isEmpty()) {
                firstName = tempFirstName;
            }

            if (tempLastName != null && !tempLastName.isEmpty()) {
                lastName = tempLastName;
            }
        }
        fullName = firstName + " " + lastName;

        Helper.setVoterName(fullName);

        WebElement registrant = voterPage.driver.findElement(By.xpath("//li//div[contains(text(),'" + fullName + "')]"));
        Assert.assertTrue(registrant.isDisplayed(), "Registrant not found");
    }

    @And("User click on {string} report and get count")
    public void userClickOnReport(String report) {
        voterPage.getReportCount(report);
    }

    @Then("User validates Voter has the Incomplete Reasons is set to {string}")
    public void userValidatesVoterHasTheIncompleteReasonsIsSetTo(String incompReasons) {
        String voterStatus = voterPage.voterIncompleteReasons.getText().trim().replaceAll("\n", " ");
        Assert.assertEquals(voterStatus, incompReasons);
    }

    @And("User verify report counts matches Task Queue")
    public void userVerifyReportCountsMatchesTaskQueue() {
        voterPage.getCountyMatchesReportAndVerifyWithTaskQueue();

    }

    @Then("The voter is set to {string}")
    public void theVoterIsSetTo(String status) {
        String voterStatus = voterPage.voterProfileFlagLabel.getText().trim();
        Assert.assertEquals(voterStatus, status);
    }

    @And("User verifies all Registration information")
    public void userVerifiesAllRegistrationInformation(DataTable dataTable) {
        List<List<String>> labelValues = dataTable.asLists();
        for (List<String> data : labelValues) {
            voterPage.verifyRegistrationInformation(data);
        }
    }

    @And("User verifies all Voter information")
    public void userVerifiesAllVoterInformation(DataTable dataTable) {
        List<List<String>> labelValues = dataTable.asLists();
        for (List<String> data : labelValues) {
            voterPage.verifyVoterInformation(data);
        }
    }

    @And("User click on Residential Address map link")
    public void userClickOnResidentialAddressMapLink() {
        voterPage.mapLocator.click();
        voterPage.waitUntilElementAppear(voterPage.map);
    }

    @And("User verifies in template {string} the notice displayed in the queue")
    public void userVerifiesInTemplateTheNoticeDisplayedInTheQueue(String noticeName) {
        voterPage.verfiesNoticesDisplayedInTheQueue(noticeName);
    }

    @And("User verifies Document is Signed")
    public void userVerfiesDocumentIsSigned() {
        voterPage.verifyVoterDocIsSigned();
    }

    @Then("User verifies Last Name and First Name updated to Capital letters")
    public void userVerifiesLastNameAndFirstNameUpdatedToCapitalLetters() {
        voterPage.verifyTextInCapitalLetters("First Name");
        voterPage.verifyTextInCapitalLetters("Last Name");
    }

    @When("User enters office name as {string}")
    public void user_enters_office_name_as(String officeName) {
        officeName = officeName.replace("Random", Helper.getRandomNumber(4));
        voterPage.enterOfficeName(officeName);
    }
    @Then("User verify office has been added.")
    public void user_verify_office_has_been_added() {
        voterPage.verifyOfficeAddedSuccessFully();
    }

    @And("User captures the Voters Full Name")
    public void userCapturesTheVotersFullName() {
        Helper.votersFullName = String.valueOf(voterPage.votersFullName.getText());
    }

    @Then("User verify you can search for the Voter in QuickSearch")
    public void UserVerifyYouCanSearchForTheVoterInQuickSearch() {
        voterPage.UserVerifyYouCanSearchForTheVoterInQuickSearch();

    }

    @Then("User verify you are unable to search for Voter in QuickSearch")
    public void userVerifyYouAreUnableToSearchForVoterInQuickSearch() {
        voterPage.userVerifyYouAreUnableToSearchForVoterInQuickSearch();
    }

    @Then("User validates the Registration Status Reason is set to {string}")
    public void userValidatesTheRegistrationStatusReasonIsSetTo(String status) {
        String voterStatus = voterPage.voterStatusReason.getText().trim();
        Assert.assertEquals(voterStatus, status);
    }

    @And("Displays message SSN required four digits")
    public void displaysMessageSSNRequiredDigits() {
        voterPage.voterPreAddSSNMessageisDisplayed();
    }

    @And("User verifies and updates Voter Status to Active")
    public void userVerifiesAndUpdatesVoterStatusToActive() {
        voterPage.verifiesAndUpdatesVoterStatusToActive();
    }

    @And("User verifies and updates Voter Status to Canceled")
    public void userVerifiesAndUpdatesVoterStatusToCanceled() {
        voterPage.userVerifiesAndUpdatesVoterStatusToCanceled();
    }

    @Then("User validates Voter has the Flags is set to {string}")
    public void userValidatesVoterHasTheFlagsIsSetTo(String flag) {
        String voterStatus=voterPage.voterFlags.getText().trim().replaceAll("\n"," ");
        Assert.assertEquals(voterStatus,flag);
    }
}