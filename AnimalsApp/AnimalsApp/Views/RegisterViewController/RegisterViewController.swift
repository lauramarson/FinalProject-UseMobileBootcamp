//
//  RegisterViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    // MARK: Properties
    var registerVM = RegisterViewModel()
    var parameters: [String: Any] = [
        "name": "",
        "description": "",
        "age": 0,
        "specie": "",
        "image": ""
    ]
    
    // MARK: Outlets
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldImageLink: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    @IBOutlet weak var textFieldSpecie: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavigationItems()
        delegateTextField()
        activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: Actions
    @IBAction func handlerButtonRegister(_ sender: Any) {
        if textFieldName.text == "" || textFieldImageLink.text == "" || textFieldDescription.text == "" || textFieldSpecie.text == "" || textFieldAge.text == "" {
            showAlerts(alertTitle: "Erro", alertMessage: "Preencha todos os dados")
            return
        }
        activityIndicator.startAnimating()
        setParameters()
        registerVM.registerAnimal(with: parameters) {
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: Methods
    private func setNavigationItems() {
        title = "Cadastrar"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blueTextColor ?? UIColor.blue,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    private func setupUI() {
        [textFieldName, textFieldImageLink, textFieldDescription, textFieldSpecie, textFieldAge].forEach { textField in
            textField?.layer.cornerRadius = 8
            textField?.layer.borderWidth = 1
            textField?.layer.borderColor = UIColor.systemGray.cgColor
            textField?.layer.masksToBounds = true
        }
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        textFieldName.attributedPlaceholder = NSAttributedString(string: "Nome", attributes:attributes)
        textFieldImageLink.attributedPlaceholder = NSAttributedString(string: "Link da imagem", attributes:attributes)
        textFieldDescription.attributedPlaceholder = NSAttributedString(string: "Descrição", attributes:attributes)
        textFieldSpecie.attributedPlaceholder = NSAttributedString(string: "Espécie", attributes:attributes)
        textFieldAge.attributedPlaceholder = NSAttributedString(string: "Idade", attributes:attributes)
        buttonRegister.layer.cornerRadius = 10
    }
    
    private func setParameters() {
        parameters["name"] = textFieldName.text
        parameters["description"] = textFieldDescription.text
        parameters["age"] = Int(textFieldAge.text ?? "0")
        parameters["specie"] = textFieldSpecie.text
        parameters["image"] = textFieldImageLink.text
    }
    
    private func delegateTextField() {
        textFieldAge.delegate = self
        textFieldName.delegate = self
        textFieldDescription.delegate = self
        textFieldSpecie.delegate = self
        textFieldImageLink.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    private func showAlerts(alertTitle: String?, alertMessage: String?) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

extension RegisterViewController: UIGestureRecognizerDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
