//
//  HomeViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    // MARK: Properties
    let homeVM = HomeViewModel()
    
    // MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var emptyAnimationView: AnimationView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.startAnimating()
        setNavigationItems()
        setTableView()
        
        homeVM.loadFavorites { [weak self] in
            self?.populateTableView()
        }
        
        setRefreshControl()
        notificationCenter()
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
        navigationItem.backButtonTitle = ""
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "AnimalTableViewCell", bundle: nil), forCellReuseIdentifier: "Animal")
    }
    
    private func populateTableView() {
        emptyAnimationView.isHidden = true
        tableView.isHidden = false
        emptyAnimationView.stop()
        
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
                guard let alert = self?.fetchAlert(title: "Oops...", message: "N??o foi poss??vel carregar os animais") else { return }
                self?.present(alert, animated: true)
            }
            
            if (self?.homeVM.animals.isEmpty ?? true) {
                self?.emptyAnimationView.isHidden = false
                self?.setEmptyAnimation()
            }
        }
    }
    
    private func setEmptyAnimation() {
        emptyAnimationView.isHidden = false
        emptyAnimationView.contentMode = .scaleAspectFit
        emptyAnimationView.loopMode = .loop
        emptyAnimationView.animationSpeed = 1
        tableView.isHidden = true
        emptyAnimationView.play()
    }
    
    private func notificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    private func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadAnimals), for: .valueChanged)
        tableView.refreshControl = refreshControl
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

// MARK: - TableView Data Source
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

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        let animal = homeVM.modelAt(indexPath.row)
        detailVC.animal = animal

        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Action Delegate Protocol
extension HomeViewController: ActionDelegateProtocol {
    func addFavoriteTapped(at index: Int, with image: Data) {
        homeVM.addFavorite(at: index, with: image)
    }
    
    func removeFavoriteTapped(at index: Int) {
        homeVM.removeFavorite(at: index)
    }   
}
