//
//  AWTabBarController.swift
//  AirportWeather
//
//  Created by Jacob  Loranger on 6/17/24.
//

import UIKit

class AWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITabBar()
    }
    
    
    private func configureUITabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        viewControllers = [createSearchNC(), createRecentsNC()]
    }
    
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = AWSearchVC()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let searchNC = UINavigationController(rootViewController: searchVC)
        searchNC.navigationBar.tintColor = .systemGreen
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        searchNC.navigationBar.standardAppearance = appearance
        searchNC.navigationBar.scrollEdgeAppearance = appearance
        
        return searchNC
    }
    
    
    private func createRecentsNC() -> UINavigationController {
        let recentsVC = AWRecentsVC()
        recentsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        
        let recentsNC = UINavigationController(rootViewController: recentsVC)
        recentsNC.navigationBar.tintColor = .systemGreen
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        recentsNC.navigationBar.standardAppearance = appearance
        recentsNC.navigationBar.scrollEdgeAppearance = appearance
        
        return recentsNC
    }
}
