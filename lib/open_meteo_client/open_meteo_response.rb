require 'json'
require 'open_meteo_client/forecast'

class OpenMeteoResponse

  DEFAULT_ATTRIBUTES = [:times, :temp, :rh, :low_clouds, :medium_clouds, :high_clouds, :precipitations]

  def initialize(relevant_attributes = DEFAULT_ATTRIBUTES)
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

  def as_forecasts
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