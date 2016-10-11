module Utilities

  def convert_time(no_of_days)
    x = Time.new
    y = x + 60*60*24*no_of_days
    y.strftime("%m/%d/%Y")
  end

end