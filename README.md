# Sweater Weather

## About this Project
### Important to Note
This is a Back End Application that exposes 4 endpoints.  3 external API keys are required for this application to function properly. 

### [Sweater Weather](https://www.youtube.com/watch?v=GCdwKhTtNNw)
Never be surprised by weather on your RoadTrip again. 
Sweater Weather is a weather application where a user can see the current weather and forecasted weather of a specific location. 
A registered user can plan a roadtrip and see how long the trip will take and the weather upon arrival to their destination.  
![Sweater-weather-580x386](https://github.com/thawley2/sweater_weather/assets/120520954/217734d7-ccbd-4126-afab-9ae6e5d51a2e)

## Built With
* ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
* ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
* ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
* ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)

## Running On
  - Rails 7.0.4
  - Ruby 3.1.1

## <b>Getting Started</b>

To get a local copy, follow these simple instructions

### <b>Installation</b>

1. Fork the Project
2. Clone the repo 
``` 
#terminal
git clone git@github.com:thawley2/sweater_weather.git 
```
3. Navigate to the newly cloned repo and open it in your text editor of choice
4. Install the gems
```
#terminal
bundle install
```
5. Create the database
```
#terminal
rails db:{create,migrate}
```
6. Create application.yml
```
#terminal
bundle exec figaro install
```
7. Add environment variables to application.yml file
  - Navigate to the application.yml file in the config directory
  - Add the following to the file
``` 
#application.yml
MAPQUEST_API_KEY: <your key here>
WEATHER_API_KEY: <your key here>
GOOGLE_KEY: <your key here>
```
- Get your MapQuest api key from https://developer.mapquest.com/documentation/ 
- Get your Weather api key from https://www.weatherapi.com/ 
- Get your Google api key from https://developers.google.com/maps/documentation 

8. Run Tests in the terminal to verify everything was set up correctly
```
#terminal
bundle exec rspec
```
- All tests should be passing
9. Run Rails Server from the terminal to verify you can successfully hit the endpoints
```
#terminal
rails s
```
10. Test the endpoints
- You can utilize Postman or VScodes Thunderclient to test the endpoints are running properly
- Append `http://localhost:3000` to each of the endpoints listed below.

## Endpoints
```
      get 'api/v1/forecast'
      post 'api/v1/users'
      post 'api/v1/sessions'
      post 'api/v1/road_trip'
```
### Forecast
#### Get current and the next 5 days weather for a location

#### Example request
```
get http://localhost:3000/api/v1/forecast?location=denver,co
```
#### Example response
```
"data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "2023-06-12 19:45",
                "temperature": 54.0,
                "feels_like": 54.8,
                "humidity": 80,
                "uvi": 4.0,
                "visibility": 9.0,
                "conditions": "Partly cloudy",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
            },
            "daily_weather": [
                {
                    "date": "2023-06-13",
                    "sunrise": "05:32 AM",
                    "sunset": "08:29 PM",
                    "max_temp": 61.0,
                    "min_temp": 52.5,
                    "conditions": "Heavy rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/308.png"
                },
                {
                    "date": "2023-06-14",
                    "sunrise": "05:32 AM",
                    "sunset": "08:29 PM",
                    "max_temp": 83.1,
                    "min_temp": 48.9,
                    "conditions": "Patchy rain possible",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
                },
                etc... for the next 3 days
            ],
            "hourly_weather": [
                {
                    "time": "00:00",
                    "temperature": 54.1,
                    "conditions": "Moderate rain at times",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/299.png"
                },
                {
                    "time": "01:00",
                    "temperature": 53.8,
                    "conditions": "Partly cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                },
                {
                    "time": "02:00",
                    "temperature": 53.4,
                    "conditions": "Cloudy",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/119.png"
                },
                etc... for the remaining 24 hours
            ]
        }
    }
}
```

### User registration
#### Register for a new account


#### Example request
```
post http://localhost:3000/api/v1/users
  # in the body of the request, send
  {
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
#### Example response
```
{
    "data": {
        "id": "3",
        "type": "users",
        "attributes": {
            "email": "whatever@examples.com",
            "api_key": "61e82e95170d1a917904be3967"
        }
    }
}
```

### User Login
#### Login as a registered user (Designed for a front end application to store session information)

#### Example request
```
post http://localhost/api/v1/sessions
 # in the body of the request, send
  {
  "email": "whatever@example.com",
  "password": "password"
}
```

#### Example response (if the user exists and the passwords match)
```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```

### Road Trip
#### Find the travel time (by car) between two points and see the eta weather of your destination

#### Example request
```
post http://localhost/api/v1/road_trip
  #in the body of the request send
  {
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "<your_api_key>"
}
```

#### Example response
```
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-07 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}
```

## Schema
```
create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```

## API's Used
- MapQuest API (for directions)
- Google API (for timezone calculation)
- Weather API (for weather information)

## Author
- Thomas Hawley [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/thawley2) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/thomas-hawley-901612123/)
