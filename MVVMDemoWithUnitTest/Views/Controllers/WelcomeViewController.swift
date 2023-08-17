//
//  WelcomeViewController.swift
//  MVVMDemoWithUnitTest
//
//  Created by rafiul hasan on 15/8/23.
//

import UIKit

@available(iOS 16.0, *)
class WelcomeViewController: UIViewController {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    private let backgroundColor: UIColor = .white
    private let tintColor = UIColor(hexString: "#ff5a66")
    private let subtitleColor = UIColor(hexString: "#464646")
    private let signUpButtonColor = UIColor(hexString: "#414665")
    private let signUpButtonBorderColor = UIColor(hexString: "#B0B3C6")

    private let titleFont = UIFont.boldSystemFont(ofSize: 30)
    private let subtitleFont = UIFont.boldSystemFont(ofSize: 18)
    private let buttonFont = UIFont.boldSystemFont(ofSize: 24)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = titleFont
        titleLabel.text = "Welcome to Firebase"
        titleLabel.textColor = tintColor

        subtitleLabel.font = subtitleFont
        subtitleLabel.text = "Start your iOS app with this Firebase."
        subtitleLabel.textColor = subtitleColor

        loginButton.setTitle("Log in", for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.configure(color: .white,
                              font: buttonFont,
                              cornerRadius: 44/2,
                              backgroundColor: tintColor)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        signUpButton.configure(color: signUpButtonColor,
                               font: buttonFont,
                               cornerRadius: 44/2,
                               borderColor: signUpButtonBorderColor,
                               backgroundColor: backgroundColor,
                               borderWidth: 1)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc private func didTapLoginButton() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func didTapSignUpButton() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

