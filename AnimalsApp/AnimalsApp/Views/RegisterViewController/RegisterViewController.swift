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
    private var registerVM = RegisterViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
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
        notificationCenter()
        activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: Actions
    @IBAction func handlerButtonRegister(_ sender: Any) {
        activityIndicator.startAnimating()
        buttonRegister.backgroundColor = .grayCellFrame
        buttonRegister.isUserInteractionEnabled = false
        
        guard let name = textFieldName.text?.testIfIsEmpty(),
              let description = textFieldDescription.text?.testIfIsEmpty(),
              let age = Int(textFieldAge.text ?? ""),
              let species = textFieldSpecie.text?.testIfIsEmpty(),
              let image = textFieldImageLink.text?.testIfIsEmpty() else {
            showAlerts(alertTitle: "Erro", alertMessage: "Preencha todos os campos")
            return }
              
        registerVM.registerAnimal(name: name, description: description, age: age, species: species, image: image) { [weak self] (result) in
            
            switch result {
            case .success:
                self?.registerSucceeded()
                
            case .failure(let error):
                print(error.localizedDescription)
                guard let alert = self?.fetchAlert(title: "Oops...", message: "Não foi possível cadastrar o novo animal") else { return }
                self?.present(alert, animated: true) {
                    self?.activityIndicator.stopAnimating()
                    self?.buttonRegister.isUserInteractionEnabled = true
                    self?.buttonRegister.backgroundColor = .purpleButtonColor
                }
            }
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
            textField?.layer.borderColor = UIColor.grayCellFrame?.cgColor
            textField?.layer.masksToBounds = true
        }
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.grayTextColor ?? UIColor.systemGray, NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 16) ?? UIFont.systemFont(ofSize: 16)]
        textFieldName.attributedPlaceholder = NSAttributedString(string: "Nome", attributes: attributes)
        textFieldImageLink.attributedPlaceholder = NSAttributedString(string: "Link da imagem", attributes: attributes)
        textFieldDescription.attributedPlaceholder = NSAttributedString(string: "Descrição", attributes: attributes)
        textFieldSpecie.attributedPlaceholder = NSAttributedString(string: "Espécie", attributes: attributes)
        textFieldAge.attributedPlaceholder = NSAttributedString(string: "Idade", attributes: attributes)
        buttonRegister.layer.cornerRadius = 10
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
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.activityIndicator.stopAnimating()
            self?.buttonRegister.isUserInteractionEnabled = true
            self?.buttonRegister.backgroundColor = .purpleButtonColor
        })
                        
        present(alert, animated: true)
    }
    
    private func registerSucceeded() {
        activityIndicator.stopAnimating()
        buttonRegister.isUserInteractionEnabled = true
        buttonRegister.backgroundColor = .purpleButtonColor
        [textFieldName, textFieldImageLink, textFieldDescription, textFieldSpecie, textFieldAge].forEach { textField in
            textField?.text = ""
        }
    }
    
    private func notificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}

extension RegisterViewController: UIGestureRecognizerDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
