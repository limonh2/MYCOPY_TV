Feature: Core Staging Regression Tests


  @tv_regression_001 @StagingRegression @Election @StagingIND
  Scenario: Creating an Election and Adding a Contest and Candidate to the Election created in State
    Given User navigate to "Staging" log in page
    And User log in as "core_state" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Statewide | dropdown |
      | Election Type: | GENERAL   | dropdown |
    And User enters Description "State randomtext" for Election
    And User set a valid election date
    And User save the selection
    Then the new election should be created successfully
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
    When User click on "Add"
    Then the new race should be added to the election successfully
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
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully


  @tv_regression_002 @StagingRegression @Election @StagingIND
  Scenario: Creating an Election and Adding a Contest and Candidate to the Election created in County
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Apache    | dropdown |
      | Election Type: | MUNICIPAL | dropdown |
    And User enters Description "County randomtext" for Election
    And User set a valid election date
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
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


  @tv_regression_003 @StagingRegression @OBP  @StagingIND
  Scenario: Verify OutBound Ballot Processing Avery_Dymo Labels user preferences are saved
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User navigates to User Preferences for OutBound Ballot Processing page
    And User selects Preferences for Outbound Ballot Processing Avery_Dymo Labels
      | Field         | Text         |
      | Option One:   | Party        |
      | Option Two:   | Precinct     |
      | Option Three: | Ballot Style |
    And User clicks on Save button for User Preferences
    And User navigate to home page
    And User navigates to User Preferences for OutBound Ballot Processing page
    And User verifies Preferences was saved for Outbound Ballot Processing Avery_Dymo Labels

  @tv_regression_007  @Election @StagingIND
  Scenario Outline: Create and Run Reports from Report Builder in State
    Given User navigate to "Staging" log in page
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
    Examples:
      | ReportName                   |
      | Candidate Proofing           |
      | Ballot Proofing              |
      | County Precincts With Splits |


  @tv_regression_008 @StagingRegression @Ballots @StagingIND
  Scenario: Create Ballot Question and Create ballot styles in county
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Apache    | dropdown |
      | Election Type: | MUNICIPAL | dropdown |
    And User enters Description "County randomtext" for Election
    And User set a valid election date
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
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
    And User click the "Create Ballot Styles" button
    And User verify ballot styles were created successfully

  @tv_regression_009 @StagingRegression @Voter @StagingIND
  Scenario: Adding a new registrant (Minimum information)
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Place Of Birth | Eager    |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                    | Text               |
      | Suppression Level        | No Restrictions    |
      | Source of Registration   | Online             |
      | How Registered           | Electronic         |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully

  @tv_regression_010 @StagingRegression @Voter @StagingIND
  Scenario: Adding a new registrant (Maximum information)
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Middle Name    | Dennis   |
      | Place Of Birth | Eager    |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                    | Text                                              |
      | Suffix                   | SR                                                |
      | Alternate ID             | Bank Statement                                    |
      | Political Party          | Republican                                        |
      | Gender                   | M                                                 |
      | Communication Preference | Fax                                               |
      | Assistance Needed        | Physical                                          |
      | Accessible Ballot        | Large Print                                       |
      | NVRA Agency Type         | PAA - Women, Infants & Children Nutrition Clinics |
      | Suppression Level        | No Restrictions                                   |
      | Source of Registration   | Online                                            |
      | How Registered           | Electronic                                        |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully

  @tv_regression_011 @StagingRegression @Voter @Candidate
  Scenario: Add the voter as a candidate on a ballot
#  Prerequisites: created a new or existed Voter
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "Automation Ballots 03" election
    When User enter "CARNEY, DANNY H" into Quick Search field
    And User click on "CARNEY, DANNY H"
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

  @tv_regression_012 @StagingRegression @Voter @StagingIND
  Scenario: Update Mailing Address of a Voter
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    When User enter "CARNEY, DANNY H" into Quick Search field
    And User click on "CARNEY, DANNY H"
    And User updates Mailng Address
    And User click on "Run All Checks"
    And User click the "Update Registrant" button
    And User click on "Yes" button
    Then User verify Address fields were updated successfully

  @tv_regression_013 @StagingRegression @Voter
  Scenario: Search for Voters
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Advanced Search" from "Reports"
    And User fill in the required information fields
      | Field      | Text |
      | First Name | John |
      | Last Name  | Doe  |
    And User click the "Search" button
    Then User verify search results
      | Key       | Value |
      | FirstName | John  |
      | LastName  | Doe   |

  @tv_regression_014 @StagingRegression @Voter @StagingIND
  Scenario: Create Mail Correspondence
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Place Of Birth | Eager    |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                    | Text               |
      | Suppression Level        | No Restrictions    |
      | Source of Registration   | Online             |
      | How Registered           | Electronic         |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "QA Automation 1" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    Then User verify "QA AUTOMATION 1" was created successfully
    Then User click on "View Notice to be Sent"
    Then User click the "Close" button

  @tv_regression_015 @StagingRegression @Voter @StagingIND
  Scenario: Create Email Correspondence
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Place Of Birth | Eager    |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                    | Text               |
      | Suppression Level        | No Restrictions    |
      | Source of Registration   | Online             |
      | How Registered           | Electronic         |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Email Correspondence" button
    And User select "QA Automation 2" from Notice Name dropdown and enter "Test 2" in Notes
    And User click the "OK" button
    Then User verify "EMAIL CORRESPONDENCE" was created successfully

  @tv_regression_016 @StagingRegression @Voter @StagingIND
  Scenario: Scan Forms in Attachments tab
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Place Of Birth | Eager    |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                    | Text               |
      | Suppression Level        | No Restrictions    |
      | Source of Registration   | Online             |
      | How Registered           | Electronic         |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully
    And User click on "Attachments"
    And User select "Online Registration" from Form Type dropdown
    And User click the "Scan" button
    And User click the "Scan Image" button
    And User click the Process button for Scanner
    And User click on "OK"
    Then User verify "Online Registration" form was created successfully

  @tv_regression_017 @StagingRegression @Notice @StagingIND
  Scenario: Verify unsent Mail Notice display in Notices Queue
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Place Of Birth | Eager    |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                    | Text               |
      | Suppression Level        | No Restrictions    |
      | Source of Registration   | Online             |
      | How Registered           | Electronic         |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "QA Automation 1" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    Then User verify "QA AUTOMATION 1" was created successfully
    And User navigate to home page
    And User click on Notices Queue
    And User waits 5 seconds for background requests to load
    And user verifies in template "QA Automation 1" the notice displayed in the queue

  @tv_regression_018 @StagingRegression @PollingPlace
  Scenario: Create a new Polling Place
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
      | State         | AZ                  |
      | County        | Apache              |
    And User select following checkboxes
      | Early Voting        |
      | Polling Place       |
      | Firearms Prohibited |
    And User click on "Save" button
    And User click on "OK"
    #And User verify new Polling Place was created successfully

  @tv_regression_019 @StagingRegression @PollingPlace
  Scenario: Assign Polling Place Location to an Election
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
    And User select "2023  - 06/30/2024 - 100003877" from "Election"
    And User select the "0 Green House" checkbox in Polling Place
    And User click on "Save Changes"
    Then the new polling place should be added to the election successfully

  @tv_regression_020 @StagingRegression @PollingPlace
  Scenario: Assign Polling Place and verify you are unable to make it Inactive if assigned to an Election
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
    And User selects "2023  - 06/30/2024 - 100003877" from election dropdown in Polling Place
    And User check off "0Location 1 Automation" checkbox from list
    And User click on "Save Changes" button
    And User click on "OK" button
    And User verify Polling Place Location is part of the list and checked off
    And User click on "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User enters "0Location 1 Automation" search for Polling Place
    And User click on Edit button for Polling Place
    And User select "Inactive" from Edit Polling Place dropdown
    And User click on Save button in Polling Place
    And User verifies you are unable to make Polling Place Inactive if used in an Election


  @tv_regression_021 @StagingRegression @TA
  Scenario: Add Address Point
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
      | City          | ALPINE      |
    And User click the "Complete" button
    And User click the "Yes" button
    Then User verify the new address point was added successfully

  @tv_regression_022 @StagingRegression @Report
  Scenario Outline: Run a Report
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Reports" from "Reports" menu
    Then User verify the "<ReportType>" report was generated
    Examples:
      | ReportType           |
      | Cost Tracking        |
      | Contests in Election |

  @tv_regression_023 @StagingRegression @Report
  Scenario: Checking for duplicate Election Abbreviation
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text      | Type     |
      | Election Type:         | MUNICIPAL | dropdown |
      | Election Abbreviation: | 23        | input    |
    And User enters Description "County randomtext" for Election
    And User set a valid election date
    And User save the selection
    Then the "Election Abbreviation already exists" message should be populated successfully

  @tv_regression_024  @Report
  Scenario Outline: Create and Run Reports from Report Builder in County
    Given User navigate to "Staging" log in page
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

  @tv_regression_025 @StagingRegression @Voter @PASS
  Scenario: Adding a new UOCAVA military overseas registrant
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User click on "UOCAVA" radio button
    And User select "Overseas Military" option from UOCACA Type "Email"
    And User fill in the required information fields
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Place Of Birth | Eager          |
      | Start Date     | 07/01/2023     |
      | End Date       | 01/01/2025     |
      | Email          | uocava@new.com |
      | Address        | 99 NANCY ST    |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully
    Then the new UOCAVA military overseas registrant should be added successfully

  @tv_regression_026 @Voter @StagingIND
  Scenario: Adding a new UOCAVA military overseas ballots
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User enter "SMITH, SAM_UOCAVA" into Quick Search field
    And User click on "SMITH, SAM_UOCAVA"
    And User click on "Ballot Info"
    And User get the current count of Ballots
    And User click on "Create New Ballot"
    And User select "UOCAVA" from "Ballot Issuance Type"
    And User select "Sent" from "Ballot Status"
    And User select "Mail - In State" from "Ballot Issuance Method"
    And User select "Overseas Military" from "UOCAVA Application Type"
    And User select "Mail" from "Prefers to receive ballots by:"
    And User click on "Submit and Process Now"
    And User get the current count of ballots after
    And User compares the Before and After Values of the Ballot

  @tv_regression_027 @Voter
  Scenario: Verify Precinct ID match
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User enter "SMITH, SAM_UOCAVA" into Quick Search field
    And User click on "SMITH, SAM_UOCAVA"
    And User click on "Ballot Info"
    And User get the current count of ballots before
    And User click on "Create New Ballot"
    And User select "UOCAVA" from "Ballot Issuance Type"
    And User select "Sent" from "Ballot Status"
    And User select "Mail - In State" from "Ballot Issuance Method"
    And User select "Overseas Military" from "UOCAVA Application Type"
    And User select "Mail" from "Prefers to receive ballots by:"
    And User click on "Submit and Process Now"
    And User get the current count of ballots after
    And User compares the Before and After Values of the Ballot

  @tv_regression_028 @Ballots
  Scenario: UOCAVA ballots - load
    Given User navigate to "Staging" log in page
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
    And User click on "View"
    Then User verify the "Ballots to be sent via MAIL" is displaying
    Then User verify the "Ballots to be sent via EMAIL" is displaying

  @tv_regression_029 @StagingRegression @Notice
  Scenario: Create a notice from the Notice Management page
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Place Of Birth | Eager    |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                    | Text               |
      | Suppression Level        | No Restrictions    |
      | Source of Registration   | Online             |
      | How Registered           | Electronic         |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully
    And User click the "Correspondence" button
    And User click the "Create Email Correspondence" button
    And User verifies dropdown Notice Name has newly created value

  @tv_regression_030 @StagingRegression @Candidate @StagingIND
  Scenario: Scanning Candidate Forms in Ballot Setup
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Apache    | dropdown |
      | Election Type: | MUNICIPAL | dropdown |
    And User enters Description "County randomtext" for Election
    And User set a valid election date
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
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

  @tv_regression_031 @StagingRegression @Ballots @StagingIND
  Scenario:Verify Ballot Question Title is displaying correcting
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Apache    | dropdown |
      | Election Type: | MUNICIPAL | dropdown |
    And User enters Description "County randomtext" for Election
    And User set a valid election date
    And User click the Save button on the Add new Election Page
    Then the new election should be created successfully
    And User select "Ballot Set Up" from "Election Management"
    When User click on County Ballot Question link
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
    And User click the Save button on the Countywide Ballot Page
    Then User verify Ballot Question Title "Test Title 123" matches

  @tv_regression_032 @StagingRegression @Ballots
  Scenario: Verify Ballot Question is displaying District Type and District Name correctly
    Given User navigate to "Staging" log in page
    And User log in as "core_state" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Statewide | dropdown |
      | Election Type: | GENERAL   | dropdown |
    And User enters Description "State randomtext" for Election
    And User set a valid election date
    And User save the selection
    Then the new election should be created successfully
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
    And User click the Save button on the Statewide Ballot Page
    Then verify District Name "CONGRESSIONAL DISTRICT 1" is displaying correctly
    Then verify District Type "CGX" is displaying correctly

  @tv_regression_033 @StagingRegression @Voter
  Scenario: Change Status/Status Reason
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    When User enter "DAVID, PETE" into Quick Search field
    And User click on "DAVID, PETE"
    And User click on "Update"
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | CANCELED              |
      | Registration Status Reason | FELONY                |
    And User click the "Update Registrant" button
    Then User validates the Registration Status is set to "CANCELED"
    And User click on "Update"
    And User select following data from dropdown
      | Field                      | Text                        |
      | Change Type                | Administrative Update       |
      | Registration Status        | ACTIVE                      |
      | Registration Status Reason | RE-ACTIVATED (CONF MAILING) |
    And User enter "Automation Test" into Note field
    And User click the "Update Registrant" button
    Then User validates the Registration Status is set to "ACTIVE"

  @tv_regression_034 @StagingRegression @Voter
  Scenario: Turn Cancelled Voter to Active
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    When User enter "10122452" into Barcode or Registration ID field
    And User click the "Update" button
    And User select following data from dropdown
      | Field                      | Text          |
      | Registration Status        | ACTIVE        |
      | Registration Status Reason | VOTER REQUEST |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on "Update Registrant" button
    Then User validates the Registration Status is set to "ACTIVE"
    And User click the "Update" button
    And User select following data from dropdown
      | Field                      | Text      |
      | Registration Status        | CANCELED |
      | Registration Status Reason | FELONY    |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on "Update Registrant" button
    Then User validates the Registration Status is set to "CANCELED"

  @tv_regression_035 @StagingRegression
  Scenario: Verify Possible Duplicate Registrants - Out of County  count matches count listed in the Task Queue
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    And User click on "Possible Duplicate Registrants - Out of County Matches" report and get count
    And User select "Possible Duplicate Registrants" from "Voter Registration"
    And User click on "Out of County Matches"
    And User verify report counts matches Task Queue

  @tv_regression_036 @StagingRegression @Voter
  Scenario: Verify you can click on Edit button on a Ballot without getting any reload errors
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
    When User enter "CONLEY, VINCENT N" into Quick Search field
    And User click on "CONLEY, VINCENT N"
    And User click on "Ballot Info"
    And User clicks on Edit button on a Ballot

  @tv_regression_037 @StagingRegression @Voter
  Scenario: Create a Petition
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
      | Field          | Text     |
      | Lines Per Page: | 2       |
      | Petition Title: | Automation Test    |
    And User click the "Save" button

  @tv_regression_38 @StagingRegression @Voter
  Scenario: Adding a new registrant (Confidential Voter)
    Given User navigate to "Staging" log in page
    And User log in as "core_county" user
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
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Place Of Birth | Eager    |
      | Address | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select "Confidential" from "Suppression Level"
    And User select "Democrat" from "Political Party"
    And User select "Online" from "Source of Registration"
    And User select "Electronic" from "How Registered"
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    When User click on "Yes"
    And User click on Add Registrant button
    Then The voter is set to "Confidential"

  @tv_regression_39 @StagingRegression @Voter
  Scenario: Create District Office
    Given User navigate to "Staging" log in page
    And User log in as "core_state" user
    And User select "Districts" from "State Utilities"
    And User select "CONGRESSIONAL" from "District Type"
    And User click the "Create" button
    When User enter "Apache" into Counties field
    And User click the Apache icon button

  @tv_regression_041 @StagingRegression
  Scenario: Verify data is displaying properly when navigating between pages and last page in the task queue
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User click on "Possible Duplicate Registrants - In County Matches"
    And I click on "2" page in pagination
    Then User verifies all data is displaying properly in the table
    And I click on "Last" page in pagination
    Then User verifies all data is displaying properly in the table

  @tv_regression_042 @StagingRegression
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
    And User click on "Run All Checks" button
    And I validate following error message on the page
      | Required Fields              | displayed |
      | DL/ID # is required.         | false     |
      | Last 4 from SSN is required. | false     |