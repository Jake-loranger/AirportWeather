//
//  AWButton.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import UIKit

class AWButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
//        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    //setTitle("See Weather Details", for: .normal)
    //layer.cornerRadius = 10
    //backgroundColor = .systemGreen
    //setTitleColor(.white, for: .normal)
    
}
