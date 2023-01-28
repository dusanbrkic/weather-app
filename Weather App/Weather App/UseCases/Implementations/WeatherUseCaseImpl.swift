//
//  WeatherUseCaseImpl.swift
//  Weather App
//
//  Created by Dusan Brkic on 15.8.22..
//

import Foundation

class WeatherUseCaseImpl: WeatherUseCase {
    let currentWeatherService: CurrentWeatherService
    let weatherIconService: WeatherIconService
    let hourlyForecastService: HourlyForecastService
    let credentialsService: WeatherAPICredentialsService

    init(currentWeatherService: CurrentWeatherService,
         weatherIconService: WeatherIconService,
         hourlyForecastService: HourlyForecastService,
         credentialsService: WeatherAPICredentialsService) {
        self.currentWeatherService = currentWeatherService
        self.weatherIconService = weatherIconService
        self.hourlyForecastService = hourlyForecastService
        self.credentialsService = credentialsService
    }

    func getWeather(lat: String, lon: String) async throws -> WeatherDomain {
        do {
            let appId = try credentialsService.getUserCredentials()
            let currentWeather = try await currentWeatherService.getCurrentWeather(
                lat: lat, lon: lon, appId: appId)
            let hourlyForecasts = try await hourlyForecastService.getHourlyForecast(
                lat: lat, lon: lon, appId: appId)
            let weatherIconData = try await weatherIconService.getWeatherIcon(for: currentWeather.weather.first!.icon)
            let forecastIconsData = try await hourlyForecasts.forecasts.asyncMap { forecast -> Data in
                do {
                    let weatherIconData = try await self.weatherIconService.getWeatherIcon(
                    for: forecast.weather.first!.icon)
                    return weatherIconData
                } catch let error {
                    throw error
                }
            }

            return WeatherDomain(currentWeather: currentWeather,
                                 hourlyForecast: hourlyForecasts,
                                 currentWeatherIcon: weatherIconData,
                                 hourlyForecastIcons: forecastIconsData)

        } catch let error {
            throw error
        }
    }
}
