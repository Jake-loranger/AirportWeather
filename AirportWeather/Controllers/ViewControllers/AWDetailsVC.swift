//
//  AWDetailsVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import UIKit

class AWDetailsVC: UIViewController {
    
    var airportSymbol: String!
    let segmentControlBar = UISegmentedControl()
    var weatherReport: WeatherReport?
    var conditionsVC: AWConditionVC?
    var forecastVC: AWForecastVC?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = airportSymbol
        
        fetchWeatherData(for: airportSymbol)
        configureSegmentControl()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func fetchWeatherData(for airportSymbol: String) {
        NetworkManager.shared.getAirportWeatherData(for: airportSymbol) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherData):
                self.weatherReport = weatherData
                self.saveToRecents(for: self.airportSymbol)
                DispatchQueue.main.async {
                    self.showConditionsView()
                }
                return
            case .failure(let error):
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                self.presentErrorOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                return
            }
        }
    }
    
    
    private func saveToRecents(for airportSymbol: String) {
        let recentAirport = RecentAirport(airportSymbol: airportSymbol)
        
        PersistanceManager.updateRecentsWith(airportSymbol: recentAirport, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.presentErrorOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            return
        }
    }
    
    
    private func configureSegmentControl() {
        view.addSubview(segmentControlBar)
        
        segmentControlBar.insertSegment(withTitle: "Conditions", at: 0, animated: true)
        segmentControlBar.insertSegment(withTitle: "Forecast", at: 1, animated: true)
        segmentControlBar.selectedSegmentIndex = 0
        segmentControlBar.backgroundColor = .tertiarySystemBackground
        segmentControlBar.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        segmentControlBar.translatesAutoresizingMaskIntoConstraints = false
        let padding = CGFloat(20)
        NSLayoutConstraint.activate([
            segmentControlBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            segmentControlBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            segmentControlBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            segmentControlBar.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func showConditionsView() {
        guard let weatherReport = weatherReport else { return }
        conditionsVC = AWConditionVC(weatherReport: weatherReport)
        guard let conditionsVC = conditionsVC else { return }
        addChild(conditionsVC)
        view.addSubview(conditionsVC.view)
        
        conditionsVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conditionsVC.view.topAnchor.constraint(equalTo: segmentControlBar.bottomAnchor),
            conditionsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conditionsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conditionsVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        conditionsVC.didMove(toParent: self)
    }
    
    
    private func showForecastView() {
        guard let weatherReport = weatherReport else { return }
        forecastVC = AWForecastVC(weatherReport: weatherReport)
        guard let forecastVC = forecastVC else { return }
        addChild(forecastVC)
        view.addSubview(forecastVC.view)
        
        forecastVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastVC.view.topAnchor.constraint(equalTo: segmentControlBar.bottomAnchor),
            forecastVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        forecastVC.didMove(toParent: self)
    }
    
    
    private func removeChildViewController(_ childViewController: UIViewController?) {
        guard let childViewController = childViewController else { return }
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
    

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            showConditionsView()
            removeChildViewController(forecastVC)
        case 1:
            showForecastView()
            removeChildViewController(conditionsVC)
        default:
            break
        }
    }
}
