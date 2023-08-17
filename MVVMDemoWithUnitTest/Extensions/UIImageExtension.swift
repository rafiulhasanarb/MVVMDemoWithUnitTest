//
//  UIImageExtension.swift
//  MVVMDemoWithUnitTest
//
//  Created by rafiul hasan on 15/8/23.
//

import UIKit
import Foundation

extension UIImage {
    static func localImage(_ name: String, template: Bool = false) -> UIImage {
        var image = UIImage(named: name)!
        if template {
            image = image.withRenderingMode(.alwaysTemplate)
        }
        return image
    }
}
