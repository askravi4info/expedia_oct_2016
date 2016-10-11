require_relative '../modules/utilities'

class ExpediaHomePage

  include PageObject
  include Utilities

  page_url 'www.expedia.com'

  link(:select_flight_tab, :id => 'tab-flight-tab')
  label(:select_round_trip_flight, :id => 'flight-type-roundtrip-label')
  text_field(:departure_airport, :id => 'flight-origin')
  text_field(:arrival_airport, :id => 'flight-destination')
  ul(:flight_results, :class => 'results')
  text_field(:dep_date, :id => 'flight-departing')
  text_field(:arr_date, :id => 'flight-returning')
  button(:search_flights, :id => 'search-button')
  # div(:error_messages, :class => 'alert-message')
  links(:error_messages, :class => 'dateBeforeCurrentDateMessage')


  def set_dep_airport city_name, airport_name
    self.departure_airport = city_name
    departure_airport_element.send_keys :end
    select_correct_airport airport_name
  end

  def set_arr_airport city_name, airport_name
    self.arrival_airport = city_name
    arrival_airport_element.send_keys :end
    select_correct_airport airport_name
  end

  def select_correct_airport airport_name
    flight_results_element.when_present.list_item_elements.each do |airport|
      if airport.text.include? airport_name
        airport.click
        break
      end
    end
  end


  def set_dep_date no_of_days
    date = convert_time no_of_days
    self.dep_date = date
  end

  def set_arr_date no_of_days
    date = convert_time no_of_days
    self.arr_date = date
  end

  def get_error_message
    error_messages_elements.map do |error_msg|
      error_msg.text
    end
  end


  def search_for_flights days
    @data = load_data_using_yml
    # set_dep_airport @data[$Env]['city_name'], @data['QA']['airport_name']
    set_dep_airport 'columbus', 'Columbus, OH'
    set_arr_airport 'cleveland', 'Cleveland, OH '
    set_dep_date days
    set_arr_date days
    search_flights_element.click
  end


  def load_data_using_yml
    @file = YAML.load_file('C:\Documents and Settings\Administrator\Desktop\sep 2016\expedia_po_sep_2016\features\support\test_data.yml')
    # YAML.load_file('../support/test_data.yml')
    p @file.fetch('request')
    p @file['company']
    p @file['QA']['city_name']

    File.open('C:\Documents and Settings\Administrator\Desktop\sep 2016\expedia_po_sep_2016\features\support\test_data.yml', 'w') {|f| f.write(@file.to_yaml)}

    @file['company'] = 'bank'

    p 'after update'
    p @file.fetch('company')

  end

  # def load_data_using_yml
  #   @file = YAML.load_file('C:\Documents and Settings\Administrator\Desktop\sep 2016\expedia_po_sep_2016\features\support\test_data.yml')
  # end


end