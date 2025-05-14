//
//  Utility.swift
//  RBSNews
//
//  RBS Tests Project on 12/10/20.
//

import Foundation
import UIKit

class Utility {
    
    static let shared = Utility()
    private init() {}
    
    func showAlert(_ viewController:UIViewController, _ title:String, _ message:String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		viewController.present(alertVC, animated: true, completion: nil)
    }
}
