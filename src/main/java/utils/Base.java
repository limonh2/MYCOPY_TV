package utils;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.*;
import org.testng.Assert;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;


/**
 * utils.Base page that holds common objects, initializes page objects, initializes web-driver and opens browser
 *
 * @version R4.45
 */


public class Base extends LoadableComponent<Base> {

    public static Properties prop;

    //        public static Scenario scenario;
    public static final URL scriptUrl = Base.class.getResource("/axe.min.js");

    public Base() {
        PageFactory.initElements(DriverFactory.getDriver(), this);
    }

    public WebDriver driver = DriverFactory.getDriver();
    JavascriptExecutor js = (JavascriptExecutor) driver;


    public static Logger testLogger = Logger.getLogger(Base.class.getName());

    public Properties getData() {
        try {
            prop = new Properties();
            FileInputStream data = new FileInputStream("testData.properties");
            prop.load(data);
        } catch (FileNotFoundException e) {
            e.getMessage();
        } catch (IOException e) {
            e.getMessage();
        }
        return prop;
    }


    static {
        Logger.getLogger("").getHandlers()[0].setLevel(Level.FINE);
        testLogger.setLevel(Level.parse("ALL"));
    }

    public By spinnerBy = By.cssSelector(".sk-chase .sk-chase-dot");
    public By modalBy = By.cssSelector(".modal");
    public By modalContent = By.cssSelector(".modal");

    public By map = By.cssSelector("div#mapid .btn");


    @FindBy(css = ".card-header")
    public WebElement subTitle;
    @FindBy(css = ".sk-chase .sk-chase-dot")
    public List<WebElement> spinnerContainer;

    @FindBy(css = ".modal")
    public WebElement modal;

    @FindBy(css = "input[type='radio']")
    public List<WebElement> customRadioButtons;

    @FindBy(css = "div button")
    public List<WebElement> buttons;


    protected final By byToViewInfoButton = new By.ByCssSelector(".open [data-test-element='candidate-item-view-info']");
    protected final By byToItemName = new By.ByCssSelector("span.rx-listview-title-text");
    protected final By byToEllipsesForcandidates = new By.ByCssSelector("div.rx-listview-button-panel button");

    int ballotRow = 0;


    /**
     * constructor that initializes web-driver and page-objects
     */


//    public static WebDriver getDriver() {
//        return getDriver();
//    }
    public void sleep(int sec) {
        try {
            Thread.sleep(sec * 1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public void clickElementByJS(WebElement element) {
        js.executeScript("arguments[0].click();", element);
    }

    public void enterText(WebElement element, String txt) {
        js.executeScript("arguments[0].value='" + txt + "'", element);
    }

    public boolean verifyTitle(String expectedTitle) {
        String title = driver.getTitle();
        return title.equals(expectedTitle);
    }

    public boolean verifyCardTitle(String expectedTitle) {
        String header = subTitle.getText();
        return header.equals(expectedTitle);
    }

    public void getInnerText(WebElement ele, String expValue) {
        String actual = (String) ((JavascriptExecutor) DriverFactory.getDriver()).executeScript("return arguments[0].innerHTML;", ele);
        Assert.assertEquals(expValue, actual);
    }

    public void waitUntilElementIsGone(WebElement element, int seconds) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(seconds));
        wait.until(new ElementNotPresent(element));
    }


    public void waitUntilElementDisappears(By by) {
        waitUntilElementDisappears(by, 10);
    }


    public void waitUntilElementDisappears(By by, int timeoutInSeconds) {
        if (driver.findElements(by).size() > 0) {
            FluentWait<WebDriver> wait = new FluentWait<>(driver)
                    .withTimeout(Duration.ofSeconds(timeoutInSeconds))
                    .pollingEvery(Duration.ofSeconds(1))
                    .ignoring(NoSuchElementException.class);
            wait.until(ExpectedConditions.invisibilityOfElementLocated(by));
        }
    }


    public void waitUntilElementAppear(By by) {
        if (driver.findElements(by).size() > 0) {
            FluentWait<WebDriver> wait = new FluentWait<>(driver)
                    .withTimeout(Duration.ofMinutes(5))
                    .pollingEvery(Duration.ofSeconds(1));
            wait.until(ExpectedConditions.visibilityOfElementLocated(by));
        }
    }


    public void isElementVisible(By by) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));
        wait.until(ExpectedConditions.visibilityOfElementLocated(by));
    }


    public void isElementRemoved(By by) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));
        wait.until(ExpectedConditions.invisibilityOfElementLocated(by));
    }


    public void waitUntilElementPresent(WebElement element, int seconds) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(seconds));
        wait.until(new ElementPresent(element));
    }


    public void waitUntilRowsPopulated(List<WebElement> elements, int seconds) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(seconds));
        wait.until(new IsRowPopulated(elements));
    }


    public void waitUntilElementIsClickable(WebElement element, int timeout) {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofSeconds(timeout))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class);
        wait.until(ExpectedConditions.elementToBeClickable(element));
    }


    public void waitUntilElementIsNotClickable(WebElement element, int timeout) {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofSeconds(timeout))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class);
        wait.until(new ElementIsNotClickable(element));
    }


    public void waitUntilElementHasClass(WebElement element, String className, int timeout) {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofSeconds(timeout))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class);
        wait.until(new ElementHasClass(element, className));
    }


    public void waitUntilElementNotHasClass(WebElement element, String className, int timeout) {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofSeconds(timeout))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class);
        wait.until(new ElementNotHasClass(element, className));
    }

    public void waitUntilTextToBePresentInElement(WebElement element, String text, int timeout) {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofSeconds(timeout))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(StaleElementReferenceException.class)
                .ignoring(NoSuchElementException.class);
        wait.until(ExpectedConditions.textToBePresentInElement(element, text));
    }

    public WebElement waitUntilElementToBePresent(By locator, int timeout) {
        try {
            FluentWait<WebDriver> wait = new FluentWait<>(driver)
                    .withTimeout(Duration.ofSeconds(timeout))
                    .pollingEvery(Duration.ofSeconds(1))
                    .ignoring(StaleElementReferenceException.class)
                    .ignoring(NoSuchElementException.class);
            return wait.until(ExpectedConditions.presenceOfElementLocated(locator));
        } catch (Exception e) {
            return null;
        }

    }

    public void waitUntilAttributeContainsInElement(WebElement element, String attr, String text, int timeout) {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofSeconds(timeout))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class)
                .ignoring(StaleElementReferenceException.class);
        wait.until(ExpectedConditions.attributeContains(element, attr, text));
    }

    public boolean isTextToBePresentInElement(WebElement element, String text, int timeout) {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofSeconds(timeout))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class);
        try {
            wait.until(ExpectedConditions.textToBePresentInElement(element, text));
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public void waitForUrlToContain(String url) {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofMinutes(2))
                .pollingEvery(Duration.ofSeconds(1));
        wait.until(ExpectedConditions.urlContains(url));
    }

    public void waitUntilNewTabIsOpen() {
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofMinutes(2))
                .pollingEvery(Duration.ofSeconds(1))
                .ignoring(NoSuchElementException.class);
        try {
            wait.until(x -> driver.getWindowHandles().size() > 1);
        } catch (TimeoutException e) {
            testLogger.fine("There is still one tab open");
        }
    }


    public void waitUntilSpinnerIsGone() {
        waitUntilSpinnerIsGone(2);
    }


    public void waitUntilSpinnerIsGone(int minute) {
        testLogger.fine("waitUntilSpinnerIsGone is called");
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .withTimeout(Duration.ofMinutes(minute))
                .pollingEvery(Duration.ofMillis(250))
                .ignoring(NoSuchElementException.class);
        wait.until(ExpectedConditions.invisibilityOfElementLocated(spinnerBy));
//        testLogger.fine("There is still a spinner active in: " + scenario.getName());
    }


    /**
     * Waits until the spinner on the page has disappeared, then returns. Will wait until
     * the timeout in seconds provided has been reached before failing.
     *
     * @param timeout - Number of seconds to wait as an int
     */
    public void waitForSpinner(int timeout) {
        try {
            checkIfElementIsVisible(spinnerBy, 2);
            FluentWait<WebDriver> wait = new FluentWait<>(driver)
                    .withTimeout(Duration.ofSeconds(timeout))
                    .pollingEvery(Duration.ofSeconds(1))
                    .ignoring(NoSuchElementException.class);
            wait.until(ExpectedConditions.invisibilityOfElementLocated(spinnerBy));
        } catch (Exception e) {
            testLogger.fine("Spinner active....");
        }
    }

    public void waitForSpinner() {
        waitForSpinner(10);
    }


    public void waitUntilOverlayIsGone() {
        testLogger.fine("waitUntilOverlayIsGone is called");
        if (driver.findElements(modalBy).size() > 0) {
            try {
                FluentWait<WebDriver> wait = new FluentWait<>(driver)
                        .withTimeout(Duration.ofSeconds(60))
                        .pollingEvery(Duration.ofMillis(250))
                        .ignoring(NoSuchElementException.class);
                wait.until(ExpectedConditions.invisibilityOfElementLocated(modalBy));
            } catch (Exception e) {
                testLogger.fine("Error in resolving overlay");
            }
        }
    }

    public void waitUntilOverlayIsPresent() {
        if (driver.findElements(modalBy).size() > 0) {
            try {
                testLogger.fine("waitUntilOverlayIsPrsent is called");
                FluentWait<WebDriver> wait = new FluentWait<>(driver)
                        .withTimeout(Duration.ofSeconds(60))
                        .pollingEvery(Duration.ofMillis(250))
                        .ignoring(NoSuchElementException.class);
                wait.until(ExpectedConditions.visibilityOfElementLocated(modalBy));
            } catch (Exception e) {
                testLogger.fine("Error in resolving overlay");
            }
        }
    }

    public boolean checkIfElementIsVisible(By locator, int timeout) {
        try {
            testLogger.fine("waitUntilElementIsVisible is called");
            FluentWait<WebDriver> wait = new FluentWait<>(driver)
                    .withTimeout(Duration.ofSeconds(timeout))
                    .pollingEvery(Duration.ofMillis(500))
                    .ignoring(NoSuchElementException.class);
            wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
            return true;
        } catch (Exception e) {
            testLogger.fine("Element is not visible");
            return false;
        }
    }

    public boolean isOverlayPresent() {
        waitForSpinner();
        return isPresentAndDisplayed(modal);
    }


    public static boolean isPresentAndDisplayed(final WebElement element) {
        try {
            return element.isDisplayed();
        } catch (NoSuchElementException | StaleElementReferenceException e) {
            testLogger.warning("isPresentAndDisplayed: Exception found - " + e.getMessage());
            return false;
        }
    }

    public List<String> getBrowserTabs() {
        Set<String> tabs = driver.getWindowHandles();
        final Iterator<String> itr = tabs.iterator();
        List<String> result = new ArrayList<>();
        result.add(itr.next());


        while (itr.hasNext()) {
            result.add(itr.next());
        }

        return result;
    }


    public void moveToLastTab() {
        Set<String> tabs = driver.getWindowHandles();
        final Iterator<String> itr = tabs.iterator();
        String lastElement = itr.next();

        while (itr.hasNext()) {
            lastElement = itr.next();
        }
        driver.switchTo().window(lastElement);
    }

    public void switchToNewWindow() {
        Helper.PARENT_WINID = driver.getWindowHandle();
        Set<String> tabs = driver.getWindowHandles();
        List<String> wns = new ArrayList<>(tabs);
        wns.remove(Helper.PARENT_WINID);
        driver.switchTo().window(wns.get(0));
    }

    public void switchToParentWindow() {
        driver.switchTo().window(Helper.PARENT_WINID);
    }

    public void openInTab(String url) {
        ((JavascriptExecutor) driver).executeScript("window.open('about:blank','_blank');");
        moveToLastTab();
        driver.navigate().to(url);
    }


    public void openInTabs(List<String> urls) {
        driver.navigate().to(urls.get(0));
        for (int i = 1; i < urls.size(); i++) {
            ((JavascriptExecutor) driver).executeScript("window.open('about:blank','_blank');");
            moveToLastTab();
            driver.navigate().to(urls.get(i));
        }
    }


    public void closeCurrentTab() {
        if (driver.getWindowHandles().size() > 1) {
            driver.close();
            this.moveToLastTab();
        }
    }


    public boolean isRadioButtonShown(String searchText) {
        long count = this.customRadioButtons.stream()
                .filter(chkbox -> {
                    WebElement parent = chkbox.findElement(By.xpath(".."));
                    return parent.isDisplayed() && parent.getText().split("\n")[0].contains(searchText);
                }).count();
        return count > 0;
    }

    public class ElementNotPresent implements ExpectedCondition<Boolean> {
        WebElement element;


        public ElementNotPresent(WebElement element) {
            this.element = element;
        }


        public Boolean apply(WebDriver driver) {
            return !isPresentAndDisplayed(element);
        }
    }


    public class ElementPresent implements ExpectedCondition<Boolean> {
        WebElement element;


        public ElementPresent(WebElement element) {
            this.element = element;
        }

        public Boolean apply(WebDriver driver) {
            return isPresentAndDisplayed(element);
        }
    }


    public class ElementIsNotClickable implements ExpectedCondition<Boolean> {
        WebElement element;


        public ElementIsNotClickable(WebElement element) {
            this.element = element;
        }


        public Boolean apply(WebDriver driver) {
            String pointerEvents = this.element.getCssValue("pointer-events");
            return !isPresentAndDisplayed(this.element) || pointerEvents.equals("none");
        }
    }


    public class ElementHasClass implements ExpectedCondition<Boolean> {
        WebElement element;
        String className;


        public ElementHasClass(WebElement element, String className) {
            this.element = element;
            this.className = className;
        }


        public Boolean apply(WebDriver driver) {
            return this.element.getAttribute("class").contains(className);
        }
    }


    public class ElementNotHasClass implements ExpectedCondition<Boolean> {
        WebElement element;
        String className;


        public ElementNotHasClass(WebElement element, String className) {
            this.element = element;
            this.className = className;
        }


        public Boolean apply(WebDriver driver) {
            return !this.element.getAttribute("class").contains(className);
        }
    }


    protected class IsRowPopulated implements ExpectedCondition<Boolean> {
        List<WebElement> rows;


        public IsRowPopulated(List<WebElement> rows) {
            this.rows = rows;
        }


        public Boolean apply(WebDriver driver) {
            return isRowPopulated(rows);
        }


    }


//    public WebElement getElementByText(String text) {
//        List<WebElement> matches = driver.findElements(By.xpath("//button[contains(text(),'" + text + "')]"));
//        try {
//            return matches.stream()
//                    .filter(WebElement::isDisplayed)
//                    .findFirst()
//                    .orElseThrow(() -> new AssertionError("Button with text: " + text + " not found"));
//        } catch (ElementNotInteractableException e) {
//            return matches.get(1);
//        }
//    }

    public WebElement getElementByText(String text) {
        try {
            if (driver.findElements(By.xpath("//*[(text() = '" + text + "')]")).size() > 0)
                return driver.findElement(By.xpath("//*[(text() = '" + text + "')]"));

            else if (driver.findElements(By.xpath("//*[(text() = " + "'" + text + "'" + ")]")).size() > 0)
                return driver.findElement(By.xpath("//*[(text() = " + "'" + text + "'" + ")]"));

            else
                return driver.findElement(By.xpath("//*[contains(text()," + "'" + text + "'" + ")]"));

        } catch (NoSuchElementException e) {
            return null;
        }
    }


    public WebElement getElementByLinkText(String text) {
        try {
            if (driver.findElements(By.xpath("//*[(text() = '" + text + "') and @href]")).size() > 0)
                return driver.findElement(By.xpath("//*[(text() = '" + text + "') and @href]"));

            else if (driver.findElements(By.xpath("//*[(text() = " + "'" + text + "'" + ") and @href]")).size() > 0)
                return driver.findElement(By.xpath("//*[(text() = " + "'" + text + "'" + ") and @href]"));

            else
                return driver.findElement(By.xpath("//*[contains(text()," + "'" + text + "'" + ") and @href]"));

        } catch (NoSuchElementException e) {
            return null;
        }
    }

    public WebElement getButtonElementByText(String text) {
        try {
            if (driver.findElements(By.xpath("//button[text() = '" + text + "'] | //button//span[text()='" + text + "']")).size() > 0)
                return driver.findElement(By.xpath("//button[text() = '" + text + "'] | //button//span[text()='" + text + "']"));
            else
                return driver.findElement(By.xpath("//button[contains(text(),'" + text + "')] | //button//span[contains(text(),'" + text + "')]"));
        } catch (NoSuchElementException e) {
            return null;
        }
    }


    public WebElement getSelectDropdownByLabel(String field) {
        List<WebElement> els = driver.findElements(By.xpath("//label[text()='" + field + "']/parent::div/select"));
        if (els.size() == 0)
            els = driver.findElements(By.xpath("//label[contains(text(), '" + field + "')]/parent::div/select"));
        if (els.size() > 0)
            return els.get(0);
        else
            return null;
    }

    public void htmlDropdownSelect(WebElement element, String selectItem) {
        element.click();
        waitForSpinner();
        getElementByText(selectItem).click();
        waitForSpinner();
    }

    public void htmlDropdownSelectLinkText(WebElement element, String selectItem) {
        element.click();
        waitForSpinner();
        getElementByLinkText(selectItem).click();
        waitForSpinner();
    }

//    public void htmlDropdownSelect(WebElement element, String selectItem, int order) {
//        element.click();
//        element.findElements(dropdownItemBy).stream()
//                .filter(el -> el.isDisplayed() && el.getText().split("\n")[0].equals(selectItem))
//                .collect(Collectors.toList()).get(order)
//                .click();
//    }


//    public void waitUntilSorted() {
//        waitUntilElementPresent(modal, 120);
//        if (!isPresentAndDisplayed(modifyDesc)) {
//            if (isPresentAndDisplayed(modify)) {
//                waitUntilElementIsGone(projectSpinner, 60);
//                modify.click();
//                waitUntilElementPresent(modifyDesc, 120);
//                waitForSpinner();
//            } else return;
//        } else return;
//    }


    public void nativeDropdownSelect(WebElement element, String selectItem) {
        Select select = new Select(element);
        select.selectByVisibleText(selectItem);
    }


    public void nativeDropdownSelectByLabel(WebElement element, String label) {
        Select select = new Select(element);
        for (WebElement option : select.getOptions()) {
            if (option.getAttribute("label").equals(label)) {
                select.selectByValue(option.getAttribute("value"));
            }
        }
    }


    public boolean isNativeDropdownSelected(WebElement element, String selectedItem) {
        Select select = new Select(element);
        return select.getAllSelectedOptions().size() > 0
                && select.getAllSelectedOptions().get(0).getText().equals(selectedItem);
    }


    public void nativeDropdownValue(WebElement element, String selectItem) {
        Select select = new Select(element);
        select.selectByValue(selectItem);
    }


    public List<String> getSelectOptions(WebElement element) {
        Select select = new Select(element);
        return select.getOptions().stream().map(el -> el.getText().trim()).collect(Collectors.toList());
    }


    public void scrollToElement(WebElement element) {
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", element);
    }


    public void clearAndSendKeys(WebElement element, String keys) {
        element.clear();
        element.sendKeys(keys);
        waitForSpinner();
    }


    public Base selectCustomRadioButton(String title) {
        WebElement element = findLastElementThroughParent(customRadioButtons, title, "Radio button element not found: " + title);
        scrollAndExpose(element);
        element.click();
        return this;
    }

    public Base clickButtonInWebElementContainingText(WebElement parentElement, String buttonText) {
        try {
            String xpath = String.format("//button[contains(text(), '%s')]", buttonText);
            parentElement.findElement(new By.ByXPath(xpath)).click();
        } catch (NoSuchElementException noSuchElementException) {
            testLogger.log(Level.WARNING, String.format("Button containing text \"%s\" not found in parent element.",
                    buttonText), noSuchElementException);
        } catch (ElementNotInteractableException elementNotInteractableException) {
            testLogger.log(Level.WARNING, String.format("Button containing text \"%s\" can't be clicked.",
                    buttonText), elementNotInteractableException);
        }
        return this;
    }


//    public utils.Base clickTextElement(String text) {
//        WebElement link = Driver.getElementByText(clickableText, text);
//        retryingClick(link);
//        return this;
//    }


    public Base waitAndClick(WebElement button) {
        waitUntilElementPresent(button, 5);
        retryingClick(button);
        return this;
    }


//    public boolean isButtonDisplayed(String buttonName) {
//        try {
//            WebElement button = Driver.getElementByText(buttons, buttonName);
//            button.isDisplayed();
//        } catch (NoSuchElementException e) {
//            return false;
//        }
//        return isButtonDisplayed(buttonName);
//    }


//    public utils.Base switchTab(String tab) {
//        WebElement t = Driver.getElementByText(tabs, tab);
//        scrollAndExpose(t);
//        t.click();
//        return this;
//    }
//
//
//    public boolean isButtonEnabled(String buttonName) {
//        WebElement button = Driver.getElementByText(buttons, buttonName);
//        return button.isEnabled();
//    }
//
//
//    public boolean isButtonDisabled(String buttonName) {
//        WebElement button = Driver.getElementByText(disabledButtons, buttonName);
//        return button.getText().contains(buttonName);
//    }


    public boolean isDisabled(WebElement element) {
        Boolean result = false;
        try {
            String value = element.getAttribute("disabled");
            if (value != null) {
                result = true;
            }
        } catch (Exception e) {
        }

        return result;
    }


    public boolean isItemPresent(List<WebElement> entries, String text) {
        long count = entries.stream()
                .filter(e -> e.getAttribute("innerHTML").contains(text))
                .count();
        return count > 0;
    }


    public void findAndclickItem(List<WebElement> entries, String text) {
        WebElement ele = entries.stream()
                .filter(e -> e.getText().equals(text))
                .findFirst()
                .orElseThrow(() -> new AssertionError("item with text: " + text + " not found"));
        ele.click();
    }


//    public boolean isCheckboxEnabled(String name) {
//        WebElement element = findElementThroughParent(customCheckboxes, name, "Checkbox not found: " + name);
//        return element.isEnabled();
//    }


    public WebElement findElementThroughParent(List<WebElement> elems, String searchText, String message) {
        try {
            WebElement el = elems.stream()
                    .filter(elem -> {
                        WebElement parent = elem.findElement(By.xpath(".."));
                        return parent.isDisplayed() && parent.getText().split("\n")[0].contains(searchText);
                    })
                    .findFirst()
                    .orElseThrow(() -> new AssertionError(message));
            return el;
        } catch (StaleElementReferenceException e) {
            return findElementThroughParent(elems, searchText, message);
        }
    }


    public WebElement findLastElementThroughParent(List<WebElement> elems, String searchText, String message) {
        return elems.stream()
                .filter(chkbox -> {
                    WebElement parent = chkbox.findElement(By.xpath(".."));
                    return parent.isDisplayed() && parent.getText().split("\n")[0].contains(searchText);
                }).reduce((first, second) -> second)
                .orElseThrow(() -> new AssertionError(message));
    }


    public void selectCheckbox(List<String> checkboxes) {
        checkboxes.forEach(checkbox -> {
            WebElement checkboxElement = driver.findElement(By.xpath("//label[contains(text(),'" + checkbox + "')]/parent::div/input"));
            checkboxElement.click();
        });
    }

    public static void takeScreenshot() {
        TakesScreenshot takesScreenshot = (TakesScreenshot) DriverFactory.getDriver();
        File screenshot = takesScreenshot.getScreenshotAs(OutputType.FILE);
        try {
            FileUtils.copyFile(screenshot, new File("target/screenshot.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public WebElement findLastCheckbox(List<WebElement> elems, String searchText) {
        return elems.stream()
                .filter(chkbox -> {
                    WebElement parent = chkbox.findElement(By.xpath(".."));
                    return parent.getText().split("\n")[0].contains(searchText);
                })
                .reduce((first, second) -> second)
                .orElseThrow(() -> new AssertionError("Checkbox not found"));
    }


    public void scrollToView(WebElement element) {
        Actions actions = new Actions(driver);
        actions.moveToElement(element).perform();
    }


    public void hoverClick(WebElement element, WebElement subElement) {
        Actions actions = new Actions(driver);
        actions.moveToElement(element).moveToElement(subElement).click().build().perform();
    }

    public void doubleClick(WebElement element) {
        Actions actions = new Actions(driver);
        actions.doubleClick(element).perform();
    }

    public void hover(WebElement element) {
        Actions actions = new Actions(driver);
        actions.moveToElement(element).perform();
    }

    public void ellipsisMenuSelect(WebElement element, WebElement subElement) {
        Actions actions = new Actions(driver);
        actions.moveToElement(element).click().moveToElement(subElement).click().perform();
    }


//    public void navTab(String tab) {
//        WebElement tabElement = tabs.stream().filter(el -> el.getText().trim().equals(tab))
//                .findFirst()
//                .orElseThrow(() -> new AssertionError("Web element not found for not containing text: " + tab));
//        scrollAndExpose(tabElement);
//        tabElement.click();
//        try {
//            Thread.sleep(3000);
//        } catch (InterruptedException interruptedException) {
//            testLogger.log(Level.WARNING, interruptedException.getMessage(), interruptedException);
//        }
//    }


    public static boolean isRowPopulated(List<WebElement> rows) {
        return rows.size() > 0;
    }


    public boolean areExactTextInOrder(List<String> texts, List<WebElement> elements) {
        Integer currentOptionIndex = 0;
        Integer currentShownIndex = 0;
        while (currentOptionIndex < texts.size() && currentShownIndex < elements.size()) {
            String currentShownText = elements.get(currentShownIndex).getText();
            if (currentShownText.equals(texts.get(currentOptionIndex))) {
                currentOptionIndex++;
            }
            currentShownIndex++;
        }
        return currentOptionIndex == texts.size();
    }


    public boolean areTextInOrder(List<String> texts, List<WebElement> elements) {
        Integer currentOptionIndex = 0;
        Integer currentShownIndex = 0;
        while (currentOptionIndex < texts.size() && currentShownIndex < elements.size()) {
            String currentShownText = elements.get(currentShownIndex).getText();
            if (currentShownText.contains(texts.get(currentOptionIndex))) {
                currentOptionIndex++;
            }
            currentShownIndex++;
        }
        return currentOptionIndex == texts.size();
    }


    public void scrollAndExpose(WebElement el) {
        scrollToElement(el);
        //To avoid bottom menu bar
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("window.scrollBy(0,-100)");
    }


    public void scrollAndExposeAndClick(WebElement el) {
        scrollAndExpose(el);
        waitUntilElementIsClickable(el, 5);
        el.click();
    }


    public void hoverAndClick(WebElement targetElement) throws NoSuchElementException {
        try {
            new Actions(driver).moveToElement(targetElement).click().build().perform();
        } catch (NoSuchElementException noSuchElementException) {
            testLogger.warning("NoSuchElementException thrown while attempting a hover and click.");
            throw noSuchElementException;
        }
    }


//    public boolean isTimestamp(String text) {
//        DateTimeFormatter f = DateTimeFormat.forPattern("M/d/yy hh:mma");
//        DateTime timestamp = f.parseDateTime(text);
//        return timestamp.getSecondOfDay() > 0;
//    }


    public List<Integer> getSubstringIndexes(String text, List<String> variables) {
        List<Integer> indexes = new ArrayList<Integer>();


        variables.forEach(variable -> {
            indexes.add(text.indexOf(variable));
        });
        return indexes;
    }


    public boolean areIndexesInOrder(List<Integer> indexes) {
        for (Integer i = 0; i < indexes.size() - 1; i++) {
            if (indexes.get(i) > indexes.get(i + 1)) {
                return false;
            }
        }
        return true;
    }


    public boolean isAlertPresent() {
        boolean foundAlert = false;
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(5) /*timeout in seconds*/);
        try {
            wait.until(ExpectedConditions.alertIsPresent());
            foundAlert = true;
        } catch (TimeoutException eTO) {
            foundAlert = false;
        }
        return foundAlert;
    }


    public List<String> getElementValues(List<WebElement> elements) {
        List<String> values = new ArrayList<>();
        elements.forEach(e -> values.add(e.getAttribute("value")));
        return values;
    }


    public WebElement findParent(WebElement element) {
        return element.findElement(By.xpath(".."));
    }


//    public InputStream getLastDownloadedFile() throws FileNotFoundException {
//        String currentUrl = driver.getCurrentUrl();
//        if ((currentUrl.contains("/result")) || (currentUrl.contains("/rwrs"))) {
//            String[] paths = currentUrl.split("/");
//            UnzipUtility.jobId = paths[7];
//        }


//        File lastFile = FileUtility.getLastModified(Driver.downloadDir);
//        if (lastFile == null) {
//            Assert.fail("No file downloaded");
//        }
//
//
//        return new FileInputStream(lastFile);
//    }


//    public boolean hasFileBeenDownloaded(String filePath) {
//        Path path = Path.of(filePath);
//        return !FileUtility.isDirectoryEmpty(path.toFile());
//    }


//    public boolean waitForFileToDownload(String extension) {
//        return waitForFileToDownload(Driver.getDownloadDirectory(), extension);
//    }


    public boolean waitForFileToDownload(String directory, String fileName) {
        String fullyQualifiedPath = (directory.endsWith("/") ? directory
                : directory.concat("/")).concat(fileName);
        File downloadedFile = new File(fullyQualifiedPath);
        FluentWait<WebDriver> wait = new FluentWait<>(driver)
                .pollingEvery(Duration.ofSeconds(5))
                .withTimeout(Duration.ofSeconds(60))
                .ignoring(FileNotFoundException.class);
        try {
            wait.until(WebDriver -> downloadedFile.exists());
            return true;
        } catch (TimeoutException ignored) {
        }
        return false;
    }


    public boolean retryingClick(WebElement element) {
        boolean success = false;
        int attempts = 0;
        while (attempts < 5) {
            try {
                element.click();
                success = true;
                break;
            } catch (StaleElementReferenceException e) {
                e.printStackTrace();
            }
            attempts++;
        }
        return success;
    }

    public void highLightedClick(WebElement element) {
        js.executeScript("arguments[0].setAttribute('style', 'background: red; border: 2px solid red;');", element);
        js.executeScript("arguments[0].click();", element);
    }


    public void click(WebElement element) {
        js.executeScript("arguments[0].click();", element);
    }


//    public void testLinkStatus() {
//        Iterator<WebElement> it = links.iterator();
//        while (it.hasNext()) {
//            String urls = it.next().getAttribute("href");
//            if (!(urls == null || urls.isEmpty())) {
//                try {
//                    URL url = new URL(urls);
//                    HttpURLConnection httpURLConnect = (HttpURLConnection) url.openConnection();
//                    httpURLConnect.setConnectTimeout(3000);
//                    httpURLConnect.connect();
//                    if (httpURLConnect.getResponseCode() == 200) {
//                        System.out.println(urls + " - " + httpURLConnect.getResponseMessage());
//                    }
//                    if (httpURLConnect.getResponseCode() >= 400) {
//                        System.out.println(urls + " is a broken link");
//                    }
//                    if (httpURLConnect.getResponseCode() == HttpURLConnection.HTTP_NOT_FOUND) {
//                        System.out.println(urls + " - " + httpURLConnect.getResponseMessage() + " - " + HttpURLConnection.HTTP_NOT_FOUND);
//                    }
//                    httpURLConnect.disconnect();
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }


    //This should for any html table without creating type registry or a separate class
//    public void verifyHtmlDataTable(DataTable dataTable) {
//        WebElement htmlTableElements = driver.findElement(By.xpath("//table"));
//        List<WebElement> rowElements = htmlTableElements.findElements(By.xpath(".//tr"));
//
//
//        List<List<String>> dataTableRows = dataTable.asLists();
//        for (List<String> row : dataTableRows) {
//            int rows = dataTableRows.indexOf(row);
//            WebElement rowElem = rowElements.get(rows);
//            List<WebElement> cellElements = rowElem.findElements(By.xpath(".//td"));
//
//
//            for (String expected : row) {
//                int cellIdx = row.indexOf(expected);
//                String actual = cellElements.get(cellIdx).getText();
//
//
//                Assert.assertEquals(expected, actual, "Expected value of cell should match actual value of cell");
//            }
//        }
//    }


    public void handlePendoNotification() {
        try {
            if (driver.findElement(By.cssSelector("#pendo-guide-container")).isDisplayed()) {
                driver.findElement(By.xpath("//*[@class='_pendo-close-guide']")).click();
            }
        } catch (WebDriverException ignored) {
            // Disabling Pendo container exception logging for when it isn't present.
        } catch (Exception unexpected) {
            testLogger.log(Level.WARNING, "Unexpected Exception encountered while closing pendo.", unexpected);
        }
    }


    /**
     * Provided any By locator, searches the entire current page for it. Returns true if it cannot be found,
     * false otherwise.
     *
     * @param locator {@link By} Any By selector
     * @return {@link boolean} True if it is found, false otherwise.
     */
    public boolean isElementPresent(By locator) {
        try {
            driver.findElement(locator);
            return true;
        } catch (NoSuchElementException ignored) {
            return false;
        }
    }


    public boolean isElementPresent(WebElement parentElement, By locator) {
        try {
            parentElement.findElement(locator);
            return true;
        } catch (NoSuchElementException ignored) {
            return false;
        }
    }

    public boolean isElementPresent(WebElement element) {
        try {
            element.isDisplayed();
            return true;
        } catch (NoSuchElementException ignored) {
            return false;
        }
    }

//    public boolean isEntityInList(String entityName) {
//        long count = entityRows.stream()
//                .filter(el -> el.getText().trim().contains(entityName))
//                .count();
//
//
//        return count > 0;
//    }


//    public boolean goBackAFolder() {
//        if (this.folderHierarchyList.size() >= 2) {
//            WebElement destinationFolder = this.folderHierarchyList.get(this.folderHierarchyList.size() - 2);
//            if (destinationFolder.isEnabled()) {
//                destinationFolder.click();
//                this.waitForSpinner();
//                return true;
//            }
//        }
//        return false;
//    }


//    public boolean isUserInTopFolder() {
//        return this.folderHierarchyList.size() <= 1;
//    }


    /**
     * Refreshes the page.
     */
    public void refreshPage() {
        driver.navigate().refresh();
    }

//    public List<String> getCurrentActivePageFromSidebar() {
//        if (this.isElementPresent(byToNavigationSidebar)) {
//            return projectNavigationSidebar.findElements(byToActiveSidebarElement)
//                    .stream()
//                    .map(activeSidebarListElement -> activeSidebarListElement.getAttribute("innerText"))
//                    .collect(Collectors.toList());
//        }
//        return Collections.emptyList();
//    }


//    public void search(String entity) {
//        waitForSpinner();
//        searchTextBox.clear();
//        searchTextBox.sendKeys(entity + Keys.RETURN);
//        waitForSpinner();
//    }
//
//
//    public void testAccessibility() {
//        JSONObject responseJSON = new AXE.Builder(driver, scriptUrl).analyze();
//        JSONArray violations = responseJSON.getJSONArray("violations");


//        if (violations.length() == 0) {
//            Assert.assertTrue(true, "No violations found");
//        } else {
//            AXE.writeResults(scenario.getName(), responseJSON);
//            Assert.fail(AXE.report(violations));
//        }
//    }


//    public void testAccessibilityWithSkipFrames() {
//        JSONObject responseJSON = new AXE.Builder(driver, scriptUrl)
//                .skipFrames()
//                .analyze();
//
//
//        JSONArray violations = responseJSON.getJSONArray("violations");
//
//
//        if (violations.length() == 0) {
//            Assert.assertTrue(true, "No violations found");
//        } else {
//            AXE.writeResults(scenario.getName(), responseJSON);
//            Assert.fail(AXE.report(violations));
//        }
//    }


//    public void testAccessibilityforTags(String tag) {
//        JSONObject responseJSON = new AXE.Builder(driver, scriptUrl)
//                .analyze(driver.findElement(By.tagName(tag)));
//
//
//        JSONArray violations = responseJSON.getJSONArray("violations");
//
//
//        if (violations.length() == 0) {
//            Assert.assertTrue(true, "No violations found");
//        } else {
//            AXE.writeResults(scenario.getName(), responseJSON);
//            Assert.fail(AXE.report(violations));
//        }
//    }


//    public void testAccessibilitywithWithout(String include, String exclude) {
//        JSONObject responseJSON = new AXE.Builder(driver, scriptUrl)
//                .include(include)
//                .exclude(exclude)
//                .analyze();
//
//
//        JSONArray violations = responseJSON.getJSONArray("violations");
//
//
//        if (violations.length() == 0) {
//            Assert.assertTrue(true, "No violations found");
//        } else {
//            AXE.writeResults(scenario.getName(), responseJSON);
//            Assert.fail(AXE.report(violations));
//        }
//    }

    public String getDateInFormat(String format, int addDays) {
        return new SimpleDateFormat(format).format(new Date(new Date().getTime() + (addDays * 1000 * 60 * 60 * 24)));
    }

    public void clickButton(String text) {
        List<WebElement> matches = driver.findElements(By.xpath("//button[contains(text(),'" + text + "')]"));
        try {
            WebElement button = matches.stream()
                    .filter(WebElement::isEnabled)
                    .findFirst()
                    .orElseThrow(() -> new AssertionError("Button with text: " + text + " not found"));
            button.click();
        } catch (ElementNotInteractableException e) {
            matches.get(1).click();
        }
    }

    public void moveToWindowTab(String tabName) {
        Set<String> tabs = driver.getWindowHandles();
        for (String tab : tabs) {
            driver.switchTo().window(tab);
            if (driver.getTitle().equalsIgnoreCase(tabName))
                break;
        }
    }

    @Override
    protected void load() {
    }

    @Override
    protected void isLoaded() throws Error {
    }

    public void uploadFile(String filePath, By fileInputLocator) {
        WebElement fileInput = driver.findElement(fileInputLocator);
        String fileFullPath=  System.getProperty("user.dir") + File.separator+"src" +  File.separator+"test" +File.separator+"resources" + File.separator + filePath;
        fileInput.sendKeys(fileFullPath);
    }
}




