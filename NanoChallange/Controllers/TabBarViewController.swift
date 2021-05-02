//
//  TabBarViewController.swift
//  NanoChallange
//
//  Created by Puras Handharmahua on 26/04/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = TodayViewController()
        let vc2 = PlanningViewController()
        let vc3 = TransactionsViewController()

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)

        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label

        nav1.tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "wallet.pass.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Planning", image: UIImage(systemName: "captions.bubble.fill"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "list.bullet"), tag: 3)

        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        tabBar.tintColor = UIColor(red: 56/255, green: 134/255, blue: 89/255, alpha: 1)

        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    
}
