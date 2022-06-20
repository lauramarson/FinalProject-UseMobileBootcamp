//
//  HomeViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Properties
    let homeVM = HomeViewModel()
    
    // MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.startAnimating()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "AnimalTableViewCell", bundle: nil), forCellReuseIdentifier: "Animal")
        
        setNavigationItems()
        homeVM.loadFavorites { [weak self] in
            self?.populateTableView()
        }

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadAnimals), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        homeVM.saveChangesInCoreData()
    }
    
    // MARK: Methods
    private func setNavigationItems() {
        title = "Home"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blueTextColor ?? UIColor.blue,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        navigationItem.backButtonTitle = ""
    }
    
    private func populateTableView() {
        homeVM.getAllAnimals { [weak self] (result) in
            
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.loadingView.stopAnimating()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                self?.loadingView.stopAnimating()
                guard let alert = self?.fetchAlert(title: "Oops...", message: "Não foi possível carregar os animais") else { return }
                self?.present(alert, animated: true)
            }
        }
    }
    
    @objc
    private func reloadAnimals(refreshControl: UIRefreshControl) {
        populateTableView()
        refreshControl.endRefreshing()
    }
    
    @objc
    private func saveChanges() {
        homeVM.saveChangesInCoreData()
    }
}

// MARK: TableView Data Source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Animal", for: indexPath) as? AnimalTableViewCell else {
            return UITableViewCell()
        }
        
        cell.animal = homeVM.modelAt(indexPath.row)
        cell.index = indexPath.row
        cell.delegate = self
        cell.configure()
        
        return cell
    }

}

// MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        let animal = homeVM.modelAt(indexPath.row)
        detailVC.animal = animal

        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: Action Delegate Protocol
extension HomeViewController: ActionDelegateProtocol {
    func addFavoriteTapped(at index: Int, with image: Data) {
        homeVM.addFavorite(at: index, with: image)
    }
    
    func removeFavoriteTapped(at index: Int) {
        homeVM.removeFavorite(at: index)
    }   
}
