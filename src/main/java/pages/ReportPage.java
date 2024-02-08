package pages;


import io.cucumber.datatable.DataTable;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import utils.Base;
import utils.DriverFactory;
import utils.Helper;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;


public class ReportPage extends Base {

    JavascriptExecutor js = ((JavascriptExecutor) DriverFactory.getDriver());

    public ReportPage() {
        PageFactory.initElements(DriverFactory.getDriver(), this);
    }

    @FindBy(xpath = "//td[normalize-space()='Candidate Proofing']")
    public WebElement checkboxCandidateProofing;

    @FindBy(css = "input[placeholder=\"Enter a name for your report\"]")
    public WebElement reportName;

    @FindBy(xpath = "//label[text()='Description']/following-sibling::textarea")
    public WebElement reportDescription;

    @FindBy(xpath = "//h5[text()='Created Reports']//following-sibling::small[text()]")
    public WebElement reportBuilderReportsCount;


    public void userEntersReportName(String report) {
        reportName.click();
        reportName.sendKeys(report);
    }

    public void userEntersReportDescription(String desc) {
        reportDescription.click();
        reportDescription.sendKeys(desc);
    }


    public void clickOnReportRunButton() {
        String report = Helper.getReportName();
        By btnRun = By.xpath("//td[text()='" + report + "']/following-sibling::td//button[contains(normalize-space(),'Run')]");
        driver.findElement(btnRun).click();
    }

    public void downloadReport() {
        String report = Helper.getReportName();
        By reportName = By.xpath("//td[normalize-space()='" + report + "']/parent::tr/td/button[text()='Download']");
        driver.findElement(reportName).click();
    }


    /* TODO implementing the validation */
    private static boolean isFileDownloaded(String filePath) {
        try {
            Path path = Paths.get(filePath);
            byte[] fileBytes = Files.readAllBytes(path);
            return !(fileBytes.length == 0);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /* TODO implementing the validation */
    public void validateFileIsDownloaded() {
        String downloadFolderPath = "C:\\Downloads\\";
        String fileName = Helper.getDateAndTime() + "DownloadedReportFile.csv";
        String downloadedFilePath = downloadFolderPath + File.separator + fileName;

        testLogger.info("File is downloaded in " + downloadedFilePath);
        if (isFileDownloaded(downloadedFilePath)) {
            System.out.println("File downloaded successfully.");
        } else {
            System.out.println("File download failed or file does not match expected content.");
        }

    }
}

