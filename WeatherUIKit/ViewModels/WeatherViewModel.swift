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
    var temperature: String { get }
    var condition: String { get }
    var temperatureMaxMin: String { get }
    var windSpeed: String { get }
    var icon: UIImage? { get }

    init(queryCityName: String)

    func getWeatherByCityName()
}

class WeatherViewModel: LoadingStateClass, WeatherViewModelStrategy {
    private var weather: WeatherResponse?
    
    var queryCityName: String
    
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
                case let .failure(error):
                    print(error)
                    self?.loadingState.value = .failure
                }
            }
        }
    }
}

// Expose model to view
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
    
    var temperature: String {
        "\(numberFormat(weather?.main.temperature))°C"
    }
    
    var condition: String {
        "\(weather?.weather.first?.main ?? "") - \(weather?.weather.first?.description ?? "")"
    }
    
    var temperatureMaxMin: String {
        "Max: \(numberFormat(weather?.main.temperatureMax))°C Min: \(numberFormat(weather?.main.temperatureMin))°C"
    }
    
    var windSpeed: String {
        "Wind: \(numberFormat(weather?.wind.speed)) m/sec"
    }

    // Use Kingfisher for image fetching
    var icon: UIImage? {
        UIImage()
    }
    
}
