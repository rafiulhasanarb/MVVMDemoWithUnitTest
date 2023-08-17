//
//  UserInfoServices.swift
//  MVVMDemoWithUnitTest
//
//  Created by rafiul hasan on 17/8/23.
//


import Firebase
import Foundation

class UserInfoServices: NSObject {
    private var db = Firestore.firestore()
    
    func createUser(user: UserModel, completion: @escaping (_ userInfo: UserModel?, _ error: Error?) -> Void) {
        db.collection("users").document(user.uid).setData(["username": user.username, "email": user.email, "password": user.password])
        completion(user, nil)
    }
    
    func fetchUser(userId: String, completion: @escaping (_ userInfo: UserModel?, _ error: Error?) -> Void) {
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            guard let data = snapshot?.data() else { return }
            if let error = error {
                completion(nil, error)
            } else {
                completion(UserModel(uid: snapshot!.documentID, username: data["username"] as! String, email: data["email"] as! String, password: data["password"] as! String), nil)
            }
        }
    }
}
