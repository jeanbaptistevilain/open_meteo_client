require 'rubygems'
gem 'shoulda'
require 'test/unit'
require 'shoulda'
require 'open_meteo_client/open_meteo_response'

class OpenMeteoResponseTest < Test::Unit::TestCase

  JSON_RESPONSE =
      '{' +
          '"doc":"http://api.ometfn.net/0.1/forecast/doc",' +
          '"license":"http://api.ometfn.net/0.1/forecast/license",' +
          '"domain":"eu12",' +
          '"run":"2014051200",' +
          '"grid":{"x":262,"y":126,"x_error":4188,"y_error":5071},' +
          '"ntimes":3,' +
          '"times":[1399852800,1399856400,1399860000],' +
          '"temp":[1.2,1.7,1.6],' +
          '"rh":[88,86,78],' +
          '"low_clouds":[0,0,0],' +
          '"medium_clouds":[0,0,0],' +
          '"high_clouds":[0,14,14],' +
          '"precipitations":[0,0,0],' +
          '"pblh":[0,126,322],' +
          '"pressure":[885.2,884.1,884.2],' +
          '"wind_10m_ground_speed":[3.3,1.5,1.5],' +
          '"wind_10m_ground_dir":[350,6,59],' +
          '"wind_1000m_msl_speed":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],' +
          '"wind_1000m_msl_dir":[270,270,270],' +
          '"wind_2000m_msl_speed":[0,0,0],' +
          '"wind_2000m_msl_dir":[270,270,270],' +
          '"wind_3000m_msl_speed":[0,0,0],' +
          '"wind_3000m_msl_dir":[270,270,270],' +
          '"wind_4000m_msl_speed":[0,0,0],' +
          '"wind_4000m_msl_dir":[270,270,270],' +
          '"status":"200",' +
          '"msg":"",' +
          '"srv":"1.1.1.1"' +
          '}'

  setup do
    @response = OpenMeteoResponse.new([:times, :temp, :low_clouds, :medium_clouds, :high_clouds, :precipitations])
    @response.append_line(JSON_RESPONSE)
  end

  should 'return response as a filtered hash' do
    response_hash = @response.as_hash

    assert_equal [1399852800,1399856400,1399860000], response_hash[:times]
    assert_equal [1.2,1.7,1.6], response_hash[:temp]
    assert_equal [0,0,0], response_hash[:low_clouds]
    assert_equal [0,0,0], response_hash[:medium_clouds]
    assert_equal [0,14,14], response_hash[:high_clouds]
    assert_equal [0,0,0], response_hash[:precipitations]
    assert_nil response_hash[:pressure]
    assert_nil response_hash[:invalid_key]
  end

  should 'return raw json response' do
    assert_equal JSON_RESPONSE, @response.as_raw_json
  end

  should 'return a list of forecasts' do

    forecasts = @response.as_list

    assert_equal 3, forecasts.length
    assert_equal [1399852800,1399856400,1399860000], forecasts.collect {|f| f[:times]}
    assert_equal [1.2,1.7,1.6], forecasts.collect {|f| f[:temp]}
    assert_equal [0,0,0], forecasts.collect {|f| f[:low_clouds]}
    assert_equal [0,0,0], forecasts.collect {|f| f[:medium_clouds]}
    assert_equal [0,14,14], forecasts.collect {|f| f[:high_clouds]}
    assert_equal [0,0,0], forecasts.collect {|f| f[:precipitations]}
  end

end