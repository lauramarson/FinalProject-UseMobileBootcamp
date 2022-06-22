//
//  AnimalTableViewCell.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit
import SDWebImage

protocol ActionDelegateProtocol: AnyObject {
    func addFavoriteTapped(at index: Int, with image: Data)
    func removeFavoriteTapped(at index: Int)
}

class AnimalTableViewCell: UITableViewCell {
    
    // MARK: Properties
    weak var delegate: ActionDelegateProtocol?
    var animal: Animal?
    var index: Int?

    // MARK: Outlets
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: Methods
    func configure() {
        guard let animal = animal else { return }
        
        self.nameLabel.text = animal.name
        
        self.descriptionLabel.text = animal.description
        
        self.animalImage.layer.cornerRadius = 10
        self.animalImage.layer.borderWidth = 0.5
        self.animalImage.layer.borderColor = UIColor.lightGray?.cgColor
        
        if let imageData = animal.imageData {
            animalImage.image = UIImage(data: imageData)
        } else {
            let imageURL = animal.imageURL
            let placeholderImage = UIImage.imagePlaceHolder

            animalImage.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        }
        
        animal.isFavorite ?? false ? favoriteButton.setImage(.favorite, for: .normal) : favoriteButton.setImage(.notFavorite, for: .normal)
    }
    
    // MARK: Actions
    @IBAction func favoritePressed(_ sender: UIButton) {
        guard let animal = animal, let index = index else { return }
        
        if animal.isFavorite ?? false {
            sender.setImage(.notFavorite, for: .normal)
            self.animal?.isFavorite = false
            delegate?.removeFavoriteTapped(at: index)
        } else {
            sender.setImage(.favorite, for: .normal)
            self.animal?.isFavorite = true
            let image = SDImageCache.shared.imageFromDiskCache(forKey: animal.imageURL.absoluteString)
            let imageData = image?.jpegData(compressionQuality: 0.9)
            delegate?.addFavoriteTapped(at: index, with: imageData ?? Data())
        }
    }
}
