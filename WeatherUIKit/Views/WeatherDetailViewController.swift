//
//  WeatherDetailViewController.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

import UIKit

// Weather details for the selected city
class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var detailStack: UIStackView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureMaxMinLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var weatherViewModel: WeatherViewModelStrategy!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bindViewModel()
    }
    
    private func setup() {
        detailStack.isHidden = true
        loadingLabel.isHidden = true
        errorLabel.isHidden = true
        title = weatherViewModel.queryCityName
        weatherViewModel.getWeatherByCityName()
    }
    
    private func bindViewModel() {
        weatherViewModel.loadingState.bind { [weak self] loadingState in
            self?.updateUIByLoadingState(loadingState)
        }
    }
    
    func updateUIByLoadingState(_ loadingState: LoadingState?) {
        switch loadingState {
        case .none:
            detailStack.isHidden = true
            loadingLabel.isHidden = true
            errorLabel.isHidden = true
        case .loading:
            detailStack.isHidden = true
            loadingLabel.isHidden = false
            errorLabel.isHidden = true
        case .failure:
            detailStack.isHidden = true
            loadingLabel.isHidden = true
            errorLabel.isHidden = false
        case .success:
            detailStack.isHidden = false
            loadingLabel.isHidden = true
            errorLabel.isHidden = true
            updateDetailLabels()
        }
    }
    
    func updateDetailLabels() {
        temperatureLabel.text = weatherViewModel.temperature
        conditionLabel.text = weatherViewModel.condition
        temperatureMaxMinLabel.text = weatherViewModel.temperatureMaxMin
        windSpeedLabel.text = weatherViewModel.windSpeed
    }
    
}
