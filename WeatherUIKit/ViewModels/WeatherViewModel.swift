//
//  WeatherViewModel.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

import Foundation
import UIKit.UIImage

protocol WeatherViewModelStrategy: LoadingStateClass {
    var queryCityName: String { get }
    var temperature: Dynamic<String> { get }
    var condition: Dynamic<String> { get }
    var temperatureMaxMin: Dynamic<String> { get }
    var windSpeed: Dynamic<String> { get }
    var icon: Dynamic<String> { get }

    init(queryCityName: String)

    func getWeatherByCityName()
}

class WeatherViewModel: LoadingStateClass, WeatherViewModelStrategy {
    private var weather: WeatherResponse?
    
    var queryCityName: String
    var temperature = Dynamic("")
    var condition = Dynamic("")
    var temperatureMaxMin = Dynamic("")
    var windSpeed = Dynamic("")
    var icon = Dynamic("")
    
    required init(queryCityName: String) {
        self.queryCityName = queryCityName
    }
    
    // Call API
    func getWeatherByCityName() {
        guard !queryCityName.isEmpty else {
            return
        }
        loadingState.value = .loading
        NetworkClient().getWeatherBy(cityName: queryCityName) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(weatherResponse):
                    self?.weather = weatherResponse
                    self?.loadingState.value = .success
                    self?.assignValues(weather: weatherResponse)
                case let .failure(error):
                    print(error)
                    self?.loadingState.value = .failure
                }
            }
        }
    }
    
    func assignValues(weather: WeatherResponse) {
        temperature.value = "\(numberFormat(weather.main.temperature))°C"
        condition.value = "\(weather.weather.first?.main ?? "") - \(weather.weather.first?.description ?? "")"
        temperatureMaxMin.value = "Max: \(numberFormat(weather.main.temperatureMax))°C Min: \(numberFormat(weather.main.temperatureMin))°C"
        windSpeed.value = "Wind: \(numberFormat(weather.wind.speed)) m/sec"
        icon.value = weather.weather.first?.icon ?? ""
    }
}

// Helper function
extension WeatherViewModel {
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }

    func numberFormat(_ number: Double?) -> String {
        guard let number = number else {
            return ""
        }
        return numberFormatter.string(from: number as NSNumber) ?? ""
    }
}
