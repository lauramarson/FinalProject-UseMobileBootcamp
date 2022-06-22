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
        setupNavigationBar(for: homeVC)
        
        let registerVC = UINavigationController(rootViewController: RegisterViewController())
        registerVC.tabBarItem = UITabBarItem(title: "Cadastrar", image: .registerTabBar, selectedImage: .registerSelectedTabBar)
        setupNavigationBar(for: registerVC)
        
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem = UITabBarItem(title: "Favoritos", image: .favoritesTabBar, selectedImage: .favoritesSelectedTabBar)
        setupNavigationBar(for: favoritesVC)
        
        viewControllers = [homeVC, registerVC, favoritesVC]
    }
    
    func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.backgroundColor = UIColor.blueTabBarColor

        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    func setupNavigationBar(for navController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blueTextColor ?? UIColor.blue,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20) ?? UIFont.systemFont(ofSize: 20)]

        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        
//        navigationItem.backButtonTitle = ""
        
        navController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navController.navigationBar.layer.shadowRadius = 1
        navController.navigationBar.layer.shadowOpacity = 0.15
    }
    
}
