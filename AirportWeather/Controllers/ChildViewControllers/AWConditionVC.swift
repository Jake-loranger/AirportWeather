//
//  AWConditionVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import UIKit

class AWConditionVC: UIViewController {
    
    var weatherReport: WeatherReport!
    
    let vStackView = UIStackView()
    let hStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private func createHorizontalStackView(column1: AWConditionDetailView, column2: AWConditionDetailView) -> UIStackView {
            let hStackView = UIStackView()
            hStackView.axis = .horizontal
            hStackView.spacing = 40
            hStackView.distribution = .fillEqually
            
            hStackView.addArrangedSubview(column1)
            hStackView.addArrangedSubview(column2)
            
            return hStackView
        }
    
    private func layoutUI() {
        view.addSubview(vStackView)
        
        let padding = CGFloat(32)
        
        vStackView.axis = .vertical
        vStackView.distribution = .equalSpacing
        vStackView.alignment = .fill
        vStackView.spacing = padding
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func configureUIElements() {
        let metarView = AWConditionDetailView(title: "METAR", value: weatherReport.report.conditions?.text ?? "No METAR value")
        let latView = AWConditionDetailView(title: "Longitude", value: "10.3343422343")
        let lonView = AWConditionDetailView(title: "Latitude", value: "14.8432904932")
        let windView = AWConditionDetailView(title: "Wind", value: "206 degrees at 16 knots")
        let visView = AWConditionDetailView(title: "Visibility", value: "6.0 sm")
        let weatherView = AWConditionDetailView(title: "Weather", value: "6.0 sm")
        let skyView = AWConditionDetailView(title: "Sky Conditions", value: "6.0 sm")
        let tempView = AWConditionDetailView(title: "Temperature", value: "6.0 sm")
        let dewView = AWConditionDetailView(title: "Dewpoint", value: "6.0 sm")
        let pressureView = AWConditionDetailView(title: "Pressure", value: "6.0 sm")
        let humidView = AWConditionDetailView(title: "Humidity", value: "6.0 sm")
        let updatedTime = AWTitleLabel(titleString: "Last Updated: June 19th 17:56UTC", textAlignment: .center, fontSize: 10)
        updatedTime.textColor = .systemGray2
        
        let rows = [
            metarView,
            createHorizontalStackView(column1: latView, column2: lonView),
            createHorizontalStackView(column1: windView, column2: visView),
            createHorizontalStackView(column1: weatherView, column2: skyView),
            createHorizontalStackView(column1: tempView, column2: dewView),
            createHorizontalStackView(column1: pressureView, column2: humidView),
            updatedTime
            
        ]
        
        for row in rows {
            vStackView.addArrangedSubview(row)
        }
    }
}
