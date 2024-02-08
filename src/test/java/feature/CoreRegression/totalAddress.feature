Feature: Core Test - Total Address Regression Tests

  @tv_regression_021 @CoreRegression @TA @CoreIND
  Scenario: Add Address Point
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "TotalAddress" from "County Utilities"
    And switch to "TotalAddress™" tab
    And User click the map "Add point" tab
    And zoom in to at least a zoom of level 17
    And select "Select map location"
    And User move the cursor and click on the map
    When User fill in the required information map fields
      | Field         | Text        |
      | Street Number | UNIQUE      |
      | Street Name   | Main UNIQUE |
      | City          | ALPINE      |
    And User click the "Complete" button
    And User click the "Yes" button
    Then User verify the new address point was added successfully

  @tv_regression_40 @CoreRegression @TA @CoreIND
  Scenario: Add Address Point, verify precinct auto assigned
    Given User navigate to "Core_Test" log in page
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
    When User click on "More"
    Then verify the precinct field is populated and not "UNDEFINED"

  @tv_regression_043 @CoreRegression @TA
  Scenario: Add a voter to the newly created Address in TA
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
      | Field                  | Text            |
      | Suppression Level      | No Restrictions |
      | Source of Registration | Online          |
      | How Registered         | Online          |
      | Place Of Birth         | Eager           |
      | US Citizen             | Yes             |
      | Address                | 99 NANCY ST     |
    And User click on "99 NANCY ST CONCHO 86502"
    And User click on "Run All Checks" button
    And User click on "Bypass DMV Check" button
    And User click on Add Registrant button
    And User click on Residential Address map link
    And User click on "View in TotalAddress" button
    And User switch to new window
    When User click on "Registrants" button
    Then User should see the registrants name matches