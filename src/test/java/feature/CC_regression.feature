Feature: Regression Tests


#  Background:
#    Given User navigate to "CC_Dev" log in page

  @tv_regression_001 @CCRegression @Election
  Scenario: Adding a new election in State
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_state" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Election Type: | GENERAL   | dropdown |
    And User enters Description "State randomtext" for Election
    And User set a valid election date
    When User save the selection
    Then the new election should be created successfully

  @tv_regression_002 @CCRegression @Election
  Scenario: Adding a contest to a new election in State
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_state" user
    And User select "Elections" from "Election Management"
    And User select "State PB60" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                                   | Type     |
      | District Type          | Statewide                              | dropdown |
      | Office                 | SW - Secretary Of State - 1/1/2026     | dropdown |
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
#
  @tv_regression_003 @CCRegression @Election
  Scenario: Adding a candidate to a race in a new election in State
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_state" user
    And User select "Elections" from "Election Management"
    And User select "State QA2" election
    And User select "Ballot Set Up" from "Election Management"
    And User click the plus button to add candidate
    And User click the "Add Candidate" button
    And User gets the current count of candidate
    And User click the " Save" button
    And User click the "OK" button
    And User fills in the required information fields for creating a new candidate
      | Field            | Text                               | Type     |
      | Ballot Order     | 01                                 | input    |
      | Ballot Name      | SW - Secretary Of State - 1/1/2026 | input    |
      | Party            | Democratic                         | dropdown |
      | Candidate Type   | State Filed                        | dropdown |
      | First Name       | Larry                              | input    |
      | Last Name        | Bird                               | input    |
      | Address          | 566 Fox Links st                   | input    |
      | City             | Las Vegas                          | input    |
      | Zip              | 89012                              | input    |
      | County           | CLARK                              | dropdown |
      | Municipality     | 19                                 | input    |
      | Candidate Status | Approved                           | dropdown |
      | Receipt Number   | 7882938374747                      | input    |
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully

  @tv_regression_004 @CCRegression @Election
  Scenario: Adding a new election in county
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field                 | Text      | Type     |
      | Election Type:        | SPECIAL   | dropdown |
      | Election Name         | SP17      | input    |
      | Election Abbreviation | 0017      | input    |
    And User enters Description "County randomtext" for Election
    And User set a valid election date
    And User click the "Save" button
    Then the new election should be created successfully

  @tv_regression_005 @CCRegression @Election
  Scenario: Adding a contest to a new election in county
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User select "County XO56" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                                            | Type     |
      | District Type          | County                                          | dropdown |
      | District               | CLARK                                           | dropdown |
      | Office                 | CTY - County Clerk (COUNTY) - 1/1/2026          | dropdown |
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

  @tv_regression_006 @CCRegression @Election
  Scenario: Adding a candidate to a race in a new election in County
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User select "County XO56" election
    And User select "Ballot Set Up" from "Election Management"
    And User click the plus button to add candidate
    And User click the "Add Candidate" button
    And User gets the current count of candidates
    And User click the " Save" button
    And User click the "OK" button
    And User fills in the required information fields for creating a new candidate
      | Field            | Text                               | Type     |
      | Ballot Order     | 01                                 | input    |
      | Ballot Name      | CTY - County Clerk (COUNTY)        | input    |
      | Party            | Democratic                         | dropdown |
      | Candidate Type   | County Filed                       | dropdown |
      | First Name       | Larry                              | input    |
      | Last Name        | Bird                               | input    |
      | Address          | 566 Fox Links st                   | input    |
      | City             | Las Vegas                          | input    |
      | Zip              | 89012                              | input    |
      | Municipality     | 19                                 | input    |
      | Candidate Status | Approved                           | dropdown |
      | Receipt Number   | 7882938374747                      | input    |
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully

  @tv_regression_007 @CCRegression @Election
  Scenario: Checking for duplicate Election Abbreviation
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text      | Type     |
      | Election Type:         | SPECIAL   | dropdown |
      | Election Name          | SP0122    | input    |
      | Election Abbreviation: | 23        | input    |
    And User enters Description "County randomtext" for Election
    And User set a valid election date
    When User click the "Save" button
    Then the "Election Abbreviation already exists" message should be populated successfully

  @tv_regression_008 @CCRegression @Ballots
  Scenario: Create Ballot Question and Create ballot styles in county
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User select "Automation Ballots 02" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on County Ballot Question link
    And User click the "COUNTY BALLOT QUESTIONS" button
    And User select "County" from "District Type" native dropdown
    And User select "COUNTY" from "District Name" native dropdown
    And User select "County" from "Ballot Question Type" native dropdown
    And User fill in the required information fields
      | Field                 | Text       |
      | Office Sequence No.   | 11         |
      | Date Received         | 0          |
      | Date Filed            | -1         |
      | Ballot Question Title | TEST       |
      | Ballot Question Text  | Testing #1 |
      | Explanatory Statement | Testing #2 |
    And User click the "Save" button
    And User click on "Ballot Styles"
    And User click the "Create Ballot Styles" button
    And User verify ballot styles were created successfully

  @tv_regression_009 @CCRegression @Voter
  Scenario: Adding a new registrant (Minimum information)
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User fill in the required information fields
      | Field      | Text       |
      | Last Name  | Roberts    |
      | First Name | Amanda     |
      | SSN4       | 6547       |
      | DOB        | 05/01/1987 |
      | DL/ID #    | 24558746   |
    And User click on "Search"
    And User click on "Add New" button
    And User fill in the required information fields
      | Field              | Text             |
      | US Citizen         | Yes              |
      | Application Number | E4783            |
      | Address            | 121212 MAIN ST   |
      | City               | Los Angeles      |
      | Zip                | 89015            |
      | County             | Clark            |
      | Precinct Split     | 1000.1           |
    And User select "No Restrictions" from "Suppression Level"
    And User select "Online" from "Source of Registration"
    And User select "Electronic" from "How Registered"
    And User click on "Run All Checks" button
    And User click on "Dismiss All" button
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully

  @tv_regression_010 @Voter
  Scenario: Adding a new registrant (Maximum information)
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User fill in the required information fields
      | Field      | Text       |
      | Last Name  | Roberts    |
      | First Name | Amanda     |
      | SSN4       | 6547       |
      | DOB        | 05/01/1987 |
      | DL/ID #    | 24558746   |
    And User click on "Search"
    And User click on "Add New" button
    And User fill in the required information fields
      | Field          | Text     |
      | US Citizen     | Yes      |
      | Place Of Birth | Eager    |
      | Address        | 100 1120 |
      | City           | GREER    |
      | Zip            | 85927    |
      | County         | Apache   |
    And User select "09.2 SD 06" from "Precinct Split"
    And User select "No Restrictions" from "Suppression Level"
    And User select "Online" from "Source of Registration"
    And User select "Electronic" from "How Registered"
    And User click on "Run All Checks" button
    And User click on "Dismiss All" button
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully

  @tv_regression_011 @CCRegression @Contest
  Scenario: Add the voter as a candidate on a ballot
#  Prerequisites: created a new or existed Voter
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User select "SP09" election
    When User enter "FORD, TOMMY JOE , JR" into Quick Search field
    And User click on "FORD, TOMMY JOE , JR"
    And User click on "Add to Contest"
    And User fills in the required information fields for creating election related functions
      | Field            | Text                                | Type     |
      | Select a Contest | CTY - Clark County Sheriff (COUNTY) | dropdown |
    And User click on "Continue"
    And User switch to new window
    And User gets the current count of candidates
    And User click the " Save" button
    And User click the "OK" button
    And User fills in the required information fields for creating a new candidate
      | Field            | Text                               | Type     |
      | Ballot Order     | 01                                 | input |
      | Ballot Name      | CTY - County Sheriff (COUNTY)      | input    |
      | Candidate Type   | County Filed                       | dropdown |
      | County           | CLARK                              | dropdown |
      | Municipality     | 19                                 | input    |
      | Candidate Status | Approved                           | dropdown |
      | Receipt Number   | 7882938374747                      | input    |
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully

  @tv_regression_012 @CCRegression @Voter
  Scenario: Update Mailing Address of a Voter
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User select "Automation Ballots 03" election
    When User enter "DROW, STELLA" into Quick Search field
    And User click on "DROW, STELLA"
    And User updates Mailing Address in NV
    And User click on "Run All Checks"
    And User click the "OK" button
    And User click the "Update Registrant" button
    And User click the "Yes" button
    Then User verify Address fields were updated successfully in NV

  @tv_regression_013 @CCRegression @Voter
  Scenario: Search for Voters
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Advanced Search" from "Reports"
    And User fill in the required information fields
      | Field      | Text  |
      | First Name | CLARA |
      | Last Name  | LEE   |
    And User click the "Search" button
    Then User verify search results
      | Key       | Value  |
      | FirstName | CLARA  |
      | LastName  | LEE    |

  @tv_regression_014 @CCRegression @Voter
  Scenario: Create Mail Correspondence
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    When User enter "TOM, STEPHANIE" into Quick Search field
    And User click on "TOM, STEPHANIE"
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "QA Automation 1" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    Then User verify "QA AUTOMATION 1" was created successfully
    Then User click on "View Notice to be Sent"
    Then User click the "Close" button

  @tv_regression_015 @CCRegression @Voter
  Scenario: Create Email Correspondence
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    When User enter "DROW, STELLA" into Quick Search field
    And User click on "DROW, STELLA"
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Email Correspondence" button
    And User select "QA Automation 2" from Notice Name dropdown and enter "Test 2" in Notes
    And User click the "OK" button
    Then User verify "EMAIL CORRESPONDENCE" was created successfully

  @tv_regression_016 @CCRegression @Voter
  Scenario: Scan Forms in Attachments tab
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    When User enter "DROW, STELLA" into Quick Search field
    And User click on "DROW, STELLA"
    And User click on "Attachments"
    And User click the "Scan" button
    And User select "Candidate ID" from Form Type dropdown
    And User click the "Scan Image" button
    And User click on "OK"
    And User click the "Process" button
    And User click on "OK"
    Then User verify "Candidate ID" form was created successfully

  @tv_regression_017 @CCRegression @Candidate
  Scenario: Scanning Candidate Forms in Ballot Setup
#  Prerequisites: Election, Contest, Candidate
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User select "SPClark" election
    And User select "Ballot Set Up" from "Election Management"
    And User click the plus button to add candidate
    And User waits 5 seconds for background requests to load
    And User click the Scan button in Ballot Setup
    And User switch to new window
    And User fills in the required information fields for creating election related functions
      | Field     | Text                  | Type     |
      | Form Type | Candidate ID          | dropdown |
    And User click the "Scan Image" button
    And User click the "Process" button
    And User click on "OK"
    And User switch to Home window
    And User click the View button in Ballot Setup
    Then User verify a form got scanned successfully

  @tv_regression_018 @CCRegression @PollingPlace
  Scenario: Create a new Polling Place
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User click on "Add New Polling Place"
    And User select "Fire Department" from "Building Type"
    And User fill in the required information fields
      | Field         | Text                |
      | Location Name | ABC Test            |
      | Address       | 569 Fox Links St    |
      | City          | Henderson           |
      | Zip           | 89012               |
      | State         | NV                  |
      | County        | CLARK               |
    And User select following checkboxes
      | Early Voting        |
      | Polling Place       |
      | Firearms Prohibited |
    And User click on "Save" button
    And User click on "OK"
    #And User verify new Polling Place was created successfully

  @tv_regression_019 @CCRegression @PollingPlace
  Scenario: Assign Polling Place Location to an Election
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
    And User select "SP06 - 02/02/2024" from "Election"
    And User select the "ABC Test" checkbox in Polling Place
    And User click on "Save Changes"
    Then the new polling place should be added to the election successfully

  @tv_regression_020 @CCRegression @PollingPlace
  Scenario: Assign and Edit Polling Place Location
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
      #Assign Polling Place Location to an election
    And User selects "SP06 - 02/02/2024" from election dropdown in Polling Place
    And User check off "ABC Test" checkbox from list
    And User click on "Save Changes" button
    And User click on "OK" button
    And User verify Polling Place Location is part of the list and checked off
      #Now we will make the Polling Place Location we assigned to Inactive status
    And User click on "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User enters "ABC Test" search for Polling Place
    And User click on Edit button for Polling Place
    And User select "Inactive" from Edit Polling Place dropdown
    And User click on Save button in Polling Place
    And User click the "OK" button
      #Now we verify Polling Place Location is no longer displayed in the list since status is Inactive
    And User click on "Election Management"
    And User click on "Assign to Election"
    And User selects "SP06 - 02/02/2024" from election dropdown in Polling Place
    And User verify Polling Place Location is no longer part of the list of checkboxes
      #Now we will update the Polling Place used back to Active status for next run
    And User click on "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User select "Inactive" from "Active"
    And User enters "ABC Test" search for Polling Place
    And User click on Edit button for Polling Place
    And User select "Active" from Edit Polling Place dropdown
    And User click on Save button in Polling Place
    And User click the "OK" button


  @tv_regression_021 @CCRegression @TA
  Scenario: Add Address Point
    Given User navigate to "CC_Dev" log in page
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
      | City          | LAS VEGAS   |
    And User click the "Complete" button
    And User click the "Yes" button
    Then User verify the new address point was added successfully

  @tv_regression_022 @CCRegression @Report
  Scenario Outline: Run a Report
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Reports" from "Reports" menu
    Then User verify the "<ReportType>" report was generated
    Examples:
      | ReportType           |
      | Cost Tracking        |
      | Contests in Election |

  @tv_regression_023 @CCRegression @Report
  Scenario Outline: Create and Run Reports from Report Builder in State
    Given User navigate to "CC_Dev" log in page
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

  @tv_regression_024 @CCRegression @Report
  Scenario Outline: Create and Run Reports from Report Builder in County
    Given User navigate to "CC_Dev" log in page
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

  @tv_regression_025 @CCRegression @Voter
  Scenario: Adding a new UOCAVA military overseas registrant
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User click on "Search"
    And User click on "Add New Voter"
    And User fill in the required information fields
      | Field         | Text       |
      | Last Name     | Smith      |
      | First Name    | Sam        |
      | SSN4          | 2596       |
      | Date Of Birth | 01/01/1991 |
      | DL/ID #       | 58963258   |
      | Address       | 100 1120   |
      | City          | GREER      |
      | Zip           | 85927      |
      | County        | Apache     |
    And User click on "UOCAVA" radio button
    And User select "Overseas Military" from "Type"
    And User fill in the required information fields
      | Field                       | Text            |
      | Start Date                  | 07/01/2023      |
      | End Date                    | 01/01/2025      |
      | UOCAVA Ballot Delivery Type | Email           |
      | Email                       | uocava@new.com  |
      | Suppression Level           | No Restrictions |
      | Source of Registration      | Online          |
      | How Registered              | Online          |
      | Place Of Birth              | Eager           |
      | US Citizen                  | Yes             |
    And User click on "Run All Checks" button
    And User click on "Dismiss All" button
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And User click on "Yes" button
    Then the new registrant should be added successfully
    Then the new UOCAVA military overseas registrant should be added successfully

#  @tv_regression_026 @CCRegression @Ballots
#  Scenario: Adding a new UOCAVA military overseas ballots
#    Given User navigate to "CC_Dev" log in page
##    When User enter "Smith Sam" into "Quick Search" field -(UOCAVA Voter' name)
#    And User click on "Ballot Info"
#    And User click on "Create New Ballot"
#    And User select "UOCAVA" from "Ballot Issuance Type"
#    And User select "Sent" from "Ballot Status"
#    And User click on "Submit and Process Now"
#    Then the new Ballot should be added successfully
#
#  @tv_regression_027 @CCRegression @Ballots
#  Scenario: Verify Precinct ID match
#    Given User navigate to "CC_Dev" log in page
#    And User log in as "cc_county" user
#    And User select "Add Registrant" from "Voter Registration"
#    And User fill in the required information fields
#      |  |  |
#      |  |  |
#      |  |  |
#      |  |  |
#
#    And User click on "Search"
#    And User click on "Add New Voter"
#    And User fill in the required information fields
#      |  |  |
#      |  |  |
#      |  |  |
#      |  |  |
#
#    And User select "No Restrictions" from "Suppression level"
#    And User select "Online" from "Source of Registrations"
#    And User select "Online" from "How Registered"
#    And User click on "Run Checks"
#    And User click on "Bypass DMV Check"
#    And User click on "Add Registrant"
#    And User click on "Ballot Info"
#    And User click on "Create New Ballot"
#    And User select "UOCAVA" from "Ballot Issuance Type"
#    And User select "Sent" from "Ballot Status"
#    And User click on "Submit and Process Now"
#    Then verify Precinct ID # matches the Precinct ID on the left
#
#  @tv_regression_028 @CCRegression @Ballots
#  Scenario: UOCAVA ballots - load
#    Given User navigate to "CC_Dev" log in page
#    And User log in as "cc_state" user
#    And User click on "Outbound Ballot Processing"
#    And User click on "Load"
#    And User click on Home page
#    And User click on "Job Queue"
#    And User click on "Process" from "Loaded ballots"
#    And User click on "View List (.csv)" from "Overseas Military" under "Ballots to be sent via Email"
#    Then UOCAVA military overseas ballots should be viewed successfully
#    Then verify UOCAVA military overseas registrant's name is on the list

  @tv_regression_029 @CCRegression @Notice
  Scenario: Create a notice from the Notice Management page
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User click on "County Utilities"
    And User click on "Notice Management"
    And User fills in the required information fields for creating a Notice
      | Field           | Text          | Type     |
      | Name:           | Notice random | input    |
      | Description:    | Test 123      | input    |
      | Can Be Emailed: | Yes           | dropdown |
    And User click on Save button in Notice Management
    When User enter "COW, LEO" into Quick Search field
    And User click on "COW, LEO"
    And User click the "Correspondence" button
    And User click the "Create Email Correspondence" button
    And User verifies dropdown Notice Name has newly created value

  @tv_regression_030 @CCRegression @Notice
  Scenario: Verify unsent Mail Notice display in Notices Queue
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    When User enter "COW, LEO" into Quick Search field
    And User click on "COW, LEO"
    And User click the "Correspondence" button
    #Deleting notice from previous run
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "QA Automation 1" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    Then User verify "QA AUTOMATION 1" was created successfully
    And User navigate to home page
    And User click on Notices Queue
    And User waits 5 seconds for background requests to load
    And user verifies in template "QA Automation 1" the notice displayed in the queue

  @tv_regression_031 @CCRegression @Ballots
  Scenario:Verify Ballot Question Title is displaying correcting
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_county" user
    And User select "Elections" from "Election Management"
    And User select "Sp09" election
    And User select "Ballot Set Up" from "Election Management"
    When User click on County Ballot Question link
#    And User click the "COUNTY BALLOT QUESTIONS" button
#    And User select "County" from "District Type" native dropdown
#    And User select "COUNTY" from "District Name" native dropdown
#    And User select "County" from "Ballot Question Type" native dropdown
#    And User fill in the required information fields
#      | Field                 | Text                  |
#      | Office Sequence No.   | 11                    |
#      | Date Received         | 0                     |
#      | Date Filed            | -1                    |
#      | Ballot Question Title | TEST                  |
#      | Ballot Question Text  | Automation Testing #1 |
#      | Explanatory Statement | Automation Testing #2 |
#    When User click the "Save" button
    Then User verify Ballot Question Title "Tst" matches

  @tv_regression_032 @CCRegression @Ballots
  Scenario: Verify ballot question is displaying correctly when using District type PRECINCT
    Given User navigate to "CC_Dev" log in page
    And User log in as "cc_state" user
    And User select "Elections" from "Election Management"
    And User select "District Type check" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on Statewide Ballot Questions link
    And User click the "STATEWIDE BALLOT QUESTIONS" button
    And User select "PRECINCT" from "District Type" native dropdown
    And User select "1000" from "District Name" native dropdown
    And User select "Initiative" from "Ballot Question Type" native dropdown
    And User fill in the required information fields
      | Field                 | Text       |
      | Office Sequence No.   | 11         |
      | Date Received         | -1         |
      | Date Filed            | 0          |
      | Ballot Question Title | TEST       |
      | Ballot Question Text  | Testing #1 |
      | Explanatory Statement | Testing #2 |
    And User click on "Save"
    Then verify District Name "1000" is displaying correctly
    Then verify District Type "PRE" is displaying correctly
