require 'rails_helper'

RSpec.describe Weather do
  it 'exists and has attributes' do
    weather_data = {
        current_weather: {
          last_updated: '2021-03-07 16:00',
          temperature: 50.0,
          feels_like: 50.0,
          humidity: 50.0,
          uvi: 50.0,
          conditions: 'cloudy',
          icon: 'cloudy.png'
        },
        daily_weather: [
          {
            date: '2021-03-07',
            sunrise: '2021-03-07 06:00',
            sunset: '2021-03-07 18:00',
            max_temp: 50.0,
            min_temp: 50.0,
            conditions: 'cloudy',
            icon: 'cloudy.png'
          },
          {
            date: '2021-03-07',
            sunrise: '2021-03-07 06:00',
            sunset: '2021-03-07 18:00',
            max_temp: 50.0,
            min_temp: 50.0,
            conditions: 'cloudy',
            icon: 'cloudy.png'
          }
        ],
        hourly_weather: [
          {
            time: '16:00',
            temperature: 50.0,
            conditions: 'cloudy',
            icon: 'cloudy.png'
          }
        ]
    }
    denver_weather = Weather.new(weather_data)

    expect(denver_weather).to be_a Weather
    expect(denver_weather.current_weather).to be_a Hash
    expect(denver_weather.current_weather).to have_key :last_updated
    expect(denver_weather.current_weather).to have_key :temperature
    expect(denver_weather.current_weather).to have_key :feels_like
    expect(denver_weather.current_weather).to have_key :humidity
    expect(denver_weather.current_weather).to have_key :uvi
    expect(denver_weather.current_weather).to have_key :conditions
    expect(denver_weather.current_weather).to have_key :icon

    expect(denver_weather.daily_weather).to be_an Array
    expect(denver_weather.daily_weather.count).to eq(2)
    expect(denver_weather.daily_weather.first).to be_a Hash
    expect(denver_weather.daily_weather.first).to have_key :date
    expect(denver_weather.daily_weather.first).to have_key :sunrise
    expect(denver_weather.daily_weather.first).to have_key :sunset
    expect(denver_weather.daily_weather.first).to have_key :max_temp
    expect(denver_weather.daily_weather.first).to have_key :min_temp
    expect(denver_weather.daily_weather.first).to have_key :conditions
    expect(denver_weather.daily_weather.first).to have_key :icon

    expect(denver_weather.hourly_weather).to be_an Array
    expect(denver_weather.hourly_weather.count).to eq(1)
    expect(denver_weather.hourly_weather.first).to be_a Hash
    expect(denver_weather.hourly_weather.first).to have_key :time
    expect(denver_weather.hourly_weather.first).to have_key :temperature
    expect(denver_weather.hourly_weather.first).to have_key :conditions
    expect(denver_weather.hourly_weather.first).to have_key :icon
  end
end