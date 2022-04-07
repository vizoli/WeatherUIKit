//
//  WeatherDetailViewController.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

import UIKit
import Kingfisher

// Weather details for the selected city
class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var detailStack: UIStackView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
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
        weatherViewModel.temperature.bind { [weak self] temperature in
            self?.temperatureLabel.text = temperature
        }
        weatherViewModel.condition.bind { [weak self] condition in
            self?.conditionLabel.text = condition
        }
        weatherViewModel.temperatureMaxMin.bind { [weak self] temperatureMaxMin in
            self?.temperatureMaxMinLabel.text = temperatureMaxMin
        }
        weatherViewModel.windSpeed.bind { [weak self] windSpeed in
            self?.windSpeedLabel.text = windSpeed
        }
        weatherViewModel.icon.bind { [weak self] icon in
            self?.iconImageView.kf.setImage(with: WeatherAPI.urlForIconImage(icon))
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
        }
    }
    
}
