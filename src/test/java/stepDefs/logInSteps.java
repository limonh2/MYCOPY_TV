package stepDefs;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.Given;
import pages.HomePage;
import utils.DriverFactory;
import utils.SharedDriver;
import pages.LogInPage;


public class logInSteps {

    public LogInPage logInPage;
    public HomePage homePage;

    public logInSteps(SharedDriver driver, LogInPage logInPage) {
        this.logInPage = logInPage;
    }

    @Given("User navigate to {string} log in page")
    public void iNavigateToLogInPage(String url) throws InterruptedException {
        DriverFactory.getDriver().get(logInPage.getData().getProperty(url));
    }

    @Given("User navigate to {string}")
    public void iNavigateTo(String url) throws InterruptedException {
        DriverFactory.getDriver().get(url);
        logInPage.waitForSpinner();
    }

    @And("User log in as {string} user")
    public void iLogInAsUser(String user) {
        if (!logInPage.isPresentAndDisplayed(logInPage.loginButton)) {
            logInPage.logoutIfDisplayed();
        }
        logInPage.logIn(user);
//        logInPage.waitForSpinner();
//        logInPage.printBuildVersion();
    }
}