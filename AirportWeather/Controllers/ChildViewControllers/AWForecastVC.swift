//
//  AWForecastVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import UIKit

class AWForecastVC: UIViewController {

    var weatherReport: WeatherReport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(weatherReport: WeatherReport) {
        super.init(nibName: nil, bundle: nil)
        self.weatherReport = weatherReport
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
