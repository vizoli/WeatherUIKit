//
//  CityViewModel.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

// View model for cells
struct CityViewModel {
    let city: City
    
    var name: String {
        city.name
    }
    
    var state: String {
        city.state
    }
}
