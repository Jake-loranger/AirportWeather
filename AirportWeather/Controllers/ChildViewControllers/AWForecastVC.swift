//
//  AWForecastVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import UIKit

class AWForecastVC: UIViewController {

    var weatherReport: WeatherReport!
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    init(weatherReport: WeatherReport) {
        super.init(nibName: nil, bundle: nil)
        self.weatherReport = weatherReport
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUIElements() {
        let rows = [
            AWConditionDetailView(title: "Forecast", value: "Value 1"),
            AWConditionDetailView(title: "Forecast", value: "Value 2"),
            AWConditionDetailView(title: "Forecast", value: "Value 3"),
            AWConditionDetailView(title: "Forecast", value: "Value 4"),
            AWConditionDetailView(title: "Forecast", value: "Value 5"),
            AWConditionDetailView(title: "Forecast", value: "Value 6")
        ]
        
        for row in rows {
            stackView.addArrangedSubview(row)
        }
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
    }
    
    private func layoutUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

}
