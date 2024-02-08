Feature: Core Test Regression Tests


#  Background:
#    Given User navigate to log in page

  @tv_regression_001 @CTRegression @Election
  Scenario: Adding a new election in State
    Given User navigate to "CT_DEV" log in page
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
    When User save the selection
    Then the new election should be created successfully

  @tv_regression_002 @CTRegression @Election
  Scenario: Adding a contest to a new election in State
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_state" user
    And User select "Elections" from "Election Management"
    And User select "State QA1" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                                   | Type     |
      | District Type          | Statewide                              | dropdown |
      | Office                 | SW - Automation Test Office - 6/6/2024 | dropdown |
      | Ballot Title           | SW - Automation Test Office            | input    |
      | Term Type              | Regular                                | dropdown |
      | Biography Word Limit   | 100                                    | input    |
      | Filing Fee Cost        | 1377.00                                | input    |
      | Additional Requirement | Automation Test 1                      | input    |
      | Notes                  | Automation Test 2                      | input    |
      | Statement Word Limit   | 200                                    | input    |
    And User set a valid Filing Start and Filing End
    When User click on "Add"
    Then the new race should be added to the election successfully

  @tv_regression_003 @CTRegression @Election @Candidate
  Scenario: Adding a candidate to a race in a new election in State
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_state" user
    And User select "Elections" from "Election Management"
    And User select "State QA2" election
    And User select "Ballot Set Up" from "Election Management"
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

  @tv_regression_004 @CTRegression @Election
  Scenario: Adding a new election in Town
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User generate and use election abbreviation
    And User fills in the required information fields for creating election related functions
      | Field          | Text      | Type     |
      | Jurisdiction:  | Andover   | dropdown |
      | Election Type: | MUNICIPAL | dropdown |
    And User enters Description "Town randomtext" for Election
    And User set a valid election date
    And User click the "Save" button
    Then the new election should be created successfully

  @tv_regression_005 @CTRegression @Election
  Scenario: Adding a contest to a new election in Town
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "County QA1A" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on "Add Contest"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text                         | Type     |
      | District Type          | Town                         | dropdown |
      | District               | Andover                      | dropdown |
      | Office                 | TWN - Automation Test Office | dropdown |
      | Ballot Title           | TWN - Automation Test Office | input    |
      | Term Type              | Regular                      | dropdown |
      | Filing Start           | 09/01/2024                   | input    |
      | Filing End             | 9/30/2024                    | input    |
      | Biography Word Limit   | 100                          | input    |
      | Filing Fee Cost        | 1377.00                      | input    |
      | Additional Requirement | Automation Test 1            | input    |
      | Notes                  | Automation Test 2            | input    |
      | Statement Word Limit   | 200                          | input    |
    And User click on "Add"
    Then the new race should be added to the election successfully

  @tv_regression_006 @CTRegression @Election @Candidate
  Scenario: Adding a candidate to a race in a new election in Town
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "County QA2" election
    And User select "Ballot Set Up" from "Election Management"
    And User click the plus button to add candidate
    And User click the "Add Candidate" button
    And User gets the current count of candidates
    And User expands Candidate Details Tab
    And User fill in the required information fields
      | Field          | Text                     | Type     |
      | Ballot Order   | 01                       | input    |
      | Ballot Name    | SW - Attorney General 02 | input    |
      | Party          | Green                    | dropdown |
      | Candidate Type | Town Filed               | dropdown |
      | First Name     | Larry                    | input    |
      | Last Name      | Bird                     | input    |
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully

  @tv_regression_007 @CTRegression @Election
  Scenario: Checking for duplicate Election Abbreviation
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User validate the "Election" is loaded
    And User click on "Add Election"
    And User fills in the required information fields for creating election related functions
      | Field                  | Text      | Type     |
      | Election Type:         | MUNICIPAL | dropdown |
      | Election Abbreviation: | Town QA1  | input    |
    And User enters Description "Town randomtext" for Election
    And User set a valid election date
    When User click the "Save" button
    Then the "Election Abbreviation already exists" message should be populated successfully

  @tv_regression_008 @CTRegression @Ballots
  Scenario: Create Ballot Question and Create ballot styles in Town
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "Automation Ballots 01" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on Town Ballot Question tab
    And User click the "TOWN BALLOT QUESTION" button
    And User select "Precinct" from "District Type" native dropdown
    And User select "001.00.1" from "District Name" native dropdown
    And User select "Local" from "Ballot Question Type" native dropdown
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

  @tv_regression_009 @CTRegression @Voter
  Scenario: Adding a new registrant (Minimum information)
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User fill in the required information fields
      | Field      | Text       |
      | Last Name  | Roberts    |
      | First Name | Nicole     |
      | SSN4       | 3692       |
      | DOB        | 01/05/1987 |
      | DL/ID #    | 974245678  |
    And User click on "Search"
    And User click on "Add New" button
    And User fill in the required information fields
      | Field                  | Text     |
      | US Citizen             | Yes      |
      | Address                | 100 1120 |
      | City                   | GREER    |
      | Zip                    | 85927    |
      | Town                   | Andover  |
      | Source of Registration | Mail     |
      | How Registered         | Mail     |
    And User select "001.00.1" from "Precinct Split"
    And User select "No Restrictions" from "Suppression Level"
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully

  @tv_regression_010 @CTRegression @Voter
  Scenario: Adding a new registrant (Maximum information)
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User fill in the required information fields
      | Field      | Text       |
      | Last Name  | Jones      |
      | First Name | Layla      |
      | SSN4       | 6547       |
      | DOB        | 03/12/1989 |
      | DL/ID #    | 974258903  |
    And User click on "Search"
    And User click on "Add New" button
    And User fill in the required information fields
      | Field       | Text     |
      | US Citizen  | Yes      |
      | Middle Name | Daniel   |
      | Address     | 100 1120 |
      | City        | GREER    |
      | Zip         | 85927    |
      | Town        | Andover  |
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
      | Precinct Split           | 001.00.1                                          |
      | Suppression Level        | No Restrictions                                   |
      | Source of Registration   | Mail                                              |
      | How Registered           | Mail                                              |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    Then the new registrant should be added successfully

  @tv_regression_011 @CTRegression @Voter @Candidate
  Scenario: Add the voter as a candidate on a ballot
#  Prerequisites: created a new or existed Voter
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "Automation Ballots 03" election
    When User enter "CARNEY, DANNY H" into Quick Search field
    And User click on "CARNEY, DANNY H"
    And User click on "Add to Contest"
    And User fills in the required information fields for creating election related functions
      | Field            | Text                         | Type     |
      | Select a Contest | TWN - Automation Test Office | dropdown |
    And User click on "Continue"
    And User switch to new window
    And User gets the current count of candidates
    And User fills in the required information fields for creating a new candidate
      | Field          | Text                     | Type     |
      | Ballot Order   | 01                       | input    |
      | Ballot Name    | SW - Attorney General 02 | input    |
      | Party          | Green                    | dropdown |
      | Candidate Type | Town Filed             | dropdown |
    And User click the " Save" button
    Then User verify new candidate was added to the race successfully

  @tv_regression_012 @CTRegression @Voter
  Scenario: Update Mailing Address of a Voter
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "Voter Election 1" election
    When User enter "CARNEY, DANNY H" into Quick Search field
    And User click on "CARNEY, DANNY H"
    And User updates Mailng Address
    And User click on "Run All Checks"
    And User click the "Update Registrant" button
    Then User verify Address fields were updated successfully

  @tv_regression_013 @CTRegression @Voter
  Scenario: Search for Voters
    Given User navigate to "CT_DEV" log in page
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

  @tv_regression_014 @CTRegression @Voter
  Scenario: Create Mail Correspondence
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    When User enter "ROBERTS, AMANDA" into Quick Search field
    And User click on "ROBERTS, AMANDA"
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "QA Automation 1" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    Then User verify "QA AUTOMATION 1" was created successfully
    Then User click on "View Notice to be Sent"
    Then User click the "Close" button

  @tv_regression_015 @CTRegression @Voter
  Scenario: Create Email Correspondence
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    When User enter "DANIELS, AVA" into Quick Search field
    And User click on "DANIELS, AVA"
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Email Correspondence" button
    And User select "QA Automation 2" from Notice Name dropdown and enter "Test 2" in Notes
    And User click the "OK" button
    Then User verify "EMAIL CORRESPONDENCE" was created successfully

  @tv_regression_016 @CTRegression @Voter
  Scenario: Scan Forms in Attachments tab
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    When User enter "CLASS, MICHAEL" into Quick Search field
    And User click on "CLASS, MICHAEL"
    And User click on "Attachments"
    And User click the "Scan" button
    And User select "Absentee Request Form" from Form Type dropdown
    And User click the "Scan Image" button
    And User click on "OK"
    And User click the "Process" button
    And User click on "OK"
    Then User verify "Absentee Request Form" form was created successfully

  @tv_regression_017 @CTRegression @Notice
  Scenario: Verify unsent Mail Notice display in Notices Queue
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    When User enter "DAVID, PETE" into Quick Search field
    And User click on "DAVID, PETE"
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


  @tv_regression_018 @CTRegression @PollingPlace
  Scenario: Create a new Polling Place
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User click on "Add New Polling Place"
    And User select "Fire Department" from "Building Type"
    And User fill in the required information fields
      | Field         | Text              |
      | Location Name | Location ABC      |
      | Address       | 17 Town Road 2067 |
      | City          | Alpine            |
      | Zip           | 85920             |
      | State         | CT                |
      | Town          | Andover           |
    And User select following checkboxes
      | Early Voting        |
      | Polling Place       |
      | Firearms Prohibited |
    And User click on "Save" button
    And User click on "OK"
    #And User verify new Polling Place was created successfully

  @tv_regression_019 @CTRegression @PollingPlace
  Scenario: Assign Polling Place Location to an Election
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
    And User select "2023  - 07/05/2024" from "Election"
    And User select the "Location ABC" checkbox in Polling Place
    And User click on "Save Changes"
    Then the new polling place should be added to the election successfully

  @tv_regression_020 @CTRegression @PollingPlace
  Scenario: Assign and Edit Polling Place Location
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
      #Assign Polling Place Location to an election
    And User selects "2023 General - 02/04/2024" from election dropdown in Polling Place
    And User check off "0Location 1 Automation" checkbox from list
    And User click on "Save Changes" button
    And User click on "OK" button
      #Now we will make the Polling Place Location we assigned to Inactive status
    And User click on "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User enters "0Location 1 Automation" search for Polling Place
    And User click on Edit button for Polling Place
    And User select "Inactive" from Edit Polling Place dropdown
    And User click on Save button in Polling Place
    And User click the "OK" button
      #Now we verify Polling Place Location is no longer displayed in the list since status is Inactive
    And User click on "Election Management"
    And User click on "Assign to Election"
    And User selects "2023 General - 02/04/2024" from election dropdown in Polling Place
    And User verify Polling Place Location is no longer part of the list of checkboxes
      #Now we will update the Polling Place used back to Active status for next run
    And User click on "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User select "Inactive" from "Active"
    And User enters "0Location 1 Automation" search for Polling Place
    And User click on Edit button for Polling Place
    And User select "Active" from Edit Polling Place dropdown
    And User click on Save button in Polling Place
    And User click the "OK" button


  @tv_regression_021 @CTRegression @TA
  Scenario: Add Address Point
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "TotalAddress" from "Town Utilities"
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

  @tv_regression_022 @CTRegression @Report
  Scenario Outline: Run a Report
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Reports" from "Reports" menu
    Then User verify the "<ReportType>" report was generated
    Examples:
      | ReportType           |
      | Cost Tracking        |
      | Contests in Election |

  @tv_regression_023 @CTRegression @Report
  Scenario Outline: Create and Run Reports from Report Builder in State
    Given User navigate to "CT_DEV" log in page
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

  @tv_regression_024 @CTRegression @Report
  Scenario Outline: Create and Run Reports from Report Builder in Town
    Given User navigate to "CT_DEV" log in page
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

  @tv_regression_025 @CTRegression @Voter
  Scenario: Adding a new UOCAVA military overseas registrant
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User click on "Search"
    And User click on "Add New Voter"
    And User fill in the required information fields
      | Field         | Text       |
      | Last Name     | Smith      |
      | First Name    | Sam        |
      | SSN4          | 2596       |
      | Date Of Birth | 01/01/1991 |
      | DL/ID #       | 589632580  |
      | Address       | 100 1120   |
      | City          | GREER      |
      | Zip           | 85927      |
      | Town          | Andover    |
    And User click on "UOCAVA" radio button
    And User select "Overseas Military" from "Type"
    And User fill in the required information fields
      | Field                       | Text            |
      | Start Date                  | 07/01/2023      |
      | End Date                    | 01/01/2025      |
      | UOCAVA Ballot Delivery Type | Email           |
      | Email                       | uocava@new.com  |
      | Suppression Level           | No Restrictions |
      | Source of Registration      | Mail            |
      | How Registered              | Mail            |
      | US Citizen                  | Yes             |
    And User click on "Run All Checks" button
    And User click on "Dismiss All" button
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And User click on "Yes" button
    Then the new registrant should be added successfully
    Then the new UOCAVA military overseas registrant should be added successfully

  @tv_regression_026 @Voter
  Scenario: Adding a new UOCAVA military overseas ballots
    Given User navigate to "CT_DEV" log in page
#    When User enter "Smith Sam" into "Quick Search" field -(UOCAVA Voter' name)
    And User click on "Ballot Info"
    And User click on "Create New Ballot"
    And User select "UOCAVA" from "Ballot Issuance Type"
    And User select "Sent" from "Ballot Status"
    And User click on "Submit and Process Now"
    Then the new Ballot should be added successfully

  @tv_regression_027 @Voter
  Scenario: Verify Precinct ID match
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User fill in the required information fields
      |  |  |
      |  |  |
      |  |  |
      |  |  |

    And User click on "Search"
    And User click on "Add New Voter"
    And User fill in the required information fields
      |  |  |
      |  |  |
      |  |  |
      |  |  |

    And User select "No Restrictions" from "Suppression level"
    And User select "Online" from "Source of Registrations"
    And User select "Online" from "How Registered"
    And User click on "Run Checks"
    And User click on "Bypass DMV Check"
    And User click on "Add Registrant"
    And User click on "Ballot Info"
    And User click on "Create New Ballot"
    And User select "UOCAVA" from "Ballot Issuance Type"
    And User select "Sent" from "Ballot Status"
    And User click on "Submit and Process Now"
    Then verify Precinct ID # matches the Precinct ID on the left

  @tv_regression_028 @Ballots
  Scenario: UOCAVA ballots - load
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_state" user
    And User click on "Outbound Ballot Processing"
    And User click on "Load"
    And User click on Home page
    And User click on "Job Queue"
    And User click on "Process" from "Loaded ballots"
    And User click on "View List (.csv)" from "Overseas Military" under "Ballots to be sent via Email"
    Then UOCAVA military overseas ballots should be viewed successfully
    Then verify UOCAVA military overseas registrant's name is on the list

  @tv_regression_029 @CTRegression @Notice
  Scenario: Create a notice from the Notice Management page
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User click on "Town Utilities"
    And User click on "Notice Management"
    And User fills in the required information fields for creating a Notice
      | Field           | Text          | Type     |
      | Name:           | Notice random | input    |
      | Description:    | Test 123      | input    |
      | Can Be Emailed: | Yes           | dropdown |
    And User click on Save button in Notice Management
    When User enter "DOE, JOHN" into Quick Search field
    And User click on "DOE, JOHN"
    And User click the "Correspondence" button
    And User click the "Create Email Correspondence" button
    And User verifies dropdown Notice Name has newly created value

  @tv_regression_030 @CTRegression @Candidate
  Scenario: Scanning Candidate Forms in Ballot Setup
#  Prerequisites: Election, Contest, Candidate
    Given User navigate to "CT_DEV" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "Scan Candidate Forms" election
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
    And User switch to Home window
    And User click the View button in Ballot Setup
    Then User verify a form got scanned successfully