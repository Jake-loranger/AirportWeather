//
//  AWForecastVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import UIKit

class AWForecastVC: UIViewController {
    
    var forecastConditions: [Conditions] = []
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    init(weatherReport: WeatherReport) {
        super.init(nibName: nil, bundle: nil)
        self.forecastConditions = weatherReport.report.forecast?.conditions ?? []
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AWForecastCell.self, forCellReuseIdentifier: AWForecastCell.reuseID)
    }
}

extension AWForecastVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastConditions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AWForecastCell.reuseID) as! AWForecastCell
        let conditions = forecastConditions[indexPath.row]
        cell.set(conditions: conditions)
        return cell
    }
}
