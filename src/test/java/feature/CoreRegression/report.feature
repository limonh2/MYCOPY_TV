Feature: Core Test - Reports Regression Tests

  @tv_regression_007 @CoreRegression @Election
  Scenario Outline: Create and Run Reports from Report Builder in State
    Given User navigate to "Core_Test" log in page
    And User log in as "core_state" user
    And User select "Reports" from "Reports" menu
    And User click on "Report Builder Reports"
    And User click on "Create Report"
    And User select the checkbox "<ReportName>" from Reports
    And User click on "Next"
    And User waits 10 seconds for background requests to load
    And User click on "Next"
    And User enters "Report randomtext" into Report Name field
    And User enters "Desc randomtext" into Report Description field
    And User click on "Done"
    And User click on "OK"
    And User verify Report Name and click on Run button
    And User click on "OK"
    And User navigate to home page
    And User click on job queue
    And User clicks on report builder link
    And User verifies the report name displayed on report builder with status finished
    When I download the report
    Then I validate the file was downloaded
    Examples:
      | ReportName                   |
      | Candidate Proofing           |
      | Ballot Proofing              |
      | County Precincts With Splits |

  @tv_regression_022 @CoreRegression @Report @CoreIND
  Scenario Outline: Run a Report
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Reports" from "Reports" menu
    Then User verify the "<ReportType>" report was generated
    Examples:
      | ReportType           |
      | Cost Tracking        |
      | Contests in Election |

  @tv_regression_023 @CoreRegression @Report @CoreIND
  Scenario: Checking for duplicate Election Abbreviation
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text      | Type     |
      | Election Type:         | MUNICIPAL | dropdown |
      | Election Abbreviation: | 23        | input    |
    And User enters Description "County timestamp" for Election
    And User set a valid election date
    And User save the selection
    Then the "Election Abbreviation already exists" message should be populated successfully

  @tv_regression_024 @CoreRegression @Report @CoreIND
  Scenario Outline: Create and Run Reports from Report Builder in County
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Reports" from "Reports" menu
    And User click on "Report Builder Reports"
    And User click on "Create Report"
    And User select the checkbox "<ReportName>" from Reports
    And User click on "Next"
    And User waits 10 seconds for background requests to load
    And User click on "Next"
    And User enters "Report randomtext" into Report Name field
    And User enters "Desc randomtext" into Report Description field
    And User click on "Done"
    And User click on "OK"
    And User verify Report Name and click on Run button
    And User click on "OK"
    And User navigate to home page
    And User click on job queue
    And User clicks on report builder link
    And User verifies the report name displayed on report builder with status finished
    Examples:
      | ReportName                   |
      | Candidate Proofing           |
      | Ballot Proofing              |
      | County Precincts With Splits |

