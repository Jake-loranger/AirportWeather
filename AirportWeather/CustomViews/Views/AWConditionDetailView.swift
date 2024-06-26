//
//  AWConditionDetailView.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/18/24.
//

import UIKit

class AWConditionDetailView: UIView {
    
    let detailTitle = UILabel()
    let detailSeperator = UIView()
    let detailValueLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title: String, value: String = "") {
        super.init(frame: .zero)
        detailTitle.text = title
        detailValueLabel.text = value
        configure()
    }
    
    
    private func configure() {
        addSubview(detailTitle)
        addSubview(detailSeperator)
        addSubview(detailValueLabel)
        
        detailTitle.translatesAutoresizingMaskIntoConstraints = false
        detailTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        detailTitle.textColor = .label
        
        detailSeperator.translatesAutoresizingMaskIntoConstraints = false
        detailSeperator.backgroundColor = .secondarySystemBackground
        
        detailValueLabel.translatesAutoresizingMaskIntoConstraints = false
        detailValueLabel.font = UIFont.systemFont(ofSize: 12)
        detailValueLabel.numberOfLines = 3
        detailValueLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            detailTitle.topAnchor.constraint(equalTo: topAnchor),
            detailTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            detailSeperator.topAnchor.constraint(equalTo: detailTitle.bottomAnchor, constant: 4),
            detailSeperator.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailSeperator.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailSeperator.heightAnchor.constraint(equalToConstant: 2),
            
            detailValueLabel.topAnchor.constraint(equalTo: detailSeperator.bottomAnchor, constant: 8),
            detailValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
