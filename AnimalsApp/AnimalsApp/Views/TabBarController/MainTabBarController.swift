//
//  MainTabBarController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .gray
        setupTabBar()
    }

    func setupTabBar() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image = UIImage(named: "homeBlack")
        homeVC.tabBarItem.selectedImage = UIImage(named: "homeWhite")
        
        let registerVC = UINavigationController(rootViewController: RegisterViewController())
        registerVC.tabBarItem.image = UIImage(named: "registerTabBar")
        registerVC.tabBarItem.selectedImage = UIImage(named: "registerTabBar")
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem.image = UIImage(named: "favoritesTabBar")
        favoritesVC.tabBarItem.selectedImage = UIImage(named: "favoritesTabBar")
        
        viewControllers = [homeVC, registerVC, favoritesVC]
    }
    
}
