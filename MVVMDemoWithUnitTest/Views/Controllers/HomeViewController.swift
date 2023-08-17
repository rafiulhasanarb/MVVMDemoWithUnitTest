//
//  HomeViewController.swift
//  MVVMDemoWithUnitTest
//
//  Created by rafiul hasan on 15/8/23.
//

import UIKit
import Firebase

@available(iOS 16.0, *)
class HomeViewController: UIViewController {

    @IBOutlet weak var userNamelbl: UILabel!
    
    let loginManager = FirebaseAuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        self.navigationItem.leftBarButtonItem?.isHidden = true
        
        DispatchQueue.main.async {
            if let data = UserDefaults.standard.data(forKey: "userInfo") {
                do {
                    let userInfo = try JSONDecoder().decode(UserModel.self, from: data)
                    self.userNamelbl.text = "Hello \(userInfo.username)"
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
        }
    }
    
    // MARK: - Selectors
    @objc private func didTapLogout() {
        self.loginManager.logout()
        self.alertHome(title: "Logout", message: "Logout Successfully")
        navigationController?.popToRootViewController(animated: true)
    }
    
    func alertHome(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
    }
}
