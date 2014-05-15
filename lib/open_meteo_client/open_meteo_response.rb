require 'json'

class OpenMeteoResponse

  def initialize(relevant_attributes)
    @json_response = ''
    @relevant_attributes = relevant_attributes
  end

  def append_line(line)
    @json_response += line unless line.nil?
  end

  def as_hash
    complete_hash = JSON.parse @json_response, :symbolize_names => true
    complete_hash.keep_if {|key, value| @relevant_attributes.include?(key)}
  end

  def as_raw_json
    @json_response
  end

  def as_list
    response_hash = as_hash
    forecasts = []

    response_hash.each_pair { |key, value|
      if value.is_a?(Array)
        value.each_with_index do |val, i|
          forecasts[i] ||= {}
          forecasts[i][key] = val
        end
      end
    }

    forecasts
  end

end