Feature: Core Test Regression Tests


      #NEW SCRIPTS BEG


  @CoreTestNotInMaster
  Scenario: Validations in Pre Add Registrant page
    #Case1: Fill in Last name and First name: enter less than 4 digits in field for SSN Expected: Displays No Results Found popup and click on Close button
    #Case2: leave on at a time
    #case3: enter invalid data and click search
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"

    And User creates unique data for a Registrant
      | Field      | Text       |
      | Last Name  | random     |
      | First Name | random     |
      | SSN4       | 555        |
      | DOB        | 05/01/1987 |
      #| DL/ID #    | random     |
    And User click on "Search"
    And Displays message SSN required four digits
    #And User click on "Add New Voter"

    @CoreTestNotInMaster
  Scenario: Validations in Add Registrant page
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user






      #NEW SCRIPTS END

  #Updates to EXISTING SCRIPTS BEG
  #REDONE to include less steps and more validations BEG
  @notinMaster @CoreTestNotInMaster @Ballots
  Scenario: Verify Ballot Question is displaying District Type and District Name correctly
    Given User navigate to "Core_Test" log in page
    And User log in as "core_state" user
    And User select "Elections" from "Election Management"
    And User select "District Type check" election
    And User select "Ballot Set Up" from "Election Management"
    And User click on Statewide Ballot Question link
    ###NEW STEP IS TO DELETE
    And User deletes any existing Ballot Questions
    And User click the ADD NEW STATEWIDE BALLOT QUESTION link
    And User fill in the required information fields
      | Field                 | Text       |
      | Office Sequence No.   | 11         |
      | Date Received         | -1         |
      | Date Filed            | 0          |
      | Ballot Question Title | TEST       |
      | Ballot Question Text  | Testing #1 |
      | Explanatory Statement | Testing #2 |
    And User click on "Save"
    Then verify District Name "CONGRESSIONAL DISTRICT 1" is displaying correctly
    Then verify District Type "CGX" is displaying correctly

  @notinMaster @CoreTestNotInMaster @Voter
  Scenario: Change Status/Status Reason
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "DAVID, PETE" into Quick Search field
    And User click on "DAVID, PETE"
    And User click on "Update"
        ###NEW STEP IS TO VALIDATE Status
    And User verifies and updates Voter Status to Active

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


  @notinMaster @CoreRegression @Voter
  Scenario: Turn Cancelled Voter to Active NEW
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "10122774" into Barcode or Registration ID field
    #
    And User verifies and updates Voter Status to Canceled
    And User select following data from dropdown
      | Field                      | Text          |
      | Registration Status        | ACTIVE        |
      | Registration Status Reason | VOTER REQUEST |
    And User click on "Run All Checks" button
    And User click on "Update Registrant"
    Then User validates the Registration Status is set to "ACTIVE"
    Then User validates the Registration Status Reason is set to "VOTER REQUEST"
  ##########################################################################################################



    #Below is not in MASTER or NO PR was created
  @CoreRegression @INDD
  Scenario: Verify you can search for Pending and Active Voter in Quick Search
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User creates unique data for a Registrant
      | Field | Text |
      | Last Name | random |
      | First Name | random |
      | SSN4 | random |
      | DOB | 05/01/1987 |
      | DL/ID # | random |
    And User click on "Add New"
    And User fill in the required information fields
      | Field | Text |
      | US Citizen | Yes |
      | Address | 123 MAIN STREET |
    And User click on "123 MAIN STREET ALPINE 86502"
    And User select following data from dropdown
      | Field | Text |
      | Suppression Level | No Restrictions |
      | Source of Registration | Online |
      | How Registered | Electronic |
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And User captures the Voters Full Name
    And User click on "Update"
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | CANCELED              |
      | Registration Status Reason | FELONY                |
    And User click the "Update Registrant" button
    Then User validates the Registration Status is set to "CANCELED"
    Then User validates the Registration Status Reason is set to "FELONY"
    And User navigate to home page
    Then User verify you can search for the Voter in QuickSearch
    Then User validates the Registration Status is set to "CANCELED"
    Then User validates the Registration Status Reason is set to "FELONY"



  @CoreRegression
  Scenario: Verify you can search for Active and Pending Voter in Quick Search
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "PVQMCA, DZPIEX" into Quick Search field
    And User click on "PVQMCA, DZPIEX"
    Then User validates the Registration Status is set to "ACTIVE"
    Then User validates the Registration Status Reason is set to "ACTIVE"
    And User captures the Voters Full Name
    And User navigate to home page
    Then User verify you can search for the Voter in QuickSearch
    And User click on "Update"
    And User enter "Test Note" into Note field
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | PENDING              |
      | Registration Status Reason | ACTIVE                |
    And User click the "Update Registrant" button
    Then User validates the Registration Status is set to "PENDING"
    Then User validates the Registration Status Reason is set to "ACTIVE"
    And User navigate to home page
    Then User verify you can search for the Voter in QuickSearch
    Then User validates the Registration Status is set to "PENDING"
    Then User validates the Registration Status Reason is set to "ACTIVE"



  @CoreRegression
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
    Then the new registrant should be added successfully
    And User captures the Voters Full Name
    And User click on "Update"
    And User select following data from dropdown
      | Field                      | Text                  |
      | Change Type                | Administrative Update |
      | Registration Status        | CANCELED              |
      | Registration Status Reason | FELONY                |
    And User click the "Update Registrant" button
    Then User validates the Registration Status is set to "CANCELED"
    Then User validates the Registration Status Reason is set to "FELONY"
    And User navigate to home page
    Then User verify you are unable to search for Cancelled Voter in QuickSearch



  Scenario: Verify you TS
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "AAADDD, CCCDDD" into Quick Search field
    And User click on "AAADDD, CCCDDD"
    And User captures the Voters Full Name
    And User navigate to home page
    Then User verify you can search for the Voter in QuickSearch


  Scenario: Verify you can search for Voters in Quick Search in Active Status
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "Charles, Active" into Quick Search field
    And User click on "Charles, Active"

  Scenario: Verify you are unable to search for Voters in Quick Search in Cancelled Status
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "Charles, Cancelled" into Quick Search field
    And User click on "Charles, Cancelled"


  Scenario: Verify you can search for Voters in Advanced Search in Pending Status
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "Charles, Pending" into Quick Search field
    And User click on "Charles, Pending"


  Scenario: Verify you can search for Voters in Advanced Search in Active Status
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "Charles, Active" into Quick Search field
    And User click on "Charles, Active"

  Scenario: Verify you are unable to search for Voters in Advanced Search in Cancelled Status2
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "Charles, Cancelled" into Quick Search field
    And User click on "Charles, Cancelled"

  Scenario: Create Offices for a District
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Office/Incumbent Management" from "Election Management"
    And User select following data from dropdown
      | Field                | Text       |
      | Select District Type | COUNTYWIDE |
    And User click the "Load Offices" button
    And User click on "Add Office"
    And User select following data from dropdown
      | Field                | Text       |
      | Filing District Type | COUNTYWIDE |
      | Salary Type          | Annual     |
    And User input following data
      | Office     | Auto Office 1 |
      | Term       | 01            |
      | Filing Fee | 100           |
      | Vote For   | 01            |
      | Salary     | 02            |
    And User select following checkboxes
      | Is Active |
    And User click the "Save" button

  @35 @TA
  Scenario: Verify Map Display Options
    Given User navigate to "NV_Dev" log in page
    And User log in as "core_county" user
    And User select "TotalAddress" from "County Utilities"
    And User switch to new window
    And user validates "Map Imagery" is displaying with toggle "OFF"
    And user clicks toggle button in TA for "Map Imagery"
    And user validates "Map Imagery" is displaying with toggle "ON"
    And user validates "County Boundary" is displaying with toggle "OFF"
    And user clicks toggle button in TA for "County Boundary"
    And user validates "County Boundary" is displaying with toggle "ON"
    And user validates "City Boundary" is displaying with toggle "OFF"
    And user validates "Precinct Boundary" is displaying with toggle "OFF"
    And user validates "Zip Code Boundary" is displaying with toggle "OFF"


  @tv_regression_033 @CoreRegression @Voter
  Scenario: Change Status/Status Reason verify FLAG
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "CFTFGX, NEDXLJ" into Quick Search field
    And User click on "CFTFGX, NEDXLJ"
    Then User validates Voter has the Flags is set to "UOCAVA: Overseas Military Delivery Type: Email ID Required HAVA ID Required"
    Then User validates Voter has the Incomplete Reasons is set to "No signature Name Change"

  @tv_regression_033 @CoreRegression @Voter
  Scenario: Change Status/Status Reason verify FLAG2
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    When User enter "CFTFGX, NEDXLJ" into Quick Search field
    And User click on "CFTFGX, NEDXLJ"
    #Has to have full text of Flads
    Then User validates Voter has the Flags is set to "UOCAVA: Overseas Military"
    Then User validates Voter has the Incomplete Reasons is set to "No signature"



  @tv_regression_034 @CoreRegression @Voter
  Scenario: verify Secure VOTER in dropdown and able to search for it
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    #Add step to verify dropdown options




  @tv_regression_034 @VerifyDROPDOWNVALUES @Voter
  Scenario: Verify dropdown values
    Given User navigate to "NV_Dev" log in page
    And User log in as "core_county" user
    And User select "Add Registrant" from "Voter Registration"
    And User select following data from dropdown
      | Field                    | Text               |
      | Source of Registration   | NOVA             |
    And User verifies the dropdrop values in How Registered


    And User select following data from dropdown
      | How Registered           | Electronic         |





