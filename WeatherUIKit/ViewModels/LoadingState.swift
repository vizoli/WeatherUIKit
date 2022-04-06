//
//  LoadingState.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

enum LoadingState {
    case loading
    case failure
    case success
}

// Base class for loading state handling
class LoadingStateClass {
    var loadingState: Dynamic<LoadingState?> = Dynamic(nil)
}
