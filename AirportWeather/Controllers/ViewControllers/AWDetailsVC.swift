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
                DispatchQueue.main.async {
                    // UI Configuration
                }
                return
            case .failure(let error):
                self.presentErrorOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                return
            }
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
    

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Conditions")
        case 1:
            print("Forecasts")
        default:
            break
        }
    }
}
