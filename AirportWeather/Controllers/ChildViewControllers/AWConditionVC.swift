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
    
    let metarView = AWConditionDetailView(title: "METAR")
    let latView = AWConditionDetailView(title: "Longitude")
    let lonView = AWConditionDetailView(title: "Latitude")
    let weatherView = AWConditionDetailView(title: "Weather")
    let tempView = AWConditionDetailView(title: "Temperature")
    let dewView = AWConditionDetailView(title: "Dewpoint")
    let windView = AWConditionDetailView(title: "Wind")
    let visView = AWConditionDetailView(title: "Visibility")
    let humidView = AWConditionDetailView(title: "Humidity")
    let pressureView = AWConditionDetailView(title: "Pressure")
    let skyView = AWConditionDetailView(title: "Sky Coverage")
    let updatedTime = AWTitleLabel(textAlignment: .center, fontSize: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureUIElements()
        setDetailValues()
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
    
    private func configureUIElements() {
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
    
    
    private func setDetailValues() {
        guard let conditions = weatherReport.report.conditions else { return }
        
        metarView.detailValue.text = conditions.text
        
        let lat = conditions.lat ?? 0.0
        let latString = String(format: "%.6f", lat)
        latView.detailValue.text = latString
        
        let lon = conditions.lon ?? 0.0
        let lonString = String(format: "%.6f", lon)
        lonView.detailValue.text = lonString
        
        let weather = conditions.weather?.first ?? "N/A"
        let weatherString = weather != "N/A" ? weather : "No weather data"
        weatherView.detailValue.text = weatherString
        
        let tempC = conditions.tempC ?? 0.0
        let tempCString = String(format: "%.1f°C", tempC)
        tempView.detailValue.text = tempCString
        
        let dewpointC = conditions.dewpointC ?? 0.0
        let dewpointCString = String(format: "%.1f°C", dewpointC)
        dewView.detailValue.text = dewpointCString
        
        let windDirection = conditions.wind?.direction ?? 0
        let windSpeed = conditions.wind?.speedKts ?? 0.0
        let windSpeedString = windSpeed > 0 ? String(format: "%.1f knots", windSpeed) : ""
        let windDirectionString = windDirection > 0 ? (" at " + String(windDirection) + "°") : ""
        let windString = windSpeedString + windDirectionString
        windView.detailValue.text = weatherString
        
        let visibility = conditions.visibility?.distanceSm ?? 0.0
        let visibilityString = visibility > 0 ? String(format: "%.1f sm", visibility) : "No visibility data"
        visView.detailValue.text = visibilityString
        
        let relativeHumidity = conditions.relativeHumidity ?? 0
        let relativeHumidityString = "\(relativeHumidity)%"
        humidView.detailValue.text = relativeHumidityString
        
        let pressureHpa = conditions.pressureHpa ?? 0.0
        let pressureHpaString = String(format: "%.2f hPa", pressureHpa)
        pressureView.detailValue.text = pressureHpaString
        
        let cloudLayers = conditions.cloudLayers ?? []
        let cloudLayersString = cloudLayers.isEmpty ? "No cloud layers" : cloudLayers.compactMap { cloudLayer in
            if let coverage = cloudLayer.coverage, let altitude = cloudLayer.altitudeFt {
                return "\(coverage) at \(Int(altitude))"
            }
            return nil
        }.joined(separator: ", ")
        skyView.detailValue.text = cloudLayersString
        
        updatedTime.text = "Time Issued: \(conditions.dateIssued?.convertToDateFormat() ?? "N/A")"
        updatedTime.textColor = .systemGray2
    }
}
