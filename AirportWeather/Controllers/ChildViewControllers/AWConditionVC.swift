//
//  AWConditionVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import UIKit

class AWConditionVC: UIViewController {
    
    var conditionVM: AWConditionViewModel!
    
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
        setConditionViewValues()
    }
    
    init(weatherReport: WeatherReport) {
        super.init(nibName: nil, bundle: nil)
        self.conditionVM = AWConditionViewModel(weatherReport)
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
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setConditionViewValues() {
        metarView.detailValueLabel.text = conditionVM.metarString
        latView.detailValueLabel.text = conditionVM.latString
        lonView.detailValueLabel.text = conditionVM.lonString
        weatherView.detailValueLabel.text = conditionVM.weatherString
        tempView.detailValueLabel.text = conditionVM.tempString
        dewView.detailValueLabel.text = conditionVM.dewString
        windView.detailValueLabel.text = conditionVM.windString
        visView.detailValueLabel.text = conditionVM.visibilityString
        humidView.detailValueLabel.text = conditionVM.relativeHumidityString
        pressureView.detailValueLabel.text = conditionVM.pressureHpaString
        skyView.detailValueLabel.text = conditionVM.cloudLayersString
        updatedTime.text = "Time Issued: " + conditionVM.timeIssued
        updatedTime.textColor = .systemGray4
    }
}
