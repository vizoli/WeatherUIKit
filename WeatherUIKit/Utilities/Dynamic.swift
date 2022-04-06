//
//  Dynamic.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

// Used for observing properties
final class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
