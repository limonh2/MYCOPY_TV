package pages;

import utils.Base;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import utils.DriverFactory;

import java.util.List;


public class LogInPage extends Base {

//    JavascriptExecutor js = ((JavascriptExecutor) Base.getDriver());

    public LogInPage() {

        PageFactory.initElements(DriverFactory.getDriver(), this);
    }

    DataReader dataReader = new DataReader();

    @FindBy(css = "img[data-testid='seal_image']")
    public WebElement sealImage;

    @FindBy(css = "h3[data-testid='heading']")
    public WebElement heading;

    @FindBy(css = "input[data-testid='yubikey_field']")
    public WebElement yubiKeyField;

    @FindBy(css = "input[data-testid='username_field']")
    public WebElement usernameField;

    @FindBy(css = "input[data-testid='password_field']")
    public WebElement passwordField;

    @FindBy(css = "button[data-testid='login_button']")
    public WebElement loginButton;

    @FindBy(css = "button[data-testid='forgot_password_button']")
    public WebElement forgotPasswordButton;

    @FindBy(className = "validation-errors")
    public WebElement validationErrors;

    @FindBy(className = "validation-message")
    public List<WebElement> validationMessages;

    @FindBy(css = "#dropdown-toggle")
    public WebElement drpLogout;

    @FindBy(css = "a[data-testid=\"logout\"]")
    public WebElement btnLogout;

    @FindBy(xpath = "//button[text()='Yes']")
    public WebElement popUpYes;

    @FindBy(css = "div.footer-version")
    public WebElement buildVersion;

    // Page actions
    public void enterYubiKey(String yubiKey) {
        yubiKeyField.sendKeys(yubiKey);
    }

    public void enterUsername(String username) {
        usernameField.sendKeys(username);
    }

    public void enterPassword(String password) {
        passwordField.sendKeys(password);
    }

    public void clickLoginButton() {
        loginButton.click();
    }

    public void clickForgotPasswordButton() {
        forgotPasswordButton.click();
    }

    public void click(WebElement ele) {
        ele.click();
    }

//    public void input_text(String userID, String pass) {
//        userId.sendKeys(userID);
//        password.sendKeys(pass);
//    }

    public void logInAsUser(String user) {
        usernameField.sendKeys();
        if (user.contains("core")) {
            passwordField.sendKeys(getData().getProperty("pwd"));
        }
        if (user.contains("state")) {
            passwordField.sendKeys(getData().getProperty("pwd"));
        } else {
            passwordField.sendKeys(getData().getProperty("pwd"));
        }
        sleep(5);
    }
    

    public void selectConsentCheckBox() {
        yubiKeyField.click();
    }

    public void logIn(String user) {
        usernameField.sendKeys(dataReader.getUser(user));
        passwordField.sendKeys(dataReader.getPassword(user));
        loginButton.click();
        waitForSpinner();
    }

    public void logoutIfDisplayed() {
        if(isPresentAndDisplayed(drpLogout)){
            drpLogout.click();
            waitUntilElementPresent(btnLogout,15);
            btnLogout.click();
            popUpYes.click();
        }
    }

    public void printBuildVersion () {
        waitForSpinner();
        testLogger.info("CORE Build:"+ buildVersion.getText());
    }
}