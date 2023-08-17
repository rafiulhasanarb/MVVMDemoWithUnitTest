//
//  SignUpViewController.swift
//  MVVMDemoWithUnitTest
//
//  Created by rafiul hasan on 15/8/23.
//

import UIKit

@available(iOS 16.0, *)
class SignUpViewController: UIViewController {

    //MARK:- outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var signUpButton: UIButton!
    
    private let tintColor = UIColor(hexString: "#ff5a66")
    private let backgroundColor: UIColor = .white
    private let textFieldColor = UIColor(hexString: "#B0B3C6")
    private let textFieldBorderColor = UIColor(hexString: "#B0B3C6")
    
    private let titleFont = UIFont.boldSystemFont(ofSize: 30)
    private let textFieldFont = UIFont.systemFont(ofSize: 16)
    private let buttonFont = UIFont.boldSystemFont(ofSize: 20)
    
    let signUpManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = titleFont
        titleLabel.text = "Sign Up"
        titleLabel.textColor = tintColor
        
        nameTextField.configure(color: textFieldColor, font: textFieldFont, cornerRadius: 40/2, borderColor: textFieldBorderColor, backgroundColor: backgroundColor, borderWidth: 1.0)
        nameTextField.placeholder = "Full Name"
        nameTextField.clipsToBounds = true
        
        emailTextField.configure(color: textFieldColor, font: textFieldFont, cornerRadius: 40/2, borderColor: textFieldBorderColor, backgroundColor: backgroundColor, borderWidth: 1.0)
        emailTextField.placeholder = "E-mail Address"
        emailTextField.clipsToBounds = true
                
        passwordTextField.configure(color: textFieldColor, font: textFieldFont, cornerRadius: 40/2, borderColor: textFieldBorderColor, backgroundColor: backgroundColor, borderWidth: 1.0)
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clipsToBounds = true
        
        signUpButton.setTitle("Create Account", for: .normal)
        signUpButton.configure(color: backgroundColor, font: buttonFont, cornerRadius: 44/2, backgroundColor: UIColor(hexString: "#334D92"))
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, let username = nameTextField.text {
            signUpManager.createUser(username: username, email: email, password: password) {[weak self] (success) in
                guard let self = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                    self.successLogin()
                } else {
                    message = "Go To Login Page"
                }
                let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }
        }
    }
    
    private func successLogin() {
        navigationController?.popToRootViewController(animated: true)
        self.clearData()
    }
    
    private func clearData() {
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
