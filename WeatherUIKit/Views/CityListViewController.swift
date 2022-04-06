//
//  CityListViewController.swift
//  WeatherUIKit
//
//  Created by Zoltan Vinkler on 2022. 04. 06..
//

import UIKit

// List of city names
class CityListViewController: UITableViewController {
    var cityListViewModel: CityListViewModelStrategy = MockCityListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        cityListViewModel.getCities()
    }

    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        bindViewModel()
    }
    
    // Reload table view if data changes
    func bindViewModel() {
        cityListViewModel.cities.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListViewModel.cities.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell

        let cityViewModel = cityListViewModel.cities.value[indexPath.row]
        cell.nameLabel.text = cityViewModel.name
        cell.stateLabel.text = cityViewModel.state

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected city name to the detail view controller.
        if segue.identifier == "DetailSegue", let weatherDetailVC = segue.destination as? WeatherDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
            let cityName = cityListViewModel.cities.value[indexPath.row].name
            weatherDetailVC.weatherViewModel = WeatherViewModel(queryCityName: cityName)
        }
    }

}
