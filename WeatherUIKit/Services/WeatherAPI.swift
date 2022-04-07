//
//  WeatherAPI.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//
import Foundation

struct WeatherAPI {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5/weather"
    static let apiKey = "3b4bcccf5e44675dc8fbaa6b383d2405"
    
    static func weatherUrlBuilder(cityName: String) -> URL? {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = WeatherAPI.scheme
        urlBuilder.host = WeatherAPI.host
        urlBuilder.path = WeatherAPI.path
        urlBuilder.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: WeatherAPI.apiKey)
        ]
        return urlBuilder.url
    }

    static func urlForIconImage(_ imageName: String) -> URL? {
        URL(string: "https://openweathermap.org/img/wn/\(imageName)@2x.png")
    }

}
