//
//  CityListViewModel.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

import Foundation

protocol CityListViewModelStrategy {
    var cities: Dynamic<[CityViewModel]> { get }
    func getCities()
}

// View model for cities list
struct StaticCityListViewModel: CityListViewModelStrategy {
    let cities = Dynamic<[CityViewModel]>([])
    
    private let staticCities: [City] = [
        City(name: "Győr", state: "Győr-Moson-Sopron megye"),
        City(name: "Kecskemét", state: "Bács-Kiskun megye"),
        City(name: "Debrecen", state: "Hajdú-Bihar megye"),
        City(name: "Pécs", state: "Baranya megye"),
        City(name: "Szeged", state: "Csongrád-Csanád megye"),
        City(name: "Mos Eisley", state: "Tatuin")
    ]
    
    func getCities() {
        cities.value = staticCities.map(CityViewModel.init)
    }
    
}
