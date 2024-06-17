//
//  AWDetailsVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import UIKit

class AWDetailsVC: UIViewController {
    
    var airportSymbol: String!
    let airportTitle = UILabel()
    let airportTExt = UILabel()
    let date = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchWeatherData(for: airportSymbol)
        
        /* MARK - Temporary airport display */
        view.addSubview(airportTitle)
        airportTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            airportTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            airportTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            airportTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            airportTitle.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(airportTExt)
        airportTExt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            airportTExt.topAnchor.constraint(equalTo: airportTitle.bottomAnchor, constant: 10),
            airportTExt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            airportTExt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            airportTExt.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: airportTExt.bottomAnchor, constant: 10),
            date.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            date.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            date.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func fetchWeatherData(for airportSymbol: String) {
        NetworkManager.shared.getAirportWeatherData(for: airportSymbol) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherData):
                DispatchQueue.main.async {
                    self.airportTitle.text = weatherData.report.conditions?.ident
                    self.airportTExt.text = weatherData.report.conditions?.text
                    self.date.text = weatherData.report.conditions?.dateIssued
                }
                return
            case .failure(let error):
                self.presentErrorOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
                
                return
            }
        }
    }

}
