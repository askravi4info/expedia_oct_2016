Given(/^user is on Expedia Home page$/) do
  visit ExpediaHomePage
end

When(/^user selects the round trip tab under the flight section$/) do
  on(ExpediaHomePage).select_flight_tab
  on(ExpediaHomePage).select_round_trip_flight_element.click
end

And(/^user select (.*)airport for the city (.*) in the (departure|arrival) field$/) do |airport_name, city_name, dep_arr|
  if dep_arr == 'departure'
    on(ExpediaHomePage).set_dep_airport city_name, airport_name
  else
    on(ExpediaHomePage).set_arr_airport city_name, airport_name
  end
end

And(/^user searches for the available flights$/) do
  on(ExpediaHomePage).search_flights_element.click
end

Then(/^verify the ([^"]*) message is displayed$/) do |error_message|
  all_error_messages = on(ExpediaHomePage).get_error_message
  # fail  unless all_error_messages.include? error_message
  # fail "#{all_error_messages} does not include #{message['error_message']}" unless all_error_messages.include? error_message
  expect(all_error_messages).should include error_message
end


And(/^user searches for (past|future) date flights$/) do |future_or_past|
  if future_or_past == 'past'
    on(ExpediaHomePage).set_dep_date -2
    on(ExpediaHomePage).set_arr_date -2
  else
    on(ExpediaHomePage).set_dep_date 5
    on(ExpediaHomePage).set_arr_date 5
  end
end

Then(/^verify user gets the correct details for the (.*)$/) do |arr_city|
  on(ExpediaSearchResultsPage).verify_search_results_are_correct? arr_city
end

Then(/^verify the following error_message is displayed$/) do |table|
  # table is a table.hashes.keys # => [:Please complete the highlighted origin field below.]
  table.hashes.each do |message|
    # p message['error_message']
    # p message['date']

    all_error_messages = on(ExpediaHomePage).get_error_message
    # fail  unless all_error_messages.include? message['error_message']
    # fail "#{all_error_messages} does not include #{message['error_message']}" unless all_error_messages.include? message['error_message']
    expect(all_error_messages).should include message['error_message']
  end
end


When(/^user searches for a past flights$/) do
  # step 'user select Columbus, OH airport for the city columbus in the departure field'
  # step 'user select Cleveland, OH airport for the city cleveland in the arrival field'
  # step 'user searches for past date flights'
  # step 'user searches for the available flights'


  # Steps %Q{
  #   And user select Columbus, OH airport for the city columbus in the departure field
  #   And user select Cleveland, OH airport for the city cleveland in the arrival field
  #   And user searches for past date flights
  #   And user searches for the available flights
  # }

  # on(ExpediaHomePage).set_dep_airport 'columbus', 'Columbus, OH'
  # on(ExpediaHomePage).set_arr_airport 'cleveland', 'Cleveland, OH '
  # on(ExpediaHomePage).set_dep_date -2
  # on(ExpediaHomePage).set_arr_date -2
  # on(ExpediaHomePage).search_flights_element.click


  # on(ExpediaHomePage) do |page|
  #   page.set_dep_airport 'columbus', 'Columbus, OH'
  #   page.set_arr_airport 'cleveland', 'Cleveland, OH '
  #   page.set_dep_date -2
  #   page.set_arr_date -2
  #   page.search_flights_element.click
  # end

  on(ExpediaHomePage).search_for_flights -2

end


Then(/^verify the user is warned with a message$/) do
  all_error_messages = on(ExpediaHomePage).get_error_message
  expect(all_error_messages).should include 'Departing date is in the past. Please enter a valid departing date...'
end

Then(/^verify the flight search results are sorted by price$/) do
  actual_prices = on(ExpediaSearchResultsPage).get_flight_prices
  expected_prices = actual_prices.sort
  # expect(actual_prices).should eq expected_prices
  fail "#{expected_prices} is NOT same as #{actual_prices}" unless expected_prices == actual_prices
end

Then(/^Verify the yml functionality works$/) do
  on(ExpediaHomePage).load_data_using_yml
end
