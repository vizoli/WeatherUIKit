//
//  Weather.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

// Decode only important data from response
struct WeatherResponse: Decodable {
    let weather: [WeatherWeather]
    let main: WeatherMain
    let wind: WeatherWind
}

struct WeatherWeather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Decodable {
    let temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}

struct WeatherWind: Decodable {
    let speed: Double
}
