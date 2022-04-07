//
//  NetworkClient.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

import Foundation

//import Foundation

enum NetworkError: Error {
    case urlError
    case noData
    case decodeError
}

class NetworkClient {
    
    func getWeatherBy(cityName: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        // URL build
        guard let url = WeatherAPI.weatherUrlBuilder(cityName: cityName) else {
            return completion(.failure(.urlError))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            // No data or error received
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            // Decode JSON
            guard let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                return completion(.failure(.decodeError))
            }
            // Successful data fetch
            // print(weatherResponse)
            completion(.success(weatherResponse))
        }.resume()
    }
    
}
