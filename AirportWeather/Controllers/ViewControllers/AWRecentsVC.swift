//
//  AWRecentsVC.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import UIKit

class AWRecentsVC: UIViewController {
    
    let tableView = UITableView()
    var recentAirports: [RecentAirport] = []
//    = [RecentAirport(airportSymbol: "KPWM"), RecentAirport(airportSymbol: "KAUS")]  // Should I just put KPWM & KAUS here instead of work with adding it in the PersistanceManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecents()
    }
    
    
    private func configureViewController() {
        title = "Recents"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func getRecents() {
        PersistanceManager.retrieveRecents { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let recents):
                self.recentAirports = recents
                self.recentAirports = self.recentAirports.reversed()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            case .failure(let error):
                self.presentErrorOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.frame = view.bounds
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AWTableCell.self, forCellReuseIdentifier: AWTableCell.reuseID)
    }
}

extension AWRecentsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentAirports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AWTableCell.reuseID) as! AWTableCell
        let recentAirport = recentAirports[indexPath.row]
        cell.set(airport: recentAirport)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let recent = recentAirports[indexPath.row]
        recentAirports.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateRecentsWith(airportSymbol: recent, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentErrorOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Okay")
            
        }
    }
}
