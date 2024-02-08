Feature: Core Test - Ballots Regression Tests

  @tv_regression_004 @CoreRegression @OBP @CoreIND @Ballots
  Scenario: Verify OutBound Ballot Processing Avery_Dymo Labels user preferences are saved
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User navigates to User Preferences for OutBound Ballot Processing page
    And User selects Preferences for Outbound Ballot Processing Avery_Dymo Labels
      | Field         | Text         |
      | Option One:   | Party        |
      | Option Two:   | Precinct     |
      | Option Three: | Ballot Style |
    And User clicks on Save button for User Preferences
    When User navigate to home page
    And User navigates to User Preferences for OutBound Ballot Processing page
    Then User verifies Preferences was saved for Outbound Ballot Processing Avery_Dymo Labels

  @tv_regression_008 @CoreRegression @Ballots @CoreIND
  Scenario: Create Ballot Question and Create ballot styles in county
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Apache    | dropdown |
      | Election Type: | MUNICIPAL | dropdown |
    And User enters Description "County timestamp" for Election
    And User set a valid election date
    And User click the Save button on the Add new Election Page
    And the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    And User click on County Ballot Question link
    And User click the "COUNTY BALLOT QUESTION" button
    And User select "CITY" from "District Type" native dropdown
    And User select "CITY DIST 16" from "District Name" native dropdown
    And User select "Local" from "Ballot Question Type" native dropdown
    And User fill in the required information fields
      | Field                 | Text       |
      | Office Sequence No.   | 11         |
      | Date Received         | -1         |
      | Date Filed            | 0          |
      | Ballot Question Title | TEST       |
      | Ballot Question Text  | Testing #1 |
      | Explanatory Statement | Testing #2 |
    And User click the "Save" button
    And User click on "Ballot Styles"
    When User click the "Create Ballot Styles" button
    Then User verify ballot styles were created successfully

  @tv_regression_028 @Ballots
  Scenario: UOCAVA ballots - load
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "Load Ballots" election
    And User select "Outbound Ballot Processing" from "Election Management"
    And User click on "Load"
    And User click on "OK"
    And User click on "OK"
    And User waits 10 seconds for background requests to load
    And User navigate to home page
    And User click on "Job Queue"
    And User click on "Load Ballots"
    When User click on "View"
    Then User verify the "Ballots to be sent via MAIL" is displaying
    And User verify the "Ballots to be sent via EMAIL" is displaying

  @tv_regression_030 @CoreRegression @Candidate @Ballots
  Scenario: Scanning Candidate Forms in Ballot Setup
#  Prerequisites: Election, Contest, Candidate
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "Scan Candidate Forms 1" election
    And User select "Ballot Set Up" from "Election Management"
    And User click the plus button to add candidate
    And User waits 5 seconds for background requests to load
    And User click the Scan button in Ballot Setup
    And User switch to new window
    And User fills in the required information fields for creating election related functions
      | Field     | Text                  | Type     |
      | Form Type | Candidate Declaration | dropdown |
    And User click the "Scan Image" button
    And User click the "Process" button
    And User click on "OK"
    And User click on "Ok"
    And User switch to Home window
    And User click the View button in Ballot Setup
    Then User verify a form got scanned successfully

  @tv_regression_031 @CoreRegression @Ballots @CoreIND
  Scenario:Verify Ballot Question Title is displaying correcting
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Apache    | dropdown |
      | Election Type: | MUNICIPAL | dropdown |
    And User enters Description "County timestamp" for Election
    And User set a valid election date
    And User click the Save button on the Add new Election Page
    And the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    And User click on County Ballot Question link
    And User deletes any existing Ballot Questions
    And User click the "COUNTY BALLOT QUESTION" button
    And User select "CITY" from "District Type" native dropdown
    And User select "CITY DIST 16" from "District Name" native dropdown
    And User select "Local" from "Ballot Question Type" native dropdown
    And User fill in the required information fields
      | Field                 | Text                  |
      | Office Sequence No.   | 11                    |
      | Date Received         | -1                    |
      | Date Filed            | 0                     |
      | Ballot Question Title | Test Title 123        |
      | Ballot Question Text  | Automation Testing #1 |
      | Explanatory Statement | Automation Testing #2 |
    When User click the Save button on the Countywide Ballot Page
    Then User verify Ballot Question Title "Test Title 123" matches

  @tv_regression_032 @CoreRegression @Ballots
  Scenario: Verify Ballot Question is displaying District Type and District Name correctly
    Given User navigate to "Core_Test" log in page
    And User log in as "core_state" user
    And User select "Elections" from "Election Management"
    And User select "District Type check" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on Statewide Ballot Question link
    And User click the ADD NEW STATEWIDE BALLOT QUESTION link
    And User select "CONGRESSIONAL" from "District Type" native dropdown
    And User select "CONGRESSIONAL DISTRICT 1" from "District Name" native dropdown
    And User select "Initiative to the People" from "Ballot Question Type" native dropdown
    And User fill in the required information fields
      | Field                 | Text       |
      | Office Sequence No.   | 11         |
      | Date Received         | -1         |
      | Date Filed            | 0          |
      | Ballot Question Title | TEST       |
      | Ballot Question Text  | Testing #1 |
      | Explanatory Statement | Testing #2 |
    When User click the Save button on the Statewide Ballot Page
    Then verify District Name "CONGRESSIONAL DISTRICT 1" is displaying correctly
    And verify District Type "CGX" is displaying correctly