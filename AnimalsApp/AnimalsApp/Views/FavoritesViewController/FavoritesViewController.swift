//
//  FavoritesViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItems()
    }

    private func setNavigationItems() {
        title = "Favoritos"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blueTextColor ?? UIColor.blue,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }

}
