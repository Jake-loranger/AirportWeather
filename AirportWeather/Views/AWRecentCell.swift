//
//  AWRecentCell.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import UIKit

class AWRecentCell: UITableViewCell {

    static let reuseID = "AWRecentCell"
    let cellTitle = AWTitleLabel(textAlignment: .left, fontSize: 18)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(airport: RecentAirport) {
        cellTitle.text = airport.airportSymbol
    }
    
    private func configure() {
        addSubview(cellTitle)
        
        let padding: CGFloat = 20
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo: topAnchor),
            cellTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            cellTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            cellTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
