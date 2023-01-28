//
//  CurrentWeatherDTO.swift
//  Weather App
//
//  Created by Dusan Brkic on 10.8.22..
//

struct CurrentWeatherDTO: Decodable {
    var name: String
    var coord: CoordinatesDTO
    var weather: [WeatherDTO]
    var main: MainWeatherDTO

}
