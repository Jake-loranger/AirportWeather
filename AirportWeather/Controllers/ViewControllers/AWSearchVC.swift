//
//  AWSearchVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import UIKit

class AWSearchVC: UIViewController {
    
    let imageView = UIImageView()
    let titleLabel = AWTitleLabel(titleString: "Airport Weather", textAlignment: .center, fontSize: 42)
    let airportTextField = AWSearchTextField(placeholder: "Enter an airport symbol")
    let callToActionButton = AWButton(backgroundColor: .systemGreen, title: "See Weather Details")
    var isUsernameEntered: Bool { return !airportTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        
        configureImageView()
        configureTitleLabel()
        configureTextField()
        configureCallToActionButton()
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        imageView.image = UIImage(systemName: "airplane.departure")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        
        /* TO DO - Make position dynamic to screen size & orientation */
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureTextField() {
        view.addSubview(airportTextField)
        createDismissKeyboardTapGesture()
        airportTextField.delegate = self
        
        airportTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            airportTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            airportTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            airportTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            airportTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushDetailsVC), for: .touchUpInside)
        
        callToActionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callToActionButton.topAnchor.constraint(equalTo: airportTextField.bottomAnchor, constant: 100),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushDetailsVC() {
        guard isUsernameEntered else {
            DispatchQueue.main.async {
                
                /* TO DO - Create a custom Error view for this */
                
                let alertController = UIAlertController(title: "Missing Entry", message: "Airport must be entered", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
            return
        }
        
        let detailsVC = AWDetailsVC()
        detailsVC.airportSymbol = airportTextField.text
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension AWSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushDetailsVC()
        return true
    }
}

