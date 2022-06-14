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
        homeVC.tabBarItem.image = .homeTabBar
        homeVC.tabBarItem.selectedImage = .homeSelectedTabBar
        
        let registerVC = UINavigationController(rootViewController: RegisterViewController())
        registerVC.tabBarItem.image = .registerTabBar
        registerVC.tabBarItem.selectedImage = .registerSelectedTabBar
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem.image = .favoritesTabBar
        favoritesVC.tabBarItem.selectedImage = .favoritesSelectedTabBar
        
        viewControllers = [homeVC, registerVC, favoritesVC]
    }
    
}
