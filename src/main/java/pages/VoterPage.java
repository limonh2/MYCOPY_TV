package pages;


import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import utils.Base;
import utils.DriverFactory;
import utils.Helper;

import java.util.List;
import java.util.stream.Collectors;


public class VoterPage extends Base {

    JavascriptExecutor js = ((JavascriptExecutor) DriverFactory.getDriver());

    public static String COMPLETE_ADDRESS;
    public static String officeName;

    public VoterPage() {
        PageFactory.initElements(DriverFactory.getDriver(), this);
    }


    @FindBy(xpath = "//div[@style='display: block;']//select[@id='notice-template-select']")
    public WebElement drpNoticeName;

    @FindBy(xpath = "//div[@style='display: block;']//textarea[@data-testid=\"notes\"]")
    public WebElement inpNotesComments;

    @FindBy(xpath = "//div[@style='display: block;']//button[normalize-space()=\"Insert\"]")
    public WebElement btnInsert;

    @FindBy(xpath = "//input[@placeholder='Last Name, First']")
    public WebElement inpQuickSearch;

    @FindBy(css = ".ms-3")
    public WebElement addButton;

    @FindBy(xpath = "//button[contains(text(),'Information')]")
    public WebElement voterInformationBtn;

    @FindBy(xpath = "//button[normalize-space()='Delete' and contains(@class,'confirm')]")
    public WebElement noticeConfirmDeleteBtn;

    @FindBy(xpath = "//button[normalize-space()='Cancel' and contains(@class,'cancel')]")
    public WebElement noticeConfirmCancelBtn;

    @FindBy(xpath = "//button[text() = 'Delete']")
    public WebElement noticeDeleteBtn;

    @FindBy(xpath = "//button[text() = 'Delete']")
    public List<WebElement> noticeDeleteButton;

    @FindBy(xpath = "//button[text() = 'OK']")
    public WebElement noticeConfirmOKBtn;

    @FindBy(xpath = "//label[contains(text(), 'Address')]/parent::div//input[not(@disabled)]")
    public WebElement addressInp;

    @FindBy(xpath = "//label[contains(text(), 'City')]/parent::div//input")
    public WebElement cityInp;

    @FindBy(xpath = "//label[contains(text(), 'Zip')]/following-sibling::input[not(@disabled)]")
    public WebElement zipInp;

    @FindBy(xpath = "//div[@data-testid='residential_address']")
    public WebElement addressResidential;

    @FindBy(xpath = " //button[contains(text(),'Update')]")
    public WebElement updateAddressBtn;

    @FindBy(xpath = " //div[text()='UOCAVA: Overseas Military' and @data-testid='flag']")
    public WebElement overseasMilitaryFlag;

    @FindBy(xpath = "//textarea[@data-testid='note']")
    public WebElement inputNote;

    @FindBy(xpath = "//button[text() = 'Note']")
    public WebElement noteBtn;

    @FindBy(css = ".text-danger")
    public WebElement requiredNoteMessage;

    @FindBy(xpath = "//div[./span[text()='Status']]/following-sibling::div")
    public WebElement voterStatus;
    @FindBy(xpath = "//input[@data_test_id='registrant_search']")
    public WebElement barcodeField;

    @FindBy(xpath = "//div[./span[text()='Incomplete Reasons']]/following-sibling::div")
    public WebElement voterIncompleteReasons;

    @FindBy(xpath = "//span[@data-testid='total_size']")
    public WebElement outOfCountyMatchesReportCount;

    @FindBy(xpath = "//input[@id='PartySinceDate']")
    public WebElement PartySinceDateCalendarPicker;

    @FindBy(xpath = "//div[contains(@class, 'col-lg-8')]//div[contains(text(), 'Confidential')]")
    public WebElement voterProfileFlagLabel;

    @FindBy(css = ".voter-header i.fa-map-marker-alt")
    public WebElement mapLocator;

    @FindBy(xpath = "//label[normalize-space()='Document Is Signed']//preceding-sibling::*")
    public WebElement docIsSignedBtn;

    @FindBy(xpath = "//label[text()= 'Office']/parent::div//input")
    public WebElement officeField;

    @FindBy(xpath = "//table[@data-role='grid']//tr/td[3]")
    public List<WebElement> officeGridFirstName;

    @FindBy(xpath = "//b[@data-testid=\"full_name\"]")
    public WebElement votersFullName;

    @FindBy(xpath = "//div[class='ProfileCard-realName']")
    public WebElement votersProfileCard;

    @FindBy(xpath = "//div[./span[text()='Status Reason']]/following-sibling::div")
    public WebElement voterStatusReason;

    @FindBy(xpath = "//span[normalize-space()='SSN needs to be four digits.']")
    public WebElement voterPreAddSSNMessage;

    @FindBy(css = "select[data-testid='registration_status']")
    public WebElement registrationStatusDrpd;

    @FindBy(css = "select[data-testid='registration_status_reason']")
    public WebElement registrationStatus_ReasonDrpd;

    @FindBy(css = ".btn.btn-md.btn-primary")
    public WebElement runAllChecksBtn;

    @FindBy(xpath = "//button[text() = 'Update Registrant']")
    public WebElement updateRegistrantBtn;

    @FindBy(css = "button[title='Update Voter']")
    public WebElement updateVoterBtn;

    @FindBy(xpath = "//div[./span[text()='Flags']]/following-sibling::div")
    public WebElement voterFlags;

    public void selectNoticeNameAndAddComments(String noticeType, String comments) {
        nativeDropdownSelect(drpNoticeName, noticeType);
        inpNotesComments.sendKeys(comments);
        btnInsert.click();
    }

    public void verifyCorrespondenceTitleCreated(String type) {
        WebElement element = getElementByText(type);
        Assert.assertTrue(element.isDisplayed());
        By loc = By.xpath("//td[text()='" + type + "']/following-sibling::td[@data-testid=\"NoticeID\"]");
        Helper.NOTICE_ID = driver.findElement(loc).getText().trim();

    }

    public void enterIntoQuickSearchField(String text) {
        inpQuickSearch.sendKeys(text);
        By voterSearchResult = By.xpath("//div[@data-testid='quick_search_results']//div[normalize-space()='" + text + "']");
        waitUntilElementToBePresent(voterSearchResult, 5).click();
        driver.findElement(voterSearchResult).click();
        waitForSpinner();
    }

    public void userClickOnAddRegistrantButton() {
        addButton.click();
    }

    public void deleteCorrespondenceNotice() {
        if (!isElementPresent(noticeDeleteBtn)) {
            return;
        }
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollLeft = arguments[0].offsetWidth", noticeDeleteBtn);
        noticeDeleteBtn.click();
        noticeConfirmDeleteBtn.click();
        noticeConfirmOKBtn.click();
        waitForSpinner();
        Assert.assertEquals(noticeDeleteButton.size(), 0);
    }

    public void updateAddressField(String addressField) {
        waitForSpinner();
        addressInp.click();
        addressInp.clear();
        addressInp.sendKeys(addressField);

    }

    public void updateCityField(String cityField) {
        cityInp.click();
        cityInp.clear();
        cityInp.sendKeys(cityField);
    }

    public void updateZipField(String zipField) {
        zipInp.click();
        zipInp.clear();
        waitForSpinner();
        zipInp.sendKeys(zipField);
        //waitForSpinner();
    }

    public void verifyResidentialAddress() {
        String resAddress = addressResidential.getText().replace("\n", " ").toUpperCase();
        Assert.assertEquals(resAddress, COMPLETE_ADDRESS);
    }

    public void verifyMailingAddress() {
        String resAddress = addressResidential.getText().replace("\n", "");
        Assert.assertEquals(resAddress, COMPLETE_ADDRESS);
    }

    public void clickUpdateAddressBtn() {
        waitForSpinner();
        updateAddressBtn.click();
    }

    public void selectFormTypeDropDown(String text) {
        WebElement input = driver.findElement(By.xpath("//div[@role='document' and .//h5[text()='Scan Document']]//label[normalize-space()= 'Form Type']//following-sibling::*[contains(@class,'dropdown')]//button"));
        clickElementByJS(input);
        sleep(2);
        isPresentAndDisplayed(driver.findElement(By.xpath("//li[@role='option']//*[normalize-space()='" + text + "']")));
        WebElement loctext = driver.findElement(By.xpath("//li[@role='option']//*[normalize-space()='" + text + "']"));
        clickElementByJS(loctext);
        sleep(2);
    }

    public void verifyScanFormWasCreated(String type) {
        WebElement element = getElementByText(type);
        Assert.assertTrue(element.isDisplayed());

    }

    public void verfiesNoticesDisplayedInTheQueue(String noticeName) {
        By loc = By.xpath("//*[@id=\"taskQueueContainer\"]//a[text()='" + noticeName + "']");
        scrollToElement(driver.findElement(loc));
        clickElementByJS(driver.findElement(loc));
        Assert.assertEquals(getElementByText(Helper.NOTICE_ID).getText(), Helper.NOTICE_ID);
    }

    public void enterIntoNoteField(String text) {
        if (isElementPresent(requiredNoteMessage)) {
            noteBtn.click();
            inputNote.clear();
            inputNote.sendKeys(text);
            waitForSpinner();
        } else {

        }
    }

    public void setBarcode(String barcode) {
        waitForSpinner();
        barcodeField.sendKeys(barcode);
        barcodeField.sendKeys(Keys.ENTER);
        waitForSpinner();

    }

    public void getReportCount(String reportCount) {
        waitForSpinner();
        By xpath = By.xpath("//a[text()='" + reportCount + "']/parent::*//span[contains(@class,'rounded-pill')]");
        Helper.OUT_OF_COUNTY_MATCHES_REPORT_COUNT = driver.findElement(xpath).getText();
    }

    public void getCountyMatchesReportAndVerifyWithTaskQueue() {
        waitForSpinner();
        Integer cnt = Integer.parseInt(outOfCountyMatchesReportCount.getText()) * 2;
        Assert.assertEquals(cnt, Integer.parseInt(Helper.OUT_OF_COUNTY_MATCHES_REPORT_COUNT));
        testLogger.info("Actual Count is:" + cnt + " Expected Count is:" + Helper.OUT_OF_COUNTY_MATCHES_REPORT_COUNT);
    }

    public void verifyRegistrationInformation(List<String> data) {
        String label = data.get(0);
        String value = data.get(1);
        By labelText = By.xpath("//div[./span[text()='" + label + "']]/following-sibling::div");
        String actualValue = driver.findElement(labelText).getText().trim();
        Assert.assertEquals(actualValue, value);
    }

    public void verifyVoterInformation(List<String> data) {
        String label = data.get(0);
        String value = data.get(1);
        By labelText = By.xpath("//div[./span[text()='" + label + "']]/following-sibling::div");
        String actualValue = driver.findElement(labelText).getText().trim();
        Assert.assertEquals(actualValue, value);

    }

    public void verifyVoterDocIsSigned() {
        docIsSignedBtn.click();

    }

    public void verifyTextInCapitalLetters(String field) {
        By fieldText = By.xpath("//label[contains(text(),'" + field + "')]/following-sibling::input");
        String actualValue = driver.findElement(fieldText).getAttribute("value");
        Assert.assertEquals(actualValue, actualValue.toUpperCase());
    }

    public void enterOfficeName(String officeName) {
        this.officeName = officeName;
        officeField.sendKeys(officeName);
    }

    public void verifyOfficeAddedSuccessFully() {
        Assert.assertEquals(officeGridFirstName.stream().filter(X -> X.getText().equalsIgnoreCase(this.officeName)).collect(Collectors.toList()).get(0).getText(), officeName);
    }

    public void UserVerifyYouCanSearchForTheVoterInQuickSearch() {
        waitForSpinner();
        inpQuickSearch.sendKeys(Helper.getLastNameFirstName());
        By voterSearchResult = By.xpath("//div[@data-testid='quick_search_results']//div[normalize-space()='" + Helper.getLastNameFirstName() + "']");
        waitUntilElementToBePresent(voterSearchResult, 20).click();
        driver.findElement(voterSearchResult).click();
        waitForSpinner();
    }

    public void userVerifyYouAreUnableToSearchForVoterInQuickSearch() {
        waitForSpinner();
        inpQuickSearch.sendKeys(Helper.getLastNameFirstName());
        By voterSearchResult = By.xpath("//div[@data-testid='quick_search_results']//div[normalize-space()='" + Helper.getLastNameFirstName() + "']");
        boolean voterProfile = checkIfElementIsVisible(voterSearchResult, 8);
        Assert.assertFalse(voterProfile, "Voter name is not displayed");
    }

    public void voterPreAddSSNMessageisDisplayed() {
        Assert.assertTrue(voterPreAddSSNMessage.isDisplayed());
    }

    public void verifiesAndUpdatesVoterStatusToActive() {
        String actual = voterStatus.getText();
        String expected = "ACTIVE";
        if (actual.equals(expected)) {

        } else {
            waitForSpinner();
            updateVoterBtn.click();
            waitForSpinner();
            nativeDropdownSelect(registrationStatusDrpd, "ACTIVE");
            nativeDropdownSelect(registrationStatus_ReasonDrpd, "ACTIVE");
            runAllChecksBtn.click();
            waitForSpinner();
            updateRegistrantBtn.click();

        }

    }

    public void userVerifiesAndUpdatesVoterStatusToCanceled() {
        waitForSpinner();
        String actual = voterStatus.getText();
        String expected = "CANCELED";
        System.out.println(actual);
        if (actual.equals(expected)) {
            updateVoterBtn.click();
        } else {
            waitForSpinner();
            updateVoterBtn.click();
            waitForSpinner();
            nativeDropdownSelect(registrationStatusDrpd, "CANCELED");
            nativeDropdownSelect(registrationStatus_ReasonDrpd, "FELONY");
            runAllChecksBtn.click();

            waitForSpinner();
            updateRegistrantBtn.click();

        }
    }
}