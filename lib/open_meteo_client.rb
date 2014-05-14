require 'open_meteo_client/version'
require 'open-uri'

module OpenMeteoClient

  # Configuration defaults
  @config = {
      :base_url => 'http://api.ometfn.net/0.1/forecast',
      :domain => 'eu12',
      :results_type => 'full',
      :results_format => 'json',
      :relevant_attributes => nil
  }

  @valid_config_keys = @config.keys
  @logger = Logger.new(STDOUT)

  # Configure through hash
  def self.configure(opts = {})
    opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  def self.config
    @config
  end

  def forecasts(latitude, longitude)
    response = OpenMeteoResponse.new(@config[:relevant_attributes])
    forecasts_query = "#{@config[:base_url]}/#{@config[:domain]}/#{latitude},#{longitude}/#{@config[:results_type]}.#{@config[:results_format]}"
    @logger.info "Forecasts query : #{forecasts_query}"
    open(forecasts_query) { |f|
        f.each_line {|line| response.append_line(line)}
    }
    response
  end

end
