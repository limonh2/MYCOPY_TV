Feature: Core Test - Notice Regression Tests

  @tv_regression_017 @CoreRegression @Notice
  Scenario: Verify unsent Mail Notice display in Notices Queue
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User enter "DAVID, PETE" into Quick Search field
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "QA Automation 1" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    And User verify "QA AUTOMATION 1" was created successfully
    And User navigate to home page
    When User click on Notices Queue
    And User waits 5 seconds for background requests to load
    Then User verifies in template "QA Automation 1" the notice displayed in the queue

  @tv_regression_029 @CoreRegression @Notice
  Scenario: Create a notice from the Notice Management page
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User click on "County Utilities"
    And User click on "Notice Management"
    And User fills in the required information fields for creating a Notice
      | Field           | Text          | Type     |
      | Name:           | Notice random | input    |
      | Description:    | Test 123      | input    |
      | Can Be Emailed: | Yes           | dropdown |
    And User click on Save button in Notice Management
    And User enter "James, Lebron M" into Quick Search field
    And User click the "Correspondence" button
    When User click the "Create Email Correspondence" button
    Then User verifies dropdown Notice Name has newly created value