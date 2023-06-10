class Weather
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @current_weather = data[:current_weather]
    @daily_weather = data[:daily_weather]
    @hourly_weather = data[:hourly_weather]
  end
end