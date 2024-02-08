package pages;


import org.openqa.selenium.By;
import org.testng.Assert;
import utils.Base;
import utils.DriverFactory;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import utils.Helper;

import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;


public class HomePage extends Base {
    private String ballotCountBefore;
    private String ballotCountAfter;

    public HomePage() {
        PageFactory.initElements(DriverFactory.getDriver(), this);
    }

    public static Logger testLogger = Logger.getLogger(HomePage.class.getName());

    @FindBy(css = "div[data-testid='header'] img.img-site-logo")
    public WebElement siteLogo;

    @FindBy(css = "button[data-testid='name']")
    public WebElement nameButton;

    @FindBy(css = "ul[data-testid='submenu'] a[data-testid='account']")
    public WebElement accountLink;

    @FindBy(css = "ul[data-testid='submenu'] a[data-testid='settings']")
    public WebElement settingsLink;

    @FindBy(css = "ul[data-testid='submenu'] a[data-testid='preferences']")
    public WebElement preferencesLink;

    @FindBy(css = "ul[data-testid='submenu'] a[data-testid='logout']")
    public WebElement logoutLink;

    @FindBy(css = ".navbar-brand[data-testid='home']")
    public WebElement homeLink;

    @FindBy(css = ".navbar-toggler")
    public WebElement navbarToggle;

    @FindBy(css = "a.navbar-brand")
    public WebElement homeIcon;

    @FindBy(css = "a.nav-link[data-testid='menu']")
    public List<WebElement> dropdownMenus;

    @FindBy(css = "ul.dropdown-menu[data-testid='menu_options']")
    public List<WebElement> menuOptions;

    @FindBy(xpath = "//strong[text()='Current Ballots']/..//div[@class='k-grid-container']//table//tr")
    public List<WebElement> ballotRows;

    @FindBy(xpath = "(//span[@class='k-pager-info k-label'])[1]")
    public WebElement ballotCount;

    @FindBy(className = "col-md")
    public WebElement colMdElement;

    @FindBy(className = "navbar-nav")
    public WebElement navbarNavElement;

    @FindBy(className = "nav-item")
    public List<WebElement> navItems;

    @FindBy(className = "dropdown-toggle")
    public List<WebElement> dropdownToggles;

    @FindBy(className = "dropdown-item")
    public List<WebElement> dropdownItems;

    @FindBy(className = "dropdown-submenu")
    public List<WebElement> dropdownSubmenus;

    @FindBy(css = "[data-testid=\"home\"]")
    public WebElement btnHomePage;

    @FindBy(xpath = "//a[normalize-space()='Report Builder Report']")
    public WebElement reportBuilderLink;

    @FindBy(xpath = "//li//span[normalize-space()='Job Queue']")
    public WebElement menuJobQueue;

    @FindBy(xpath = "//li//span[normalize-space()='Notices']")
    public WebElement menuNoticeQueue;

    @FindBy(css = "div[data-testid='county_name']>span:first-of-type")
    public WebElement leftSidePrecinct;

    @FindBy(xpath = "//td/*[text()='']")
    public List<WebElement> blankCell;

    @FindBy(css = "a.page-link")
    public List<WebElement> paginationLink;


    // Getter methods for the elements
    public WebElement getColMdElement() {
        return colMdElement;
    }

    public WebElement getNavbarNavElement() {
        return navbarNavElement;
    }

    public List<WebElement> getNavItems() {
        return navItems;
    }

    public List<WebElement> getDropdownToggles() {
        return dropdownToggles;
    }


    public List<WebElement> getDropdownItems() {
        return dropdownItems;
    }

    public List<WebElement> getDropdownSubmenus() {
        return dropdownSubmenus;
    }
    // Add more elements as needed...

    public WebElement getHomeLink() {
        return homeLink;
    }

    public WebElement getNavbarToggle() {
        return navbarToggle;
    }

    public List<WebElement> getDropdownMenus() {
        return dropdownMenus;
    }

    public List<WebElement> getMenuOptions() {
        return menuOptions;
    }

    public List<WebElement> getTablesRows() {
        return ballotRows;
    }

    public List<WebElement> getBlankCells() {
        return blankCell;
    }

    public List<WebElement> getPaginationLinks() {
        return paginationLink;
    }

    public boolean isHomePage() {
        return verifyTitle("TotalVote");
    }

    public void clickOnJobQueue() {
        menuJobQueue.click();
        waitForSpinner();
    }

    public void clickOnNoticeQueue() {
        menuNoticeQueue.click();
        waitForSpinner();
    }

    public void clickOnReportBuilder() {
        reportBuilderLink.click();
        waitForSpinner();
    }

    public void verifyReportName() {
        String report = Helper.getReportName();
        By reportName = By.xpath("//td[normalize-space()='Finished']/following-sibling::td[normalize-space()='" + report + "']");
        Assert.assertTrue(isPresentAndDisplayed(driver.findElement(reportName)));
    }


    public void navigateToHomePage() {
        btnHomePage.click();
        waitForSpinner();
    }

    public void verifyBallotToBeSent() {
        By ballotType = By.xpath("//label[@style='font-weight:bold;'][text()='Ballots to be sent via MAIL']");
        Assert.assertTrue(isPresentAndDisplayed(driver.findElement(ballotType)));
    }


    public String captureBallotCountBefore() {
        ballotCountBefore = ballotCount.getText();
        System.out.println("Before: " + ballotCountBefore);
        return ballotCountBefore;
    }

    public String captureBallotCountAfter() {
        ballotCountAfter = ballotCount.getText();
        System.out.println("After: " + ballotCountAfter);
        return ballotCountAfter;
    }

    public void compareBallotCounts() {
        Assert.assertNotEquals(ballotCountBefore, ballotCountAfter, "Ballot counts are equal");
    }

    public void verifyPrecinctIDMatchesThePrecinctIDOnTheLeft() {
        String leftSidePrecinctValue = leftSidePrecinct.getText().replace("Precinct: ", "").trim();
        for (WebElement row : getTablesRows()) {
            String rightSidePrecinctValue = row.findElement(By.xpath("//td[10]")).getText();
            Assert.assertEquals(leftSidePrecinctValue, rightSidePrecinctValue);
        }
    }


    public void clickPageInPagination(String pageNumber) {
        getPaginationLinks().stream().filter(X -> X.getText() == pageNumber).collect(Collectors.toList()).get(0).click();
        waitForSpinner();
    }

    public void verifiesAllDataIsDisplayingProperlyInTheTable() {
        Assert.assertFalse(getBlankCells().size() > 0);
    }

    public void scrollUntilUploadButton(String uploadButton) {

        WebElement uploadButtonElement = driver.findElement(By.xpath("//button[text()='" + uploadButton + "']"));
        scrollToElement(uploadButtonElement);
    }
}