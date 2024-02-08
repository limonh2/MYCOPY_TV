package pages;


import io.cucumber.datatable.DataTable;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import utils.Base;
import utils.DriverFactory;
import utils.Helper;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;


public class ElectionPage extends Base {
    JavascriptExecutor js = ((JavascriptExecutor) DriverFactory.getDriver());
    DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");



    public ElectionPage() {
        PageFactory.initElements(DriverFactory.getDriver(), this);
    }

    int contractOfCountBefore;
    int countOfContractAfter;

    @FindBy(css = "h4.modal-title[data-testid='heading']")
    public WebElement modalTitle;

    @FindBy(css = "button.close[aria-label='Close']")
    public WebElement closeButton;

    @FindBy(css = "select.form-select[data-testid='county']")
    public WebElement jurisdictionSelect;

    @FindBy(css = "select.form-select[data-testid='type']")
    public WebElement electionTypeSelect;

    @FindBy(xpath = "//label[text()='Election Date:']/following-sibling::input[@type='date']")
    public WebElement electionDateInput;

    @FindBy(css = "input.form-control[data-testid='name']")
    public WebElement electionNameInput;

    @FindBy(xpath = "//label[contains(text(), 'Abbreviation')]/parent::div/*[@type='text']")
    public WebElement electionAbbreviationInput;

    @FindBy(css = "textarea.form-control[data-testid='description']")
    public WebElement descriptionTextarea;

    @FindBy(css = "input.form-control[type='date'][_bl_071df0a9-e2fa-4288-9ca8-f08fd10684e6='']")
    public WebElement sendUocavaBallotsInput;

    @FindBy(css = "input.form-control[type='date'][_bl_bff4252a-d0b2-445f-8323-b71baced56be='']")
    public WebElement lastDayUocavaBallotsInput;

    @FindBy(css = "input.form-control[type='date'][_bl_4eb1f79f-4321-4d7a-ae3d-dc475731b4d0='']")
    public WebElement firstDayInStateInput;

    @FindBy(css = "input.form-control[type='date'][_bl_64486ac8-8a1f-4209-b58d-25bac9b35e20='']")
    public WebElement lastDayInStateBallotsInput;

    @FindBy(css = "input.form-control[type='date'][_bl_9a1eb2cb-41c4-41da-af57-83dc112430bc='']")
    public WebElement lastDayOutOfStateBallotsInput;

    @FindBy(css = "input.form-control[type='date'][_bl_e842d495-1284-4de2-b1f1-e8bd22950471='']")
    public WebElement lastDayNoDailyMailServiceInput;

    @FindBy(css = "input.form-control[type='date'][_bl_be98f715-c245-4334-8efd-276b922c74a6='']")
    public WebElement lastDayAbsenteeReplacementBallotsInput;

    @FindBy(css = "input.form-control[type='datetime-local'][_bl_55aa5fff-5619-4d1f-adc1-8ddc94f23227='']")
    public WebElement lastDayRequestMailBallotInput;

    @FindBy(css = "button.btn.btn-primary[data-testid='save']")
    public WebElement saveButton;

    @FindBy(css = "button.btn.btn-danger[data-testid='cancel']")
    public WebElement cancelButton;

    @FindBy(css = " [class*='modal'] h2#swal2-title")
    public WebElement modalHeader;

    @FindBy(xpath = "//div[contains(@class,'popup')]")
    public WebElement popupModal;

    @FindBy(css = "[class*='modal'] [class*='success-ring']")
    public WebElement success;

    @FindBy(xpath = "//button[text()='OK']")
    public WebElement okButton;

    @FindBy(css = "div[data-id] [data-total]")
    public WebElement ballotRow;

    @FindBy(xpath = "//input[@placeholder='Search']")
    public WebElement electionSearch;

    @FindBy(xpath = "//*[@id='printDiv']//table/tbody/tr[1]//button[contains(text(),'Select')]")
    public WebElement electionSelectBtn;

    @FindBy(xpath = "//button[normalize-space()='OK']")
    public WebElement electionOKBtn;

    @FindBy(id = "pills-county-ballot-messaures-tab")
    public WebElement countyBallotQuestionLink;


    @FindBy(id = "pills-statewide-ballot-messaures-tab")
    public WebElement StatewideBallotQuestionLink;

    @FindBy(id = "pills-statewide-ballot-messaures-tab")
    public WebElement StatewideBallotQuestionsLink;

    @FindBy(id = "pills-county-ballot-messaures-tab")
    public WebElement townBallotQuestionLink;


    @FindBy(css = "tbody .k-icon.k-i-plus")
    public WebElement plusButton;

    @FindBy(css = "span[data-testid='candidate_count']")
    public WebElement candidate_count;


    @FindBy(css ="span[data-testid='contest_count']")
    public WebElement contest_count;

    @FindBy(xpath = "//legend[contains(text(),'Searched Fields')]")
    public WebElement searchedFields;

    @FindBy(xpath = "//label[contains(text(), 'Filing Start')]/following-sibling::*")
    public WebElement contestFilingStart;

    @FindBy(xpath = "//label[contains(text(), 'Filing End')]/following-sibling::*")
    public WebElement contestFilingEnd;

    @FindBy(xpath = "//textarea[@data-testid='description']")
    public WebElement inpElectionDescription;

    @FindBy(xpath = "//li[contains(text(),'Election Abbreviation already exists.')]")
    public WebElement ElectionAbbreviationAlreadyExists;

    @FindBy(xpath = "//button[normalize-space()='Scan']")
    public WebElement scanBtnBallotSetup;

    @FindBy(xpath = "//button[normalize-space()='View']")
    public WebElement viewBtnBallotSetup;

    @FindBy(xpath = "//h5[normalize-space()='View Document']")
    public WebElement scanViewDocumentWindow;

    @FindBy(xpath = "//h4[normalize-space()='Edit Polling Place']/following-sibling::span//select")
    public WebElement selectStatusFromEditPollingPlaceDrp;

    @FindBy(xpath = "//i[contains(@class,'pencil')]/parent::button")
    public WebElement editBtnPollingPlace;

    @FindBy(xpath = "//label[normalize-space()='Election']/following-sibling::select")
    public WebElement selectElectionPollingPlaceDrp;

    @FindBy(xpath = "//div[@class='row']//label[contains(@class,'big-check')]")
    public List<WebElement> chkPlaceLocation;

    @FindBy(xpath = "//*[@style=\"display: block;\"]//button[text()='Save']")
    public WebElement saveBtnPollingPlace;

    @FindBy(css = "span[data-testid='expand_candidate_details']")
    public WebElement expandCandidate;

    @FindBy(css = "span[data-testid='expand_compaign_details']")
    public WebElement expandCampaign;

    @FindBy(css = "span[data-testid='expand_office_details']")
    public WebElement expandOffice;

    @FindBy(css = "span[data-testid='expand_contest_details']")
    public WebElement expandContest;

    @FindBy(xpath = "//*[@id='pills-county-ballot-messaures']//td[count(//*[@id='pills-county-ballot-messaures']//span[text()='Ballot Question Title']/ancestor::th/preceding-sibling::th)+1]")
    public WebElement ballotQuestionTitleText;

    @FindBy(xpath = "//*[@id='pills-statewide-ballot-messaures']//td[count(//*[@id='pills-statewide-ballot-messaures']//span[text()='District Name']/ancestor::th/preceding-sibling::th)+1]")
    public WebElement DistrictNameText;

    @FindBy(xpath = "//*[@id='pills-statewide-ballot-messaures']//td[count(//*[@id='pills-statewide-ballot-messaures']//span[text()='District Type']/ancestor::th/preceding-sibling::th)+1]")
    public WebElement DistrictTypeText;

    @FindBy(xpath = "//button[normalize-space()='ADD NEW STATEWIDE BALLOT QUESTION']")
    public WebElement addStateWideBallotQuestionlink;

    @FindBy(css = ".k-icon.k-i-delete.k-button-icon")
    public WebElement ballotQuestionDeleteBtn;

    @FindBy(xpath = "//button[contains(text(),'Yes')]")
    public WebElement confirmBallotQuestionDeletionBtn;

    @FindBy(xpath = "//div[@class='modal-content']//button[@data-testid='save']")
    public WebElement clickElectionSavebutton;


    @FindBy(xpath = "(//div[@class='modal-footer text-start']//button[@type='submit'])[2]")
    public WebElement clickElectionBallotSaveButton;

    @FindBy(xpath = "(//div[@class='modal-footer text-start']//button[@type='submit'])[2]")
    public WebElement clickElectionBallotSavebutton;

    @FindBy(xpath = "//button[normalize-space()='Create New Ballot']/following-sibling::div[@class='row']//table[@data-role='grid']//tr[1]//button[normalize-space()='Edit']")

    public WebElement ballotEditBtn;

    @FindBy(xpath = "//h4[normalize-space()='Edit Ballot']")
    public WebElement headerEditBallot;

    @FindBy(css = "#swal2-html-container")
    public WebElement pollingPlaceFutureElectionMessage;

    @FindBy(xpath = "(//button[text()='Save'])[1]")
    public WebElement clickElectionCountyBallotSavebutton;

    @FindBy(css = "#dropdown-toggle")
    public WebElement drpLogout;

    @FindBy(css = "a[data-testid='preferences']")
    public WebElement btnPreferences;

    @FindBy(xpath = "//h3[normalize-space()= 'Outbound Ballot Processing Avery/Dymo Labels']//following-sibling::div//button[normalize-space()= 'Reset']")
    public WebElement userPrefResetBtnDymo;

    @FindBy(xpath = "//h3[normalize-space()= 'Outbound Ballot Processing Avery/Dymo Labels']//following-sibling::label[normalize-space()= 'Avery order reset successful.']")
    public WebElement userPrefResetDymoUpdateMessage;

    @FindBy(xpath = "//h3[normalize-space()= 'Outbound Ballot Processing Avery/Dymo Labels']//following-sibling::div//button[normalize-space()= 'Save']")
    public WebElement userPrefSaveBtnDymo;

    @FindBy(xpath = "//h3[normalize-space()= 'Outbound Ballot Processing Avery/Dymo Labels']//following-sibling::label[normalize-space()= 'Avery order updated.']")
    public WebElement userPrefSaveDymoUpdateMessage;


    @FindBy(xpath = "//button[normalize-space()='Actions']")
    public WebElement electionActionsBtn;

    @FindBy(xpath = "//button[normalize-space()='Select Election']")
    public WebElement selectElectionBtn;

    @FindBy(xpath = "//label[text()='Early Voting by Mail open:']/following-sibling::input[@type='date']")
    public WebElement electionEarlyVotingbyMailopenDateInput;

    @FindBy(xpath = "//label[text()='Early Voting in Person open:']/following-sibling::input[@type='date']")
    public WebElement electionEarlyVotinginPersonopenDateInput;

    @FindBy(xpath = "//label[text()='Early Voting in Person closed:']/following-sibling::input[@type='date']")
    public WebElement electionEarlyVotinginPersonclosedDateInput;

    @FindBy(xpath = "//div[@class='modal-footer']//button[contains(text(),'Save') and @type='submit']")
    public WebElement SaveButtonContractWindow;

    public static final By FILE_INPUT_LOCATOR = By.xpath("//input[@type='file']");

    @FindBy(xpath = "//span[contains(text(),'Active')]")
    public List<WebElement> contractCount;





    public void enterTextInInputFields(DataTable dataTable) {

//        List<Map<String, String>> data = dataTable.asMaps(String.class, String.class);
//
//        // Iterate over each row in the DataTable
//        for (Map<String, String> row : data) {
//            String text = row.get("text");
//            String field = row.get("field");
//            try {
//                WebElement input = DriverFactory.getDriver().findElement(By.xpath("//label[contains(text(), " + "'" + field + "'" + ")]/parent::div/*[@type='text']"));
//                input.sendKeys(text);
//            } catch (Exception e) {
//
//                WebElement input = DriverFactory.getDriver().findElement(By.xpath("//label[contains(text(), " + "'" + field + "'" + ")]/parent::div/*[@type='text']"));
//                htmlDropdownSelect(input, field);
//            }
//        }
    }


    public String createElectionDate() {

        Calendar calendar = Calendar.getInstance();
        String date = null;
        try {
            calendar.add(Calendar.MONTH, 4);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        date = dateFormat.format(calendar.getTime());
        Helper.setElectionDate(date);
        return date;
    }

    public String earlyVotingDate(int daysPriorElection) throws ParseException {
        String electionDate = Helper.getElectionDate();
        LocalDate parsedDate = LocalDate.parse(electionDate, DateTimeFormatter.ofPattern("MM/dd/yyyy"));
        LocalDate newDate = parsedDate.minusDays(daysPriorElection);
        Date date = java.sql.Date.valueOf(newDate);
        return dateFormat.format(date);

    }

    public void enterDescription(String text) {
        inpElectionDescription.click();
        inpElectionDescription.clear();
        if (text.contains("randomtext")) {
            String textToReplace = generateElectionEbbreviation();
            text = text.replaceAll("randomtext", textToReplace);
        }
        inpElectionDescription.sendKeys(text);
        testLogger.info("Generated description entered value is :" + text);
    }

//    public String generateAnyStringWithRegex(){
//        String regex = "[A-Z]{2}\\\\d{2}";
//        Generex generex= new Generex("[a-zA-Z]+");
//        Xeger generator = new Xeger(regex);
//        String result = generator.generate();
//        assert result.matches(regex);
//    }

    public String generateElectionEbbreviation() {
        Random random = new Random();

        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < 2; i++) {
            char randomChar = (char) (random.nextInt(26) + 'A'); // Random uppercase letter
            stringBuilder.append(randomChar);
        }

        int randomNumber = random.nextInt(100);
        stringBuilder.append(String.format("%02d", randomNumber)); // Pad with leading zeros if necessary

        return stringBuilder.toString();
    }

    public void selectElection(String text) {
        electionSearch.sendKeys(text);
        sleep(2);
        waitAndClick(electionActionsBtn);
        waitAndClick(selectElectionBtn);
        waitAndClick(electionOKBtn);

    }

    public void clickonScanBtnBallotSetup() {
        scanBtnBallotSetup.click();
    }

    public void clickonViewBtnBallotSetup() {
        viewBtnBallotSetup.click();
    }

    public void verifyViewDocumentHeaderisDisplayed() {
        Assert.assertTrue(scanViewDocumentWindow.isDisplayed());
    }

    public void userSelectElectionFromDropPollingPlace(String election) {
        nativeDropdownSelect(selectElectionPollingPlaceDrp, election);
    }


    public void userSelectsTheCheckBoxFromList(String option) {
        By chkval = By.xpath("//label[contains(@class,'big-check') and normalize-space()=\"" + option + "\"]//input");

        WebElement element = driver.findElement(chkval);
        if (!element.isSelected()) {
            element.click();
        }

    }

    public void clickSaveBtnPollingPlace() {
        saveBtnPollingPlace.click();
    }

    public void verifyPollingPlaceLocationIsNoLongerPartOfTheList(String tempData) {
        List<String> pollingPlaceLocation = chkPlaceLocation.stream().map(WebElement::getText).toList();
        Assert.assertFalse(pollingPlaceLocation.contains(tempData));
    }

    public void verifyPollingPlaceLocationIsPartOfTheList(String tempData) {
        List<String> pollingPlaceLocation = chkPlaceLocation.stream().map(WebElement::getText).toList();
        Assert.assertTrue(pollingPlaceLocation.contains(tempData));
    }

    public void userClickOnEditBtnInPollingPlace() {
        editBtnPollingPlace.click();
        waitForSpinner();
    }

    public void userSelectsEditPollingPlace(String status) {
        nativeDropdownSelect(selectStatusFromEditPollingPlaceDrp, status);
    }

    public void userExpandCandidateCampaignOfficeTab() {
        waitForSpinner();
        expandCandidate.click();
        expandCampaign.click();
        expandOffice.click();
    }

    public void userExpandCandidateTab() {
        waitForSpinner();
        expandCandidate.click();
    }

    public void userVerifyBallotQuestionTitleMatches(String text) {
        waitForSpinner();
        String ballText = ballotQuestionTitleText.getText().trim();
        Assert.assertEquals(ballText, text);
    }

    public void verifyDistrictNameIsDisplayingCorrectly(String text) {
        waitForSpinner();
        String ballText = DistrictNameText.getText().trim();
        Assert.assertEquals(ballText, text);
    }

    public void verifyDistrictTypeIsDisplayingCorrectly(String text) {
        waitForSpinner();
        String ballText = DistrictTypeText.getText().trim();
        Assert.assertEquals(ballText, text);
    }

    public void userClickTheADDNEWSTATEWIDEBALLOTQUESTIONLink() {
        addStateWideBallotQuestionlink.click();
    }

    public void userDeletesAnyExistingBallotQuestions() {
        if (!isElementPresent(ballotQuestionDeleteBtn)) {
            return;
        }
        ballotQuestionDeleteBtn.click();
        confirmBallotQuestionDeletionBtn.click();


    }

    public void userClickOnSaveButton() {
        waitForSpinner();
        Actions actions = new Actions(driver);
        actions.moveToElement(clickElectionSavebutton).click().perform();
    }

    public void userClickOnBallotQuestionSaveButton() {
        Actions actions = new Actions(driver);
        actions.moveToElement(clickElectionBallotSaveButton).click().perform();
    }

    public void userClicksOnBallotEditButton() {
        ballotEditBtn.click();
        waitUntilElementPresent(headerEditBallot, 15);
        String ballText = headerEditBallot.getText().trim();
        Assert.assertFalse(ballText.isEmpty());
    }

    public void pollingPlaceFutureElectionMessageIsDisplayed() {
        waitForSpinner();
        Assert.assertTrue(pollingPlaceFutureElectionMessage.isDisplayed());
    }

    public void userClickOnCountyBallotQuestionSaveButton() {
        Actions actions = new Actions(driver);
        actions.moveToElement(clickElectionCountyBallotSavebutton).click().perform();
    }

    public void userNavigatesToUserPreferencesForOBP() {
        drpLogout.click();
        btnPreferences.click();
    }

    public void userClicksOnResetButtonForUserPreferences() {
        userPrefResetBtnDymo.click();
        Assert.assertTrue(userPrefResetDymoUpdateMessage.isDisplayed(), "Failed to reset the Avery selection preferences");
    }

    public void userClicksOnSaveButtonForUserPreferences() {
        userPrefSaveBtnDymo.click();
        Assert.assertTrue(userPrefSaveDymoUpdateMessage.isDisplayed(), "Failed to save the Avery selection preferences");
    }

    public void enterTimeStampElection(String text) {
        inpElectionDescription.click();
        inpElectionDescription.clear();
        if (text.contains("timestamp")) {
            String textToReplace = Helper.getDateAndTime();
            text = text.replaceAll("timestamp", textToReplace);
        }
        inpElectionDescription.sendKeys(text);
    }

    public void userSelectsAnyElectionFromDropPollingPlace() {
        waitForSpinner();
        selectElectionPollingPlaceDrp.sendKeys(Keys.ARROW_DOWN);
        selectElectionPollingPlaceDrp.sendKeys(Keys.ENTER);
        waitForSpinner();

    }

    public void uploadFile(String filePath) {
        uploadFile(filePath, FILE_INPUT_LOCATOR);
    }

    public void captureCountractCountBefore() {
        contractOfCountBefore = contractCount.size();
        System.out.println(contractOfCountBefore);
    }

    public void captureCountractCountAfter() {
         countOfContractAfter = contractCount.size();
        System.out.println(countOfContractAfter);
    }

    public void contractIsDisplayed() {
        Assert.assertNotEquals(contractOfCountBefore, countOfContractAfter, "New contract did not upload");
   }

    public void clickOnSaveButtonInContractWindow() {
        SaveButtonContractWindow.click();
    }
}