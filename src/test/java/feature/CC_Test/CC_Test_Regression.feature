Feature: CC Test Tests


 @tv_regression_001 @CC_Test_Regression@Election @CC_Test_RegressionIND
  Scenario: Scenario: Creating an Election and Adding a Contest and Candidate to the Election created in State
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_state" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field          | Text    | Type     |
      | Election Type: | GENERAL | dropdown |
    And User set a valid election date
    And User generate and use election abbreviation
    And User set following date for early voting
      | Field                         | days prior election |
      | Early Voting by Mail open     | 15                  |
      | Early Voting in Person open   | 15                  |
      | Early Voting in Person closed | 15                  |
    And User enters Description "State timestamp" for Election
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    And User gets the current count of contests
    And User gets the current count of candidates
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                                   | Type     |
      | District Type          | Statewide                              | dropdown |
      | Office                 | SW - Attorney General - 1/1/2026       | dropdown |
      | Term Type              | Regular                                | dropdown |
      | Biography Word Limit   | 100                                    | input    |
      | Filing Fee Cost        | 1377.00                                | input    |
      | Additional Requirement | Automation Test 1                      | input    |
      | Notes                  | Automation Test 2                      | input    |
      | Term Length            | 4                                      | input    |
      | Statement Word Limit   | 200                                    | input    |
    And User set a valid Filing Start and Filing End
    When User click on "Add"
    And User verify new contest was added to the election successfully
    Then the new race should be added to the election successfully
    And User click the plus button to add candidate
    And User click the "Add Candidate" button
    And User gets the current count of candidates
    And User expands Candidate, Campaign and Office Details Tab
    And User fills in the required information fields for creating a new candidate
      | Field          | Text                                     | Type     |
      | Ballot Order     | 01                                     | input    |
      | Ballot Name      | SW - Insurance Commissioner - 1/1/2024 | input    |
      | Party            | Democratic                             | dropdown |
      | Candidate Type   | State Filed                            | dropdown |
      | First Name       | Larry                                  | input    |
      | Last Name        | Bird                                   | input    |
      | Address          | 566 Fox Links st                       | input    |
      | City             | Las Vegas                              | input    |
      | Zip              | 89012                                  | input    |
      | County           | CLARK                                  | dropdown |
      | Municipality     | 19                                     | input    |
      | Candidate Status | Approved                               | dropdown |
      | Receipt Number   | 7882938374747                          | input    |
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully

 @tv_regression_002 @CC_Test_Regression@Election @CC_Test_RegressionIND
  Scenario: Scenario: Creating an Election and Adding a Contest and Candidate to the Election created in County
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Election Type: | SPECIAL   | dropdown |
    And User set a valid election date
    And User generate and use election abbreviation
    And User set following date for early voting
      | Field                         | days prior election |
      | Early Voting by Mail open     | 15                  |
      | Early Voting in Person open   | 15                  |
      | Early Voting in Person closed | 15                  |
    And User enters Description "County timestamp" for Election
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    And User gets the current count of contests
    And User gets the current count of candidates
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                                    | Type     |
      | District Type          | County                                          | dropdown |
      | District               | CLARK                                           | dropdown |
      | Office                 | CTY - Clark County Sheriff - 1/1/2026           | dropdown |
      | Term Type              | Regular                                         | dropdown |
      | Filing Start           | 09/01/2023                                      | input    |
      | Filing End             | 9/30/2023                                       | input    |
      | Biography Word Limit   | 100                                             | input    |
      | Filing Fee Cost        | 1377.00                                         | input    |
      | Additional Requirement | Automation Test 1                               | input    |
      | Notes                  | Automation Test 2                               | input    |
      | Statement Word Limit   | 200                                             | input    |
    And User click on "Add"
    And User verify new contest was added to the election successfully
    Then the new race should be added to the election successfully
    And User click the plus button to add candidate
    And User click the "Add Candidate" button
    And User gets the current count of candidates
    And User expands Candidate, Campaign and Office Details Tab
    And User fills in the required information fields for creating a new candidate
      | Field          | Text                     | Type     |
      | Ballot Order     | 01                                     | input    |
      | Ballot Name      | CC - Insurance Commissioner - 1/1/2024 | input    |
      | Party            | Democratic                             | dropdown |
      | Candidate Type   | State Filed                            | dropdown |
      | First Name       | Larry                                  | input    |
      | Last Name        | Birdy                                  | input    |
      | Address          | 566 Fox Links st                       | input    |
      | City             | Las Vegas                              | input    |
      | Zip              | 89012                                  | input    |
      | County           | CLARK                                  | dropdown |
      | Municipality     | 19                                     | input    |
      | Candidate Status | Approved                               | dropdown |
      | Receipt Number   | 78829383747                            | input    |
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully

 @tv_regression_007@CC_Test_Regression@Election@CC_Test_RegressionIND
  Scenario Outline: Create and Run Reports from Report Builder in State
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_state" user
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


 @tv_regression_008@CC_Test_Regression@Ballots
  Scenario: Create Ballot Question and Create ballot styles in County
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Election Type: | GENERAL   | dropdown |
    And User set a valid election date
    And User generate and use election abbreviation
    And User set a valid date for Early Voting fields
    And User enters Description "County timestamp" for Election
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    And User click on County Ballot Question link
    And User click the "COUNTY BALLOT QUESTION" button
    And User select "County" from "District Type" native dropdown
    And User select "COUNTY" from "District Name" native dropdown
    And User select "County" from "Ballot Question Type" native dropdown
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
    And User click the "Create Ballot Styles" button
    And User verify ballot styles were created successfully

 @tv_regression_009@CC_Test_Regression@Voter
  Scenario: Adding a new registrant (Minimum information)
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Address        | 2222 MAIN ST  |
   And User click on "2222 MAIN ST BLUE DIAMOND 89129"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Democratic      |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully


 @tv_regression_010@CC_Test_Regression@Voter
  Scenario: Adding a new registrant (Maximum information)
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Middle Name    | Dennis        |
      | Place Of Birth | Eager         |
      | Address        | 2222 ASH AVE  |
   And User click on "2222 ASH AVE LAS VEGAS 89101"
    And User select following data from dropdown
      | Field                    | Text                                              |
      | Suffix                   | SR                                                |
      | Alternate ID             | Bank Statement                                    |
      | Political Party          | Republican                                        |
      | Communication Preference | Mail                                              |
      | Assistance Needed        | Physical                                          |
      | Accessible Ballot        | Large Print                                       |
      | NVRA Agency Type         | PAA - Women, Infants & Children Nutrition Clinics |
      | Suppression Level        | No Restrictions                                   |
      | Source of Registration   | Online                                            |
      | How Registered           | Electronic                                        |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully

 @tv_regression_011@CC_Test_Regression@Voter @Candidate
  Scenario: Add the voter as a candidate on a ballot
#  Prerequisites: created a new or existed Voter
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User select "Automation Ballots 03" election
    When User enter "CARNEY, DANNY H" into Quick Search field
    And User click on "Add to Contest"
    And User fills in the required information fields for creating election related functions
      | Field            | Text           | Type     |
      | Select a Contest | CTY - Assessor | dropdown |
    And User click on "Continue"
    And User switch to new window
    And User gets the current count of candidates
    And User fills in the required information fields for creating a new candidate
      | Field          | Text                     | Type     |
      | Ballot Order   | 01                       | input    |
      | Ballot Name    | SW - Attorney General 02 | input    |
      | Party          | Green                    | dropdown |
      | Candidate Type | County Filed             | dropdown |
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully

 @tv_regression_012@CC_Test_Regression@Voter@CC_Test_RegressionIND
  Scenario: Update Mailing Address of a Voter
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 99 NANCY ST   |
   And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Democratic      |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    And User updates Mailing Address
    And User click on "Run All Checks"
    And User click the "OK" button
    And User click the "Update Registrant" button
    And User click on "Yes" button
    Then User verify Address fields were updated successfully in NV

 @tv_regression_013@CC_Test_Regression@Voter
  Scenario: Search for Voters
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Advanced Search" from "Reports"
    And User fill in the required information fields
      | Field       | Text   |
      | First Name  | John   |
      | Last Name   | Doe    |
    And User click the "Search" button
    Then User verify search results
      | Key       | Value |
      | FirstName | John  |
      | LastName  | Doe   |

 @tv_regression_014@CC_Test_Regression@Voter
  Scenario: Create Mail Correspondence
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 99 NANCY ST   |
   And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Democratic      |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "Vik Test" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    Then User verify "Vik Test" was created successfully
    Then User click on "View Notice to be Sent"
    Then User click the "Close" button

 @tv_regression_015@CC_Test_Regression@Voter
  Scenario: Create Email Correspondence
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      |Address         | 99 NANCY ST   |
   And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Democratic      |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Email Correspondence" button
    And User select "Vik Test 2" from Notice Name dropdown and enter "Test 2" in Notes
    And User click the "OK" button
    Then User verify "EMAIL CORRESPONDENCE" was created successfully

 @tv_regression_016@CC_Test_Regression@Voter
  Scenario: Scan Forms in Attachments tab
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 99 NANCY ST   |
   And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Democratic      |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    And User click on "Attachments"
    And User select "Federal Post Card Application" from Form Type dropdown
    And User click the "Scan" button
    And User click the "Scan Image" button
    And User click on "OK" button
    And User click the "Process" button
    And User click on "OK" button
    Then User verify "Federal Post Card Application" form was created successfully

 @tv_regression_017@CC_Test_Regression@Notice
  Scenario: Verify unsent Mail Notice display in Notices Queue
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 99 NANCY ST   |
   And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Democratic      |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    And User click the "Correspondence" button
    #Deleting notice from previous run
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "Vik Test" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    Then User verify "Vik Test" was created successfully
    And User navigate to home page
    And User click on Notices Queue
    And User waits 5 seconds for background requests to load
    And User verifies in template "QA Automation 1" the notice displayed in the queue

 @tv_regression_018@CC_Test_Regression@PollingPlace
  Scenario: Create a new Polling Place
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User click on "Add New Polling Place"
    And User select "Fire Department" from "Building Type"
    And User fill in the required information fields
      | Field         | Text                |
      | Location Name | Location ABC        |
      | Address       | 17 County Road 2067 |
      | City          | Alpine              |
      | Zip           | 85920               |
      | State         | NV                  |
    And User select following checkboxes
      | Early Voting        |
      | Polling Place       |
      | Firearms Prohibited |
    And User click on "Save" button
    And User click on "OK"
    #And User verify new Polling Place was created successfully

 @tv_regression_019@CC_Test_Regression@PollingPlace@CC_Test_RegressionINDF
  Scenario: Assign Polling Place LocationPass to an Election
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
    And User selects any Election from dropdown menu in Polling Place
    And User select the "0 Green House" checkbox in Polling Place
    And User click on "Save Changes"
    Then the new polling place should be added to the election successfully

 @tv_regression_020@CC_Test_Regression@PollingPlace@CC_Test_RegressionINDF
  Scenario: Assign Polling Place and verify you are unable to make it Inactive if assigned to an Election
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
      #Assign Polling Place Location to an election
    And User selects any Election from dropdown menu in Polling Place
    And User check off "0Location 1 Automation" checkbox from list
    And User click on "Save Changes" button
    And User click on "OK" button
    And User verify Polling Place Location is part of the list and checked off
      #Now we will make the Polling Place Location we assigned to Inactive status
    And User click on "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User enters "0Location 1 Automation" search for Polling Place
    And User click on Edit button for Polling Place
    And User select "Inactive" from Edit Polling Place dropdown
    And User click on Save button in Polling Place
    And User verifies you are unable to make Polling Place Inactive if used in an Election


 @tv_regression_021@CC_Test_Regression@TA@CC_Test_RegressionINDF
  Scenario: Add Address Point
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "TotalAddress" from "County Utilities"
    And switch to "TotalAddress™" tab
    And User click the map "Add point" tab
    And zoom in to at least a zoom of level 17
    And select "Select map location"
    And User move the cursor and click on the map
    And User fill in the required information map fields
      | Field         | Text        |
      | Street Number | UNIQUE      |
      | Street Name   | Main UNIQUE |
    And User click the "Complete" button
    And User click the "Yes" button
    Then User verify the new address point was added successfully

 @tv_regression_022@CC_Test_Regression@Report
  Scenario Outline: Run a Report
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Reports" from "Reports" menu
    Then User verify the "<ReportType>" report was generated
    Examples:
      | ReportType           |
      | Cost Tracking        |
      | Contests in Election |

 @tv_regression_023@CC_Test_Regression@Report
  Scenario: Checking for duplicate Election Abbreviation
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text      | Type     |
      | Election Type:         | SPECIAL   | dropdown |
      | Election Abbreviation: | Test      | input    |
    And User enters Description "County randomtext" for Election
    And User set a valid election date
    And User set a valid date for Early Voting fields
    And User save the selection
    Then the "Election Abbreviation already exists" message should be populated successfully

 @tv_regression_024@CC_Test_Regression@Report
  Scenario Outline: Create and Run Reports from Report Builder in County
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
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

 @tv_regression_025@CC_Test_Regression@Voter@CC_Test_RegressionIND
  Scenario: Adding a new UOCAVA military overseas registrant
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text               |
      | US Citizen     | Yes                |
      | Place Of Birth | Eager              |
      | Address        | 2222 MAIN ST       |
   And User click on "2222 MAIN ST BLUE DIAMOND 89129"
    And User click on "UOCAVA" radio button
    And User select "Overseas Military" from "Type"
    And User fill in the required information fields
      | Field                       | Text            |
      | Start Date                  | 07/01/2023      |
      | End Date                    | 01/01/2025      |
      | UOCAVA Ballot Delivery Type | Email           |
      | Email                       | uocava@new.com  |
      | Suppression Level           | No Restrictions |
      | Political Party             | Independent     |
      | Source of Registration      | Online          |
      | How Registered              | Electronic          |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    Then the new UOCAVA military overseas registrant should be added successfully

 @tv_regression_026 @Voter
  Scenario: Adding a new UOCAVA military overseas ballots
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User enter "MILITARY, TIMMY" into Quick Search field
    And User click on "Ballot Info"
    And User get the current count of Ballots
    And User click on "Create New Ballot"
    And User select "UOCAVA" from "Ballot Issuance Type"
    And User select "Sent" from "Ballot Status"
    And User select "Mail - In State" from "Ballot Issuance Method"
    And User select "Overseas Military" from "UOCAVA Application Type"
    And User select "Mail" from "Prefers to receive ballots by:"
    And User click on "Submit and Process Now"
    Then the new Ballot should be added successfully

 @tv_regression_027 @Voter
  Scenario: Verify Precinct ID match
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User enter "MILITARY, TIMMY" into Quick Search field
    And User click on "Ballot Info"
    And User get the current count of Ballots
    And User click on "Create New Ballot"
    And User select "UOCAVA" from "Ballot Issuance Type"
    And User select "Sent" from "Ballot Status"
    And User select "Mail - In State" from "Ballot Issuance Method"
    And User select "Overseas Military" from "UOCAVA Application Type"
    And User select "Mail" from "Prefers to receive ballots by:"
    And User click on "Submit and Process Now"
    Then the new Ballot should be added successfully
    Then Verify Precinct ID matches the Precinct ID on the left

# @tv_regression_028 @Ballots
#  Scenario: UOCAVA ballots - load
#    Given User navigate to "CC_Test" log in page
#    And User log in as "cc_state" user
#    And User click on "Outbound Ballot Processing"
#    And User click on "Load"
#    And User click on Home page
#    And User click on "Job Queue"
#    And User click on "Process" from "Loaded ballots"
#    And User click on "View List (.csv)" from "Overseas Military" under "Ballots to be sent via Email"
#    Then UOCAVA military overseas ballots should be viewed successfully
#    Then verify UOCAVA military overseas registrant's name is on the list

 @tv_regression_029@CC_Test_Regression@Notice
  Scenario: Create a notice from the Notice Management page
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User click on "County Utilities"
    And User click on "Notice Management"
    And User fills in the required information fields for creating a Notice
      | Field           | Text          | Type     |
      | Name:           | Notice random | input    |
      | Description:    | Test 123      | input    |
      | Can Be Emailed: | Yes           | dropdown |
    And User click on Save button in Notice Management
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 2222 ASH AVE  |
   And User click on "2222 ASH AVE LAS VEGAS 89101"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Green           |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    And User click the "Correspondence" button
    And User click the "Create Email Correspondence" button
    And User verifies dropdown Notice Name has newly created value

 @tv_regression_030@CC_Test_Regression@Candidate
  Scenario: Scanning Candidate Forms in Ballot Setup
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Election Type: | SPECIAL   | dropdown |
    And User set a valid election date
    And User generate and use election abbreviation
    And User set a valid date for Early Voting fields
    And User enters Description "County timestamp" for Election
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    And User gets the current count of contests
    And User gets the current count of candidates
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                                    | Type     |
      | District Type          | ASSEMBLY                                | dropdown |
      | District               | Assembly District 39                    | dropdown |
      | Office                 | ASM - OFFICE ASM (Assembly District 39) | dropdown |
      | Term Type              | Regular                                 | dropdown |
      | Biography Word Limit   | 100                                     | input    |
      | Filing Fee Cost        | 1377.00                                 | input    |
      | Additional Requirement | Automation Test 1                       | input    |
      | Notes                  | Automation Test 2                       | input    |
      | Term Length            | 4                                       | input    |
      | Statement Word Limit   | 200                                     | input    |
      | Vote For               | 1                                       | input    |
    And User click on "Add"
    And User verify new contest was added to the election successfully
    Then the new race should be added to the election successfully
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
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully
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

 @tv_regression_031@CC_Test_Regression@Ballots
  Scenario:Verify Ballot Question Title is displaying correcting in County
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | DOUGLAS   | dropdown |
      | Election Type: | MUNICIPAL | dropdown |
    And User set a valid election date
    And User generate and use election abbreviation
    And User set a valid date for Early Voting fields
    And User enters Description "County timestamp" for Election
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    When User click on County Ballot Question link
    And User deletes any existing Ballot Questions
    And User click the "COUNTY BALLOT QUESTION" button
    And User select "ASSEMBLY" from "District Type" native dropdown
    And User select "Assembly District 39" from "District Name" native dropdown
    And User select "Local" from "Ballot Question Type" native dropdown
    And User fill in the required information fields
      | Field                 | Text                  |
      | Office Sequence No.   | 11                    |
      | Date Received         | -1                    |
      | Date Filed            | 0                     |
      | Ballot Question Title | Test Title 123        |
      | Ballot Question Text  | Automation Testing #1 |
      | Explanatory Statement | Automation Testing #2 |
    And User click the Save button on the Countywide Ballot Page
    Then User verify Ballot Question Title "Test Title 123" matches

 @tv_regression_032@CC_Test_Regression@Ballots@CC_Test_RegressionINDF
  Scenario: Verify Ballot Question is displaying District Type and District Name correctly in State
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_state" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text    | Type     |
      | Jurisdiction:  | STATE   | dropdown |
      | Election Type: | PRIMARY | dropdown |
    And User set a valid election date
    And User enters Description "County randomtext" for Election
    And User set a valid date for Early Voting fields
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    And User click on Statewide Ballot Question link
    And User click the ADD NEW STATEWIDE BALLOT QUESTION link
    And User select "CONGRESSIONAL" from "District Type" native dropdown
    And User select "CONGRESSIONAL DISTRICT 2" from "District Name" native dropdown
    And User select "Initiative to the People" from "Ballot Question Type" native dropdown
    And User fill in the required information fields
      | Field                 | Text       |
      | Office Sequence No.   | 11         |
      | Date Received         | -1         |
      | Date Filed            | 0          |
      | Ballot Question Title | TEST       |
      | Ballot Question Text  | Testing #1 |
      | Explanatory Statement | Testing #2 |
    And User click the Save button on the Statewide Ballot Page
    Then verify District Name "CONGRESSIONAL DISTRICT 2" is displaying correctly
    Then verify District Type "CON" is displaying correctly

 @tv_regression_033@CC_Test_Regression@Voter
  Scenario: Change Status/Status Reason
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 100 CARSON ST |
    And User click on "100 CARSON ST GENOA 89411"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Green           |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    And User click on "Update"
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | CANCELLED              |
      | Registration Status Reason | FELONY                |
    And User click the "Update Registrant" button
    Then User validates the Registration Status is set to "CANCELLED"
    And User click on "Update"
    And User select following data from dropdown
      | Field                      | Text                        |
      | Change Type                | Administrative Update       |
      | Registration Status        | ACTIVE                      |
      | Registration Status Reason | FAILURE TO VOTE |
    And User enter "Automation Test" into Note field
    And User click the "Update Registrant" button
    Then User validates the Registration Status is set to "ACTIVE"

 @tv_regression_034@CC_Test_Regression@Voter
  Scenario: Turn Cancelled Voter to Active
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 100 CARSON ST |
    And User click on "100 CARSON ST GENOA 89411"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Green           |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    #Update Voter to CANCELLED Status
    And User click the "Update" button
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | CANCELLED             |
      | Registration Status Reason | FELONY                |
    And User click on "Update Registrant" button
    Then User validates the Registration Status is set to "CANCELLED"
    #And User validates the Registration Status Reason is set to "FELONY"
    #Update Voter back to ACTIVE
    And User click the "Update" button
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | ACTIVE                |
      | Registration Status Reason | 33 DAY PROCESS                |
    And User click on "Update Registrant" button
    Then User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"



 @tv_regression_035@CC_Test_Regression@CoreIND
  Scenario: Verify Possible Duplicate Registrants - Out of County  count matches count listed in the Task Queue
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User click on "Possible Duplicate Registrants - Out of County Matches" report and get count
    And User select "Possible Duplicate Registrants" from "Voter Registration"
    And User click on "Out of County Matches"
    And User verify report counts matches Task Queue

 @tv_regression_036@CC_Test_Regression@Voter
  Scenario: Verify you can click on Edit button on a Ballot without getting any reload errors
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    When User enter "BIAGGI, LINDA M" into Quick Search field
    And User click on "Ballot Info"
    And User clicks on Edit button on a Ballot

 @tv_regression_037@CC_Test_Regression@Voter @CoreIND
  Scenario: Create a Petition
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Petitions" from "County Utilities"
    And User click on "Add Petition" button
    And User select "Initiative to the Legislature" from " Petition Type: "
    And User select "Original Pages" from " Circulation Start Date: "
    When I select the current date from the dropdown with name " Circulation Start Date: "
    When I select the current date from the dropdown with name " Circulation End Date: "
    When I select the current date from the dropdown with name " Submitted Date: "
    When I select the current date from the dropdown with name " Initial Filing Date: "
    When I select the current date from the dropdown with name " Signatures Filed Date: "
    When I select the current date from the dropdown with name " Determination Date: "
    And User fill in the required information fields
      | Field           | Text            |
      | Lines Per Page: | 2               |
      | Petition Title: | Automation Test |
    And User click the "Save" button

 @tv_regression_38@CC_Test_Regression@Voter @CoreIND
  Scenario: Adding a new registrant (Confidential Voter)
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 100 CARSON ST |
    And User click on "100 CARSON ST GENOA 89411"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | Confidential |
      | Source of Registration | Online          |
      | Political Party        | Green           |
      | How Registered         | Electronic      |
    And User verifies Document is Signed
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    #And User validates the Registration Status Reason is set to "ACTIVE"
    Then the new registrant should be added successfully
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then The voter is set to "Confidential"

 @tv_regression_39@CC_Test_Regression@Voter
  Scenario: Create District Office
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Districts" from "State Utilities"
    And User select "CONGRESSIONAL" from "District Type"
    And User click the "Create" button
    When User enter "Apache" into Counties field
    And User click the Apache icon button

 @tv_regression_40@CC_Test_Regression@TA @CoreIND
  Scenario: Add Address Point, verify precinct auto assigned
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "TotalAddress" from "County Utilities"
    And switch to "TotalAddress™" tab
    And User click the map "Add point" tab
    And zoom in to at least a zoom of level 17
    And select "Select map location"
    And User move the cursor and click on the map
    And User fill in the required information map fields
      | Field         | Text        |
      | Street Number | UNIQUE      |
      | Street Name   | Main UNIQUE |
      | City          | GENOA      |
    And User click the "Complete" button
    And User click the "Yes" button
    When User click on "More"
    Then verify the precinct field is populated and not "UNDEFINED"

 @tv_regression_041@CC_Test_RegressionRegression
  Scenario: Verify data is displaying properly when navigating between pages and last page in the task queue
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User click on "Possible Duplicate Registrants - In County Matches"
    And I click on "2" page in pagination
    Then User verifies all data is displaying properly in the table
    And I click on "Last" page in pagination
    Then User verifies all data is displaying properly in the table

 @tv_regression_042@CC_Test_RegressionRegression
  Scenario: Validate required fields such as SSN, DL and others and make sure all checks passed
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User click on "Add New"
    And User click on "Run All Checks" button
    And I validate following error message on the page
      | Required Fields                     | displayed |
      | Application Number is required.     | true      |
      | First Name is required.             | true      |
      | How Registered is required.         | true      |
      | Last Name is required.              | true      |
      | Source of Registration is required. | true      |
      | Political Party is required.        | true      |
    And User fill in the required information fields
      | Field   | Text     |
      | First Name    | GENIA     |
      | Last Name    | HOLMES     |
    And User click on "Run All Checks" button
    And I validate following error message on the page
      | Required Fields                     | displayed |
      | Application Number is required.     | true      |
      | How Registered is required.         | true      |
      | Source of Registration is required. | true      |
      | Political Party is required.        | true      |
    And User fill in the required information fields
      | Field   | Text     |
      | Source of Registration | Online |
      | How Registered    | Electronic     |
    And User click on "Run All Checks" button
    And I validate following error message on the page
      | Required Fields                     | displayed |
      | Application Number is required.     | true      |
      | Political Party is required.        | true      |


 @tv_regression_043@CC_Test_Regression@TA
  Scenario: Add a voter to the newly created Address in TA
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Search"
    And User click on "Add New Voter"
    And User creates unique data for a Registrant
      | Field              | Text   |
      | Application Number | random |
    And User fill in the required information fields
      | Field          | Text          |
      | US Citizen     | Yes           |
      | Place Of Birth | Eager         |
      | Address        | 100 CARSON ST |
    And User click on "100 CARSON ST GENOA 89411"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | Political Party        | Green           |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "OK" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully
    And User select "TotalAddress" from "County Utilities"
    And switch to "TotalAddress™" tab
    When User click on "Registrants" button
    Then User should see the registrants name matches

 @tv_regression_044@CC_Test_RegressionRegression
  Scenario: Add Registrant pre-fill in lower case
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
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

 @tv_regression_045@CC_Test_RegressionRegression
  Scenario: Adding a Office in Office/Incumbent Management (Minimum Info)
    Given User navigate to "CC_Test" log in page
    And User log in as "cc_county" user
    And User select "Office/Incumbent Management" from "Election Management"
    When User click on "Add Office" button
    And User select "ASSEMBLY" from "Base District Type"
    And User select "Assembly District 39" from "Base District"
    And User select following checkboxes
      | Is Active |
    And User enters office name as "0_Random"
    And User fill in the required information fields
      | Field    | Text |
      | Term     | 4    |
      | Vote For | 6    |
    When User click on "Add" button
    Then User verify office has been added.
