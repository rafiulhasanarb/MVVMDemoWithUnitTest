//
//  FirebaseAuthManager.swift
//  MVVMDemoWithUnitTest
//
//  Created by rafiul hasan on 16/8/23.
//

import UIKit
import Foundation
import FirebaseAuth

class FirebaseAuthManager: NSObject {
    
    var userInfoVM = UserInfoServices()
    var userInfo: UserModel?
    
    func createUser(username: String, email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                let userInfo = UserModel(uid: user.uid, username: username, email: email, password: password)
                self.userInfoVM.createUser(user: userInfo) { userInfo, error in
                    if error != nil {
                        completionBlock(true)
                    }
                    do {
                        let data = try JSONEncoder().encode(userInfo)
                        UserDefaults.standard.set(data, forKey: "userInfo")
                    } catch {
                        print("Unable to Encode Note (\(error))")
                    }
                }
            } else {
                completionBlock(false)
            }
        }
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                completionBlock(false)
            } else {
                guard let user = result?.user else { return }
                
                self.userInfoVM.fetchUser(userId: user.uid) { userInfo, error in
                    do {
                        let data = try JSONEncoder().encode(userInfo)
                        UserDefaults.standard.set(data, forKey: "userInfo")
                    } catch {
                        print("Unable to Encode Note (\(error))")
                    }
                }
                completionBlock(true)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
