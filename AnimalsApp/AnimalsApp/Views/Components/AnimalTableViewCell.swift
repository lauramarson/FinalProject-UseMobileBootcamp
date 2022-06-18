//
//  AnimalTableViewCell.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit
import SDWebImage

protocol ActionDelegateProtocol: AnyObject {
    func favoriteButtonTapped(at index: Int, with image: Data)
}

class AnimalTableViewCell: UITableViewCell {
    weak var delegate: ActionDelegateProtocol?
    var animal: Animal?
    var index: Int?

    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        guard let animal = animal else { return }
        
        self.nameLabel.text = animal.name
        
        self.descriptionLabel.text = animal.description
        
        self.animalImage.layer.cornerRadius = 10
        self.animalImage.layer.borderWidth = 0.5
        self.animalImage.layer.borderColor = UIColor.lightGray?.cgColor
        
        let imageURL = animal.imageURL
        let placeholderImage = UIImage.imagePlaceHolder

        animalImage.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        
        animal.isFavorite ?? false ? favoriteButton.setImage(.favorite, for: .normal) : favoriteButton.setImage(.notFavorite, for: .normal)
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        guard let animal = animal else { return }
        
        if animal.isFavorite ?? false {
            sender.setImage(.notFavorite, for: .normal)
            self.animal?.isFavorite = false
        } else {
            sender.setImage(.favorite, for: .normal)
            self.animal?.isFavorite = true
        }
        
        if let index = index, let image = SDImageCache.shared.imageFromDiskCache(forKey: animal.imageURL.absoluteString) {
            let imageData = image.jpegData(compressionQuality: 0.9)
            delegate?.favoriteButtonTapped(at: index, with: imageData ?? Data())
        }
    }
}
