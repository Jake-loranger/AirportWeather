//
//  AWRecentCell.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import UIKit

class AWRecentCell: UITableViewCell {

    static let reuseID = "AWRecentCell"
    
    let airportTitle = AWTitleLabel(textAlignment: .left, fontSize: 24)
    let metarLabel = AWTitleLabel(titleString: "METAR: ", textAlignment: .left, fontSize: 14, weight: .semibold)
    let metarValueLabel = AWTitleLabel(textAlignment: .left, fontSize: 10, weight: .regular)
    let flightRulesLabel = AWTitleLabel(titleString: "Flight Rules: ", textAlignment: .left, fontSize: 14, weight: .semibold)
    let flightRulesValueLabel = AWTitleLabel(textAlignment: .left, fontSize: 10, weight: .regular)
    let lastUpdatedLabel = AWTitleLabel(textAlignment: .right, fontSize: 10, weight: .regular)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAirportTitle()
        configureMetar()
        configureFlightRules()
        configureLastUpdated()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(airport: RecentAirport) {
        airportTitle.text = airport.airportSymbol
        getAirportData(airport.airportSymbol)
    }
    
    private func getAirportData(_ airportSymbol: String) {
        NetworkManager.shared.getAirportWeatherData(for: airportSymbol) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let weatherReport):
                DispatchQueue.main.async {
                    self.metarValueLabel.text = weatherReport.report.conditions?.text ?? "N/A"
                    self.flightRulesValueLabel.text = weatherReport.report.conditions?.flightRules?.uppercased() ?? "N/A"
                    let lastUpdateTime = weatherReport.report.conditions?.dateIssued?.convertToDateFormat() ?? "Could not load"
                    self.lastUpdatedLabel.text = "Updated: " + lastUpdateTime
                }
            case .failure( _):
                print("failure")
                return
            }
        }
    }
    
    private func configureAirportTitle() {
        addSubview(airportTitle)
        
        let padding: CGFloat = 20
        airportTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            airportTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            airportTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            airportTitle.widthAnchor.constraint(equalToConstant: 150),
            airportTitle.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func configureMetar() {
        addSubview(metarLabel)
        addSubview(metarValueLabel)
        metarValueLabel.numberOfLines = 2
        metarValueLabel.lineBreakMode = .byWordWrapping
        
        let padding: CGFloat = 20
        metarLabel.translatesAutoresizingMaskIntoConstraints = false
        metarValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            metarLabel.topAnchor.constraint(equalTo: airportTitle.bottomAnchor, constant: 5),
            metarLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            metarLabel.widthAnchor.constraint(equalToConstant: 50),
            metarLabel.heightAnchor.constraint(equalToConstant: 30),
            
            metarValueLabel.topAnchor.constraint(equalTo: airportTitle.bottomAnchor, constant: 10),
            metarValueLabel.leadingAnchor.constraint(equalTo: metarLabel.trailingAnchor, constant: 5),
            metarValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            metarValueLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func configureFlightRules() {
        addSubview(flightRulesLabel)
        addSubview(flightRulesValueLabel)
        flightRulesValueLabel.numberOfLines = 2
        flightRulesValueLabel.lineBreakMode = .byWordWrapping
        
        let padding: CGFloat = 20
        flightRulesLabel.translatesAutoresizingMaskIntoConstraints = false
        flightRulesValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flightRulesLabel.topAnchor.constraint(equalTo: metarValueLabel.bottomAnchor, constant: 3),
            flightRulesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            flightRulesLabel.widthAnchor.constraint(equalToConstant: 80),
            flightRulesLabel.heightAnchor.constraint(equalToConstant: padding),
            
            flightRulesValueLabel.topAnchor.constraint(equalTo: metarValueLabel.bottomAnchor, constant: 3),
            flightRulesValueLabel.leadingAnchor.constraint(equalTo: flightRulesLabel.trailingAnchor, constant: 5),
            flightRulesValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            flightRulesValueLabel.heightAnchor.constraint(equalToConstant: padding)
            
        ])
    }
    
    private func configureLastUpdated() {
        addSubview(lastUpdatedLabel)
        lastUpdatedLabel.text = "Last Updated"
        lastUpdatedLabel.textColor = .systemGray
        
        let padding: CGFloat = 20
        lastUpdatedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastUpdatedLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            lastUpdatedLabel.leadingAnchor.constraint(equalTo: airportTitle.trailingAnchor),
            lastUpdatedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            lastUpdatedLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}
