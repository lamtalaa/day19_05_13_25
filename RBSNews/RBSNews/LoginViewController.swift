//
//  ViewController.swift
//  RBSNews
//
//  RBS Tests Project on 12/10/20.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func navigateToHomeScreen()
    func showErrorMessage(_ message: String)
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        self.title = "Login screen"
    }


    @IBAction func loginButtonTapped(_ sender: UIButton) {
         viewModel.validateCredentails(name: usernameTextField.text, pass: passwordTextField.text)
    }
    
    func navigateToHomeScreen1() {
        if let newsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewsViewController") as? NewsViewController {
            if let navigation = navigationController {
                navigation.pushViewController(newsViewController, animated: true)
            }
        }
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func navigateToHomeScreen() {
        self.navigateToHomeScreen1()
    }
    
    func showErrorMessage(_ message: String) {
        Utility.shared.showAlert(self, "Alert!", message)
    }
}
