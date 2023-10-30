//
//  CustomTabBarViewController.swift
//  Medi-Buddy
//
//  Created by Jinah Park on 2023/08/23.
//

import UIKit

class CustomTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = UIColor(named: "Main")
    }
    
    private func configureTabBar() {
        let firstController = ContainerViewController()
        firstController.tabBarItem.image = UIImage(systemName: "clock.badge.checkmark")
        
        let secondNavigationController = UINavigationController(rootViewController: MediCalendarViewController())
        secondNavigationController.tabBarItem.image = UIImage(systemName: "calendar")

        
        viewControllers = [firstController,
                           secondNavigationController]
    }
}
