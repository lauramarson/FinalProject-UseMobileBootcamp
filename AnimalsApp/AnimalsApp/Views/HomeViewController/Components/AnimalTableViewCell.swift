//
//  AnimalTableViewCell.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit
import SDWebImage

class AnimalTableViewCell: UITableViewCell {

    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var animal: Animal?
    
//    var isFavorite: Bool? {
//        didSet {
//            guard let isFavorite = isFavorite else { return }
//            if isFavorite {
//                favoriteButton.imageView?.image = .favorite
//            } else {
//                favoriteButton.imageView?.image = .notFavorite
//            }
//        }
//    }
    
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
        
        let imageURL = animal.imageURL
        let placeholderImage = UIImage.imagePlaceHolder

        animalImage.sd_setImage(with: imageURL, placeholderImage: placeholderImage)
        
        if animal.isFavorite ?? false {
            favoriteButton.setImage(.favorite, for: .normal)
        } else {
            favoriteButton.setImage(.notFavorite, for: .normal)
        }
    }
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        guard let animal = animal else { return }
        
        if animal.isFavorite ?? false {
            sender.setImage(.notFavorite, for: .normal)
        } else {
            sender.setImage(.favorite, for: .normal)
        }
    }
    
}
