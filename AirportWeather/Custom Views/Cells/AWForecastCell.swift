//
//  AWForecastCell.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/19/24.
//

import UIKit

class AWForecastCell: UITableViewCell {

    static let reuseID = "AWForecastCell"
    let timeRangeLabel = AWTitleLabel(textAlignment: .left, fontSize: 18)
    let tafLabel = AWTitleLabel(titleString: "TAF: ", textAlignment: .left, fontSize: 12, weight: .semibold)
    let tafValueLabel = AWTitleLabel(textAlignment: .left, fontSize: 12, weight: .regular)
    let flightRulesLabel = AWTitleLabel(titleString: "Flight Rules: ", textAlignment: .left, fontSize: 12, weight: .semibold)
    let flightRulesValueLabel = AWTitleLabel(textAlignment: .left, fontSize: 12, weight: .regular)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTimeRange()
        configureTaf()
        configureFlightRules()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(conditions: Conditions) {
        let startDate = conditions.period?.dateStart?.convertToDateFormat() ?? "N/A"
        let endDate = conditions.period?.dateEnd?.convertToDateFormat() ?? "N/A"
        timeRangeLabel.text = startDate + " - " + endDate
        
        let tafText = (conditions.text ?? "N/A")
        tafValueLabel.text = tafText
        
        let flightRulesText = (conditions.flightRules?.uppercased() ?? "N/A")
        flightRulesValueLabel.text = flightRulesText
    }
    
    
    private func configureTimeRange() {
        addSubview(timeRangeLabel)
        timeRangeLabel.numberOfLines = 2
        timeRangeLabel.lineBreakMode = .byWordWrapping
        
        let padding: CGFloat = 20
        timeRangeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeRangeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeRangeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            timeRangeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            timeRangeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func configureTaf() {
        addSubview(tafLabel)
        addSubview(tafValueLabel)
        tafValueLabel.numberOfLines = 2
        tafValueLabel.lineBreakMode = .byWordWrapping
        
        let padding: CGFloat = 20
        tafLabel.translatesAutoresizingMaskIntoConstraints = false
        tafValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tafLabel.topAnchor.constraint(equalTo: timeRangeLabel.bottomAnchor, constant: 5),
            tafLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            tafLabel.widthAnchor.constraint(equalToConstant: 30),
            tafLabel.heightAnchor.constraint(equalToConstant: padding),
            
            tafValueLabel.topAnchor.constraint(equalTo: timeRangeLabel.bottomAnchor, constant: 5),
            tafValueLabel.leadingAnchor.constraint(equalTo: tafLabel.trailingAnchor, constant: 5),
            tafValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            tafValueLabel.heightAnchor.constraint(equalToConstant: padding)
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
            flightRulesLabel.topAnchor.constraint(equalTo: tafLabel.bottomAnchor, constant: 3),
            flightRulesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            flightRulesLabel.widthAnchor.constraint(equalToConstant: 70),
            flightRulesLabel.heightAnchor.constraint(equalToConstant: padding),
            
            flightRulesValueLabel.topAnchor.constraint(equalTo: tafLabel.bottomAnchor, constant: 3),
            flightRulesValueLabel.leadingAnchor.constraint(equalTo: flightRulesLabel.trailingAnchor, constant: 5),
            flightRulesValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            flightRulesValueLabel.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
}
