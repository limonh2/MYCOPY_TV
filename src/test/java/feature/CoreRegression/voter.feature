Feature: Core Test - Voter Regression Tests

  @tv_regression_003 @CoreRegression @Voter
  Scenario: Verify information in an existing Registrant
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "DAVID, PETE" into Quick Search field
    Then User verifies all Registration information
      | Source Of Registration | ONLINE                  |
      | Eligibility Date       | 10/20/2023              |
      | Application Date       | 08/29/2023              |
      | How Registered         | ELECTRONIC              |
      | Precinct Split         | 02.3 SD 07 HTD 05 FD 02 |
      | Language Preference    | ENGLISH                 |
    And User verifies all Voter information
      | DL/ID #                     | 2342344             |
      | Email                       | TESTJ@GMAIL.COM     |
      | SSN4                        | 2342                |
      | DOB                         | 01/01/2003 (Age 21) |
      | Phone                       | (234) 234-2342      |
      | Citizenship Verified        | YES                 |
      | Communication Email Opt-Out | NO                  |
      | Communication SMS Opt-Out   | NO                  |
      | Mail Ballot Address         | N/A                 |

  @tv_regression_005 @CoreRegression @Voter @CoreIND
  Scenario: Verify you can search for Pending and Active Voter in Quick Search
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | random     |
      | DOB        | 05/01/1987 |
      | DL/ID #    | random     |
    And User click on "Add New"
    And User fill in the required information fields
      | Field      | Text            |
      | US Citizen | Yes             |
      | Address    | 123 MAIN STREET |
    And User click on "123 MAIN STREET ALPINE 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And User validates the Registration Status is set to "ACTIVE"
    And User validates the Registration Status Reason is set to "ACTIVE"
    And User navigate to home page
    And User verify you can search for the Voter in QuickSearch
    And User validates the Registration Status is set to "ACTIVE"
    And User validates the Registration Status Reason is set to "ACTIVE"
    And User click on "Update"
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | PENDING               |
      | Registration Status Reason | FELONY                |
    And User click the "Update Registrant" button
    And User validates the Registration Status is set to "PENDING"
    And User validates the Registration Status Reason is set to "FELONY"
    When User navigate to home page
    And User verify you can search for the Voter in QuickSearch
    And User validates the Registration Status is set to "PENDING"
    Then User validates the Registration Status Reason is set to "FELONY"

  @tv_regression_006 @CoreRegression @Voter @CoreIND
  Scenario: Verify you can are unable to search for Cancelled Voter in Quick Search
    Given User navigate to "Core_Test" log in page
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
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Place Of Birth | Eager       |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And the new registrant should be added successfully
    When User click on "Update"
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | CANCELED              |
      | Registration Status Reason | FELONY                |
    And User click the "Update Registrant" button
    And User validates the Registration Status is set to "CANCELED"
    And User validates the Registration Status Reason is set to "FELONY"
    And User navigate to home page
    Then User verify you are unable to search for Voter in QuickSearch

  @tv_regression_009 @CoreRegression @Voter @CoreIND
  Scenario: Adding a new registrant (Minimum information)
    Given User navigate to "Core_Test" log in page
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
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Place Of Birth | Eager       |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    When User click on Add Registrant button
    Then the new registrant should be added successfully

  @tv_regression_010 @CoreRegression @Voter @CoreIND
  Scenario: Adding a new registrant (Maximum information)
    Given User navigate to "Core_Test" log in page
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
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Middle Name    | Dennis      |
      | Place Of Birth | Eager       |
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
    When User click on Add Registrant button
    Then the new registrant should be added successfully

  @tv_regression_011 @CoreRegression @Voter @Candidate
  Scenario: Add the voter as a candidate on a ballot
#  Prerequisites: created a new or existed Voter
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Elections" from "Election Management"
    And User select "Automation Ballots 03" election
    And User enter "CARNEY, DANNY H" into Quick Search field
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
    When User click the " Save" button
    Then User verify new candidate was added to the race successfully

  @tv_regression_012 @CoreRegression @Voter @CoreIND
  Scenario: Update Mailing Address of a Voter
    Given User navigate to "Core_Test" log in page
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
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Place Of Birth | Eager       |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And the new registrant should be added successfully
    And User updates Mailing Address
    And User click on "Run All Checks"
    And User click on "Bypass DMV Check" button
    And User click the "Update Registrant" button
    When User click on "Yes" button
    Then User verify Address fields were updated successfully

  @tv_regression_013 @CoreRegression @Voter
  Scenario: Search for Voters
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Advanced Search" from "Reports"
    And User fill in the required information fields
      | Field      | Text |
      | First Name | John |
      | Last Name  | Doe  |
    When User click the "Search" button
    Then User verify search results
      | Key       | Value |
      | FirstName | John  |
      | LastName  | Doe   |

  @tv_regression_014 @CoreRegression @Voter @CoreIND
  Scenario: Create Mail Correspondence
    Given User navigate to "Core_Test" log in page
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
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Place Of Birth | Eager       |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And the new registrant should be added successfully
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Mail Correspondence" button
    And User select "QA Automation 1" from Notice Name dropdown and enter "Test 1" in Notes
    And User click the "OK" button
    Then User verify "QA AUTOMATION 1" was created successfully
    And User click on "View Notice to be Sent"
    And User click the "Close" button
    #Assertion to be added

  @tv_regression_015 @CoreRegression @Voter
  Scenario: Create Email Correspondence
    Given User navigate to "Core_Test" log in page
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
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Place Of Birth | Eager       |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And the new registrant should be added successfully
    And User click the "Correspondence" button
    And User deletes any existing Correspondences
    And User click the "Create Email Correspondence" button
    And User select "QA Automation 2" from Notice Name dropdown and enter "Test 2" in Notes
    When User click the "OK" button
    Then User verify "EMAIL CORRESPONDENCE" was created successfully

  @tv_regression_016 @CoreRegression @Voter
  Scenario: Scan Forms in Attachments tab
    Given User navigate to "Core_Test" log in page
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
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Place Of Birth | Eager       |
      | Address        | 99 NANCY ST |
    And User click on "99 NANCY ST CONCHO 86502"
    And User select following data from dropdown
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Electronic      |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And the new registrant should be added successfully
    And User click on "Attachments"
    And User select "Online Registration" from Form Type dropdown
    And User click the "Scan" button
    And User click the "Scan Image" button
    And User click the "Process" button
    When User click on "OK"
    Then User verify "Online Registration" form was created successfully

  @tv_regression_025 @CoreRegression @Voter @CoreIND
  Scenario: Adding a new UOCAVA military overseas registrant
    Given User navigate to "Core_Test" log in page
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
      | Field   | Text     |
      | Address | 100 1120 |
      | City    | GREER    |
      | Zip     | 85927    |
      | County  | Apache   |
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
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And User click on "Yes" button
    Then the new registrant should be added successfully
    Then the new UOCAVA military overseas registrant should be added successfully

  @tv_regression_026 @Voter
  Scenario: Adding a new UOCAVA military overseas ballots
    Given User navigate to "Core_Test" log in page
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
    When User get the current count of ballots after
    Then User compares the Before and After Values of the Ballot

#  @tv_regression_027 @Voter @bug @ignore
#  Scenario: Verify Precinct ID match
#    Given User navigate to "Core_Test" log in page
#    And User log in as "core_county" user
#    And User enter "SMITH, SAM_UOCAVA" into Quick Search field
#    And User click on "SMITH, SAM_UOCAVA"
#    And User click on "Ballot Info"
#    And User get the current count of ballots before
#    And User click on "Create New Ballot"
#    And User select "UOCAVA" from "Ballot Issuance Type"
#    And User select "Sent" from "Ballot Status"
#    And User select "Mail - In State" from "Ballot Issuance Method"
#    And User select "Overseas Military" from "UOCAVA Application Type"
#    And User select "Mail" from "Prefers to receive ballots by:"
#    And User click on "Submit and Process Now"
#    And User get the current count of ballots after
#    And User compares the Before and After Values of the Ballot

  @tv_regression_033 @CoreRegression @Voter
  Scenario: Change Status/Status Reason
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "DAVID, PETE" into Quick Search field
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

  @tv_regression_034 @CoreRegression @Voter
  Scenario: Turn Cancelled Voter to Active
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "10122774" into Barcode or Registration ID field
    And User click the "Update" button
    And User select following data from dropdown
      | Field                      | Text          |
      | Registration Status        | ACTIVE        |
      | Registration Status Reason | VOTER REQUEST |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on "Update Registrant" button
    And User validates the Registration Status is set to "ACTIVE"
    And User click the "Update" button
    And User select following data from dropdown
      | Field                      | Text     |
      | Registration Status        | CANCELED |
      | Registration Status Reason | FELONY   |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    When User click on "Update Registrant" button
    Then User validates the Registration Status is set to "CANCELED"

  @tv_regression_036 @CoreRegression @Voter @bug @ignore
  Scenario: Verify you can click on Edit button on a Ballot without getting any reload errors
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "FELDON, BARBARA" into Quick Search field
    And User click on "Ballot Info"
    And User clicks on Edit button on a Ballot
      #Need validations

  @tv_regression_037 @CoreRegression @Voter @CoreIND
  Scenario: Create a Petition
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Petitions" from "County Utilities"
    And User click on "Add Petition" button
    And User select "Initiative to the Legislature" from " Petition Type: "
    And User select "Original Pages" from " Circulation Start Date: "
    When I select the current date for the following date fields:
      | Circulation Start Date |
      | Circulation End Date   |
      | Submitted Date         |
      | Initial Filing Date    |
      | Signatures Filed Date  |
      | Determination Date     |
    And User fill in the required information fields
      | Field           | Text            |
      | Lines Per Page: | 2               |
      | Petition Title: | Automation Test |
    When User click the "Save" button
      #Need validations

  @tv_regression_38 @CoreRegression @Voter @CoreIND
  Scenario: Adding a new registrant (Confidential Voter)
    Given User navigate to "Core_Test" log in page
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
      | Field          | Text        |
      | US Citizen     | Yes         |
      | Place Of Birth | Eager       |
      | Address        | 99 NANCY ST |
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

  @tv_regression_39 @CoreRegression @Voter @bug @ignore
  Scenario: Create District Office
    Given User navigate to "Core_Test" log in page
    And User log in as "core_state" user
    And User select "Districts" from "State Utilities"
    And User select "CONGRESSIONAL" from "District Type"
    And User click the "Create" button
    When User enter "Apache" into Counties field
    And User click the Apache icon button
    #Need validations