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
        
        let padding = CGFloat(30)
        
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
    
    
    func configureUIElements() {
        guard let conditions = weatherReport.report.conditions else { return }
        
        let lat = conditions.lat ?? 0.0
        let lon = conditions.lon ?? 0.0
        
        let latString = String(format: "%.6f", lat)
        let lonString = String(format: "%.6f", lon)
        
        let weather = conditions.weather?.first ?? "N/A"
        let weatherString = weather != "N/A" ? weather : "No weather data"
        
        let tempC = conditions.tempC ?? 0.0
        let tempCString = String(format: "%.1f°C", tempC)
        
        let dewpointC = conditions.dewpointC ?? 0.0
        let dewpointCString = String(format: "%.1f°C", dewpointC)
        
        let windDirection = conditions.wind?.direction ?? 0
        let windSpeed = conditions.wind?.speedKts ?? 0.0
        let windSpeedString = windSpeed > 0 ? String(format: "%.1f knots", windSpeed) : ""
        let windDirectionString = windDirection > 0 ? (" at " + String(windDirection) + "°") : ""
        let windString = windSpeedString + windDirectionString
        
        let visibility = conditions.visibility?.distanceSm ?? 0.0
        let visibilityString = visibility > 0 ? String(format: "%.1f sm", visibility) : "No visibility data"
        
        let relativeHumidity = conditions.relativeHumidity ?? 0
        let relativeHumidityString = "\(relativeHumidity)%"
        
        let pressureHpa = conditions.pressureHpa ?? 0.0
        let pressureHpaString = String(format: "%.2f hPa", pressureHpa)
        
        let cloudLayers = conditions.cloudLayers ?? []
        let cloudLayersString = cloudLayers.isEmpty ? "No cloud layers" : cloudLayers.compactMap { cloudLayer in
            if let coverage = cloudLayer.coverage, let altitude = cloudLayer.altitudeFt {
                return "\(coverage) at \(Int(altitude))"
            }
            return nil
        }.joined(separator: ", ")
        
        let metarView = AWConditionDetailView(title: "METAR", value: weatherReport.report.conditions?.text ?? "No METAR value")
        let latView = AWConditionDetailView(title: "Longitude", value: lonString)
        let lonView = AWConditionDetailView(title: "Latitude", value: latString)
        let weatherView = AWConditionDetailView(title: "Weather", value: weatherString)
        let tempView = AWConditionDetailView(title: "Temperature", value: tempCString)
        let dewView = AWConditionDetailView(title: "Dewpoint", value: dewpointCString)
        let windView = AWConditionDetailView(title: "Wind", value: windString)
        let visView = AWConditionDetailView(title: "Visibility", value: visibilityString)
        let humidView = AWConditionDetailView(title: "Humidity", value: relativeHumidityString)
        let pressureView = AWConditionDetailView(title: "Pressure", value: pressureHpaString)
        let skyView = AWConditionDetailView(title: "Sky Coverage", value: cloudLayersString)
        
        let updatedTime = AWTitleLabel(titleString: "Time Issued: \(conditions.dateIssued?.convertToDateFormat() ?? "N/A")", textAlignment: .center, fontSize: 10)
        updatedTime.textColor = .systemGray2
        
        let rows = [
            metarView,
            createHorizontalStackView(column1: windView, column2: visView),
            createHorizontalStackView(column1: weatherView, column2: skyView),
            createHorizontalStackView(column1: tempView, column2: dewView),
            createHorizontalStackView(column1: pressureView, column2: humidView),
            createHorizontalStackView(column1: latView, column2: lonView),
            updatedTime
        ]
        
        for row in rows {
            vStackView.addArrangedSubview(row)
        }
    }
}
