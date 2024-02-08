Feature: Core Test - Miscellaneous Regression Tests

  @tv_regression_035 @CoreRegression @CoreIND @Other
  Scenario: Verify Possible Duplicate Registrants - Out of County, count matches count listed in the Task Queue
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User click on "Possible Duplicate Registrants - Out of County Matches" report and get count
    And User select "Possible Duplicate Registrants" from "Voter Registration"
    When User click on "Out of County Matches"
    Then User verify report counts matches Task Queue


  @tv_regression_041 @CoreRegression @Other
  Scenario: Verify data is displaying properly when navigating between pages and last page in the task queue
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User click on "Possible Duplicate Registrants - In County Matches"
    And I click on "2" page in pagination
    And User verifies all data is displaying properly in the table
    When I click on "Last" page in pagination
    Then User verifies all data is displaying properly in the table

  @tv_regression_042 @CoreRegression @Other
  Scenario: Validate required fields such as SSN, DL and others and make sure all checks passed
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User click on "Add New"
    And User click on "Run All Checks" button
    And I validate following error message on the page
      | Required Fields              | displayed |
      | DL/ID # is required.         | true      |
      | Last 4 from SSN is required. | true      |
    And User fill in the required information fields
      | Field   | Text     |
      | DL/ID # | 24558746 |
      | SSN4    | 6547     |
    When User click on "Run All Checks" button
    Then I validate following error message on the page
      | Required Fields              | displayed |
      | DL/ID # is required.         | false     |
      | Last 4 from SSN is required. | false     |

  @tv_regression_044 @Other
  Scenario: Add Registrant pre-fill in lower case
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text                |
      | Last Name  | random (lower case) |
      | First Name | random (lower case) |
      | SSN4       | random              |
      | DOB        | 05/01/2000          |
      | DL/ID #    | random              |
    And User click on "Search"
    When User click on "Add New Voter"
    Then User verifies Last Name and First Name updated to Capital letters

  @tv_regression_045 @Other
  Scenario: Adding a Office in Office/Incumbent Management (Minimum Info)
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Office/Incumbent Management" from "Election Management"
    When User click on "Add Office" button
    And User select "CITY" from "Base District Type"
    And User select "CITY DIST 61" from "Base District"
    And User select following checkboxes
      | Is Active |
    And User enters office name as "0_Random"
    And User fill in the required information fields
      | Field    | Text |
      | Term     | 4    |
      | Vote For | 6    |
    When User click on "Add" button
    Then User verify office has been added.