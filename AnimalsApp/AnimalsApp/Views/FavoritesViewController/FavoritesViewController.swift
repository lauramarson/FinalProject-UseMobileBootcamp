//
//  FavoritesViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoritesVM: FavoritesViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favoritos"
        favoritesVM = FavoritesViewModel()
        
        setTableView()

        favoritesVM?.getFavoriteAnimals { [weak self] in            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesVM?.getFavoriteAnimals { [weak self] in            self?.tableView.reloadData()
        }
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "AnimalTableViewCell", bundle: nil), forCellReuseIdentifier: "Animal")
    }
}

// MARK: TableView Data Source
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesVM?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Animal", for: indexPath) as? AnimalTableViewCell else {
            return UITableViewCell()
        }
        
        cell.animal = favoritesVM?.modelAt(indexPath.row)
        cell.index = indexPath.row
        cell.delegate = self
        cell.configure()
        
        return cell
    }

}

// MARK: TableView Delegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        let animal = favoritesVM?.modelAt(indexPath.row)
        detailVC.animal = animal

        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: Action Delegate Protocol
extension FavoritesViewController: ActionDelegateProtocol {
    func addFavoriteTapped(at index: Int, with image: Data) {
    }
    
    func removeFavoriteTapped(at index: Int) {
        favoritesVM?.removeFavorite(at: index) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

