//
//  Alert+UIViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 20/06/22.
//

import UIKit

protocol ShowAlertProtocol: AnyObject {
    func alert(_ alert: UIAlertController)
}

extension UIViewController {

    func fetchAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        return alert
    }
}
