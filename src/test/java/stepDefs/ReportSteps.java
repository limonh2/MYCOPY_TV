package stepDefs;


import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.Given;
import io.cucumber.datatable.DataTable;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.testng.Assert;
import pages.ElectionPage;
import pages.HomePage;

import pages.ReportPage;
import utils.Helper;
import utils.SharedDriver;

import java.util.List;
import java.util.Map;
import java.util.Objects;


public class ReportSteps {


    public ReportPage reportPage;
    public HomePage homePage;

    int reportbuilderReport_count = 0;

    public ReportSteps(SharedDriver driver, ReportPage reportPage) {
        this.reportPage = reportPage;
    }

    @Then("User verify the {string} report was generated")
    public void userVerifyTheReportWasGenerated(String reportName) {
        reportPage.getElementByLinkText(reportName).click();
        reportPage.waitForSpinner();
        By report = By.xpath("//div[normalize-space()='" + reportName + "']");
        reportPage.isElementVisible(report);
    }

    @And("User select the checkbox {string} from Reports")
    public void userCheckTheReportFromReports(String reportName) {
        reportPage.getElementByText(reportName).click();
        reportPage.waitForSpinner();
        By report = By.xpath("//td[normalize-space()='" + reportName + "']");
        reportPage.isElementVisible(report);

    }


    @And("User enters {string} into Report Name field")
    public void userEntersIntoReportNameField(String reportName) {
        String report = Helper.getReportName();
        if (reportName.contains("randomtext")) {
            String textToReplace = Helper.getRandomString(6);
            report = reportName.replaceAll("randomtext", textToReplace);
            Helper.setReportName(report);
        }
        reportPage.userEntersReportName(report);

    }

    @And("User enters {string} into Report Description field")
    public void userEntersIntoReportDescriptionField(String reportDescription) {
        if (reportDescription.contains("randomtext")) {
            String textToReplace = Helper.getRandomString(6);
            reportDescription = reportDescription.replaceAll("randomtext", textToReplace);
        }
        reportPage.userEntersReportDescription(reportDescription);
    }


    @And("User verify Report Name and click on Run button")
    public void userVerifyReportNameAndClickOnRunButton() {
        reportPage.clickOnReportRunButton();
    }


    @And("I download the report")
    public void iDownloadTheReport() {
        reportPage.downloadReport();
        reportPage.waitForSpinner();
    }

    @Then("I validate the file was downloaded")
    public void iValidateTheFileWasDownloaded() {
        reportPage.waitForSpinner();
        reportPage.validateFileIsDownloaded();
    }
}


