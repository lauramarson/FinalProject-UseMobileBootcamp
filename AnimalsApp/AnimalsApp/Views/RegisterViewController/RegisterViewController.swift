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
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavigationItens()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Actions
    @IBAction func handlerButtonRegister(_ sender: Any) {
        setParameters()
        registerVM.registerAnimal(with: parameters)
    }
    
    // MARK: Methods
    private func setNavigationItens() {
        title = "Cadastrar"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "blueTabBarColor") ?? ""]
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
}
