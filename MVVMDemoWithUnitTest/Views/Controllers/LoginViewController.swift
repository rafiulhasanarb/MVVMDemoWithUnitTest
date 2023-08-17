//
//  LoginViewController.swift
//  MVVMDemoWithUnitTest
//
//  Created by rafiul hasan on 15/8/23.
//

import UIKit

@available(iOS 16.0, *)
class LoginViewController: UIViewController {

    //MARK:- outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    private let backgroundColor: UIColor = .white
    private let tintColor = UIColor(hexString: "#ff5a66")

    private let titleFont = UIFont.boldSystemFont(ofSize: 30)
    private let buttonFont = UIFont.boldSystemFont(ofSize: 20)

    private let textFieldFont = UIFont.systemFont(ofSize: 16)
    private let textFieldColor = UIColor(hexString: "#B0B3C6")
    private let textFieldBorderColor = UIColor(hexString: "#B0B3C6")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = titleFont
        titleLabel.text = "Log In"
        titleLabel.textColor = tintColor

        emailTextField.configure(color: textFieldColor, font: textFieldFont, cornerRadius: 40/2, borderColor: textFieldBorderColor, backgroundColor: backgroundColor, borderWidth: 1.0)
        emailTextField.placeholder = "E-mail"
        emailTextField.textContentType = .emailAddress
        emailTextField.clipsToBounds = true

        passwordTextField.configure(color: textFieldColor, font: textFieldFont, cornerRadius: 40/2, borderColor: textFieldBorderColor, backgroundColor: backgroundColor, borderWidth: 1.0)
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .emailAddress
        passwordTextField.clipsToBounds = true

        loginButton.setTitle("Log In", for: .normal)
        loginButton.configure(color: backgroundColor, font: buttonFont, cornerRadius: 44/2, backgroundColor: tintColor)
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let loginManager = FirebaseAuthManager()
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loginManager.signIn(email: email, pass: password) {[weak self] (success) in
            guard let `self` = self else { return }
            var message: String = ""
            if (success) {
                message = "User was sucessfully logged in."
                self.successLogin()
            } else {
                message = "There was an error."
            }
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.display(alertController: alertController)
        }
    }
    
    private func successLogin() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
        self.clearData()
    }
    
    private func clearData() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
