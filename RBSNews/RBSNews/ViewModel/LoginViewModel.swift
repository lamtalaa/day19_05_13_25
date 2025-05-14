//
//  LoginViewModel.swift
//  RBSNews
//
//  Created by Mac on 13/05/25.
//

import Foundation

class LoginViewModel {
    
    let expectedUsername = "rbs"
    let expectedPassword = "1234"
    
    weak var delegate: LoginViewControllerProtocol?
    func validateCredentails(name: String?, pass: String?) {
        
        let message = validate(name: name, pass: pass)
        
        if !message.isEmpty {
            delegate?.showErrorMessage(message)
        }else {
            delegate?.navigateToHomeScreen()
        }
    }
    
    func validate(name: String?, pass: String?)-> String {
        guard let username = name, !username.isEmpty, let password = pass, !password.isEmpty else {
           return "Please input credentials."
        }
       
       guard expectedUsername == username else {
          return "Username is invalid"
       }
       
       guard expectedPassword == password else {
         return "Password is invalid"
       }
        return ""
    }
}
