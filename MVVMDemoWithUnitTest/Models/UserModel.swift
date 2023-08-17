//
//  UserModel.swift
//  MVVMDemoWithUnitTest
//
//  Created by rafiul hasan on 15/8/23.
//

import Foundation

struct UserModel: Codable {
    var uid: String
    let username: String
    let email: String
    let password: String
}
