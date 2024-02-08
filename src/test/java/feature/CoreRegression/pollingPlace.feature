Feature: Core Test - Polling Place Regression Tests

  @tv_regression_018 @CoreRegression @PollingPlace
  Scenario: Create a new Polling Place
    Given User navigate to "Core_Test" log in page
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
    When User select following checkboxes
      | Early Voting        |
      | Polling Place       |
      | Firearms Prohibited |
    And User click on "Save" button
    And User click on "OK"
    Then User verify new Polling Place was created successfully

  @tv_regression_019 @CoreRegression @PollingPlace
  Scenario: Assign Polling Place Location to an Election
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
    And User selects any Election from dropdown menu in Polling Place
    And User select the "0 Green House" checkbox in Polling Place
    When User click on "Save Changes"
    Then the new polling place should be added to the election successfully

  @tv_regression_020 @CoreRegression @PollingPlace
  Scenario: Assign Polling Place and verify you are unable to make it Inactive if assigned to an Election
    Given User navigate to "Core_Test" log in page
    And User log in as "core_county" user
    And User select "Polling Locations" from "Election Management"
    And User click on "Assign to Election"
    And User selects any Election from dropdown menu in Polling Place
    And User check off "0Location 1 Automation" checkbox from list
    And User click on "Save Changes" button
    And User click on "OK" button
    And User verify Polling Place Location is part of the list and checked off
    And User click on "Election Management"
    And User click on "Add/Edit Polling Locations"
    And User enters "0Location 1 Automation" search for Polling Place
    And User click on Edit button for Polling Place
    And User select "Inactive" from Edit Polling Place dropdown
    When User click on Save button in Polling Place
    Then User verifies you are unable to make Polling Place Inactive if used in an Election