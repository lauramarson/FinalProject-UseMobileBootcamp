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
    public var labelNameText: String?
    public var labelSpecieText: String?
    public var textViewText: String?
    public var imageViewURL: URL?
    
    // MARK: Outlets
    @IBOutlet weak var imageViewDetail: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSpecie: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems()
        setupCell()
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
    
    private func setupCell() {
        labelName.text = labelNameText
        labelSpecie.text = labelSpecieText
        textViewDescription.text = textViewText
        imageViewDetail.sd_setImage(with: imageViewURL)
        imageViewDetail.layer.cornerRadius = 10
        imageViewDetail.layer.borderWidth = 0.5
        imageViewDetail.layer.borderColor = UIColor.lightGray?.cgColor
    }
}
