Feature: Core Test - Elections Regression Tests

  @tv_regression_001 @Election @CoreIND
  Scenario: Creating an Election and Adding a Contest and Candidate to the Election created in State
    Given User navigate to "Core_Test" log in page
    And User log in as "core_state" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Statewide | dropdown |
      | Election Type: | GENERAL   | dropdown |
    And User enters Description "State timestamp" for Election
    And User set a valid election date
    And User save the selection
    And the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                                   | Type     |
      | District Type          | STATEWIDE                              | dropdown |
      | Office                 | SW - Insurance Commissioner - 1/1/2024 | dropdown |
      | Ballot Title           | SW - Attorney General                  | input    |
      | Term Type              | Regular                                | dropdown |
      | Biography Word Limit   | 100                                    | input    |
      | Filing Fee Cost        | 1377.00                                | input    |
      | Additional Requirement | Automation Test 1                      | input    |
      | Notes                  | Automation Test 2                      | input    |
      | Term Length            | 4                                      | input    |
      | Statement Word Limit   | 200                                    | input    |
    And User set a valid Filing Start and Filing End
    And User click on "Add"
    And the new race should be added to the election successfully
    And User click the plus button to add candidate
    And User click the "Add Candidate" button
    And User gets the current count of candidates
    And User expands Candidate Details Tab
    And User fills in the required information fields for creating a new candidate
      | Field          | Text                                   | Type     |
      | Ballot Order   | 01                                     | input    |
      | Ballot Name    | SW - Insurance Commissioner - 1/1/2024 | input    |
      | Party          | Green                                  | dropdown |
      | Candidate Type | State Filed                            | dropdown |
      | First Name     | Larry                                  | input    |
      | Last Name      | Bird                                   | input    |
    When User click the " Save" button
    Then User verify new candidate was added to the race successfully


  @tv_regression_002 @CoreRegression @Election @CoreIND
  Scenario: Creating an Election and Adding a Contest and Candidate to the Election created in County
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
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                                            | Type     |
      | District Type          | COUNTYWIDE                                      | dropdown |
      | District               | Apache                                          | dropdown |
      | Office                 | CTY - County Commissioner District 1 - 1/1/2024 | dropdown |
      | Term Type              | Regular                                         | dropdown |
      | Filing Start           | 09/01/2023                                      | input    |
      | Filing End             | 9/30/2023                                       | input    |
      | Biography Word Limit   | 100                                             | input    |
      | Filing Fee Cost        | 1377.00                                         | input    |
      | Additional Requirement | Automation Test 1                               | input    |
      | Notes                  | Automation Test 2                               | input    |
      | Term Length            | 4                                               | input    |
      | Statement Word Limit   | 200                                             | input    |
      | Ballot Title           | CTY - County Commissioner District 2 Automation | input    |
      | Vote For               | 1                                               | input    |
    And User click on "Add"
    And the new race should be added to the election successfully
    And User click the plus button to add candidate
    And User click the "Add Candidate" button
    And User gets the current count of candidates
    And User expands Candidate Details Tab
    And User fills in the required information fields for creating a new candidate
      | Field          | Text                     | Type     |
      | Ballot Order   | 01                       | input    |
      | Ballot Name    | SW - Attorney General 02 | input    |
      | Party          | Green                    | dropdown |
      | Candidate Type | State Filed              | dropdown |
      | First Name     | Larry                    | input    |
      | Last Name      | Bird                     | input    |
    When User click the " Save" button
    Then User verify new candidate was added to the race successfully

