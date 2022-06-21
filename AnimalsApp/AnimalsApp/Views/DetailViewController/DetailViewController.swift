//
//  DetailViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 15/06/22.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    // MARK: Properties
    var animal: Animal?
    
    // MARK: Outlets
    @IBOutlet weak var imageViewDetail: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSpecie: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        setupDetails()
    }
    
    private func setNavigationItems() {
        title = "Detalhes"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blueTextColor ?? UIColor.blue,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

        navigationController?.navigationBar.tintColor = UIColor.blueTextColor
    }
    
    private func setupDetails() {
        guard let animal = animal else { return }

        if animal.age == 1 {
            labelName.text = "\(animal.name?.capitalized ?? "") - \(animal.age ?? 1) ano"
        } else {
            labelName.text = "\(animal.name?.capitalized ?? "") - \(animal.age ?? 0) anos"
        }
        
        labelSpecie.text = animal.species?.capitalized
        textViewDescription.text = animal.description
        
        if let imageData = animal.imageData {
            imageViewDetail.image = UIImage(data: imageData)
        } else {
            imageViewDetail.sd_setImage(with: animal.imageURL)
        }
        
        imageViewDetail.layer.cornerRadius = 10
        imageViewDetail.layer.borderWidth = 0.5
        imageViewDetail.layer.borderColor = UIColor.lightGray?.cgColor
    }
}
