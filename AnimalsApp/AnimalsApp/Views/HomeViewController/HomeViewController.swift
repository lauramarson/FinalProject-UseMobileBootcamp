//
//  HomeViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    let homeVM = HomeViewModel()
    
    let homeVM2 = HomeViewModel2()
    var bag = Set<AnyCancellable>()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.startAnimating()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "AnimalTableViewCell", bundle: nil), forCellReuseIdentifier: "Animal")
        
        setNavigationItems()
        populateTableView()
        
        homeVM2.$viewState
            .receive(on: DispatchQueue.main)
            .sink { value in
                switch value {
                    
                case .idle:
                    break
                case .loading:
                    // show indicator
                    break
                case .error(_):
                    // show error view
                    break
                case .loaded(_):
                    self.tableView.reloadData()
                }
            }.store(in: &bag)
            
        
    }
    
    private func setNavigationItems() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "blueTextColor") as Any]
    }
    
    private func populateTableView() {
        homeVM.getAllAnimals { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.loadingView.stopAnimating()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Animal", for: indexPath) as? AnimalTableViewCell else {
            return UITableViewCell()
        }
        
        cell.animal = homeVM.modelAt(indexPath.row)
        cell.configure()
        
        return cell
    }

}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("entrou")
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        //continuar

        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
