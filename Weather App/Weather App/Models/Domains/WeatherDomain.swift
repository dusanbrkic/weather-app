//
//  WeatherDomain.swift
//  Weather App
//
//  Created by Dusan Brkic on 15.8.22..
//

import Foundation

struct WeatherDomain {
    var currentWeather: CurrentWeatherDTO
    var hourlyForecast: HourlyForecastDTO
    var currentWeatherIcon: Data?
    var hourlyForecastIcons: [Data?]
}
