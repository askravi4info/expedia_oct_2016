@expedia_search
Feature: Expedia Flight Search

  Background:
    Given user is on Expedia Home page
    When user selects the round trip tab under the flight section

##  Imperative
  @regression
  Scenario: Verify the user gets an error message when searching for past date flights
    And user select Columbus, OH airport for the city columbus in the departure field
    And user select Cleveland, OH airport for the city cleveland in the arrival field
    And user searches for past date flights
    And user searches for the available flights
    Then verify the Departing date is in the past. Please enter a valid departing date. message is displayed

#  Declarative
  @smoke @expedia_search
  Scenario: Verify the user gets an error message when searching for past date flight
    When user searches for a past flights
    Then verify the user is warned with a message

    @defect
  Scenario Outline: verify the user gets the available flights for the airport searched
    And user select <dep_airport> airport for the city <dep_city> in the departure field
    And user select <arr_airport> airport for the city <arr_city> in the arrival field
    And user searches for future date flights
    And user searches for the available flights
    Then verify user gets the correct details for the <arr_city>

  Examples:
    | dep_city | arr_city  | dep_airport  | arr_airport   |
    | Columbus | Cleveland | Columbus, OH | Cleveland, OH |
    | Chicago  | Las Vegas | Chicago, IL  | Las Vegas, NV |


#    Inline Table
  @expedia_search_0034
  Scenario: Verify the user gets an error messages when searching for flights with no data
    And user searches for past date flights
    And user searches for the available flights
    Then verify the following error_message is displayed
      | error_message                                                       | date |
      | Departing date is in the past. Please enter a valid departing date. | 4343 |
      | Returning date is in the past. Please enter a valid returning date. | 43   |
      | Please complete the highlighted origin field below.                 | 32   |
      | Please complete the highlighted destination field below.            | 4324 |

  @expedia_search
  Scenario: verify the flight search results are sorted by price
    And user select Columbus, OH airport for the city columbus in the departure field
    And user select Cleveland, OH airport for the city cleveland in the arrival field
    And user searches for future date flights
    And user searches for the available flights
    Then verify the flight search results are sorted by price

  @smoke
  Scenario: Testing the yml functionality
    Then Verify the yml functionality works

  @manual
  Scenario: verify the look and feel of the Expedia Home page
    Then Verify the look and feel of the page is as expected

  @wip
  Scenario: Verify the user gets an error message when searching for past date cars
    When user searches for a past flights and cars
    Then verify the user is warned with a messages
