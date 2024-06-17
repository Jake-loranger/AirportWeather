//
//  UIViewControllers+Ext.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import UIKit

extension UIViewController {
    func presentErrorOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
