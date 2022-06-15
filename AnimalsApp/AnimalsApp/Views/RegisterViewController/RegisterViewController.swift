//
//  RegisterViewController.swift
//  AnimalsApp
//
//  Created by Laura Pinheiro Marson on 14/06/22.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: Properties
    
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
        
    }
    
    // MARK: Methods
    private func setNavigationItens() {
        title = "Cadastrar"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "blueTabBarColor") ?? ""]
    }
    
    private func setupUI() {
        textFieldName.layer.cornerRadius = 10
        textFieldImageLink.layer.cornerRadius = 10
        textFieldDescription.layer.cornerRadius = 10
        textFieldSpecie.layer.cornerRadius = 10
        textFieldAge.layer.cornerRadius = 10
        buttonRegister.layer.cornerRadius = 10
    }
}
