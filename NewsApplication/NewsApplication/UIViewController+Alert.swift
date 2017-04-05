//
//  UIViewController+Alert.swift
//  Cheetay
//
//  Created by arbisoft on 12/2/16.
//  Copyright © 2016 Cheetay. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func showOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
