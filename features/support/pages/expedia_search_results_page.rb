class ExpediaSearchResultsPage
  include PageObject

  span(:search_results_header, :class => 'title-city-text')
  spans(:price, :class => 'dollars price-emphasis')
  # div(:search_filter, :id => 'filterContainer')
  div(:progress_bar, :class => 'progress-bar')


  def verify_search_results_are_correct? city_name
    fail "#{city_name} is not found in the search results" unless search_results_header_element.text.eql? "Select your departure to #{city_name.capitalize}"
  end

  def wait_until_search_results_are_loaded
    wait_until(30) {
      # p progress_bar_element.div_element.element.attribute_value('style')
      progress_bar_element.div_element.element.attribute_value('style').include? 'width: 100%;'
    }
  end

  def get_flight_prices
    wait_until_search_results_are_loaded

    price_elements.map do |price_value|
      (price_value.text).gsub('$', '').gsub(',', '').to_i
      # p (price_value.text).gsub('$','').gsub(',','').to_i
    end

    # actual_sort = price_elements.map(&:text)

  end


end