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
        
        setupViewControllers()
        setupTabBar()
    }

    func setupViewControllers() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: .homeTabBar, selectedImage: .homeSelectedTabBar)
        
        let registerVC = UINavigationController(rootViewController: RegisterViewController())
        registerVC.tabBarItem = UITabBarItem(title: "Cadastrar", image: .registerTabBar, selectedImage: .registerSelectedTabBar)
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(title: "Favoritos", image: .favoritesTabBar, selectedImage: .favoritesSelectedTabBar)
        
        viewControllers = [homeVC, registerVC, favoritesVC]
    }
    
    func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.backgroundColor = UIColor(named: "blueTabBarColor")

        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
    
}
