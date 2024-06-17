//
//  AWDetailsVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import UIKit

class AWDetailsVC: UIViewController {
    
    var airportSymbol: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* MARK - Temporary Display of Airport symbol */
        
        view.backgroundColor = .systemBackground
        let tempAirportDisplay = AWTitleLabel(titleString: airportSymbol, textAlignment: .center, fontSize: 40)
        tempAirportDisplay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tempAirportDisplay)
    }

}
