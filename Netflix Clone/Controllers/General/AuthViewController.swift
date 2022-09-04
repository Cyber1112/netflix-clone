//
//  AuthViewController.swift
//  Netflix Clone
//
//  Created by Khakim Zhumagaliyev on 03.09.2022.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    private let label: UILabel = {
           let label = UILabel()
            label.textAlignment = .center
            label.text = "Log In"
            label.font = .systemFont(ofSize: 24, weight: .semibold)
            return label
        }()
        
        private let emailField: UITextField = {
            let emailField = UITextField()
            emailField.placeholder = "Email"
            emailField.layer.borderWidth = 1
            emailField.layer.borderColor = UIColor.black.cgColor
            return emailField
        }()
        
        private let passwordField: UITextField = {
            let passwordField = UITextField()
            passwordField.placeholder = "Password"
            passwordField.layer.borderWidth = 1
            passwordField.isSecureTextEntry = true
            passwordField.layer.borderColor = UIColor.black.cgColor
            return passwordField
        }()
        
        private let button: UIButton = {
            let button = UIButton()
            button.backgroundColor = .systemGreen
            button.setTitleColor(.white, for: .normal)
            button.setTitle("Log in", for: .normal)
            return button
        }()
        
        

        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(label)
            view.addSubview(emailField)
            view.addSubview(passwordField)
            view.addSubview(button)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
            emailField.frame = CGRect(x: 20, y: label.frame.origin.y+label.frame.size.height+10, width: view.frame.size.width-40, height: 50)
            passwordField.frame = CGRect(x: 20, y: emailField.frame.origin.y+emailField.frame.size.height+10, width: view.frame.size.width-40, height: 50)
            button.frame = CGRect(x: 20, y: passwordField.frame.origin.y+passwordField.frame.size.height+30, width: view.frame.size.width-40, height: 52)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            emailField.becomeFirstResponder()
        }
        
        @objc private func didTapButton(){
            guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !email.isEmpty else {
                    print("Missing Data")
                    return
            }
            
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                
                guard error == nil else {
                    strongSelf.showCreateAccount(email: email, password: password)
                    return
                }
                print("You have signed in")
                
                let vc = MainTabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                strongSelf.present(vc, animated: true)
                
                
            })
        }
        func showCreateAccount(email: String, password: String){
            let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result, error in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    guard error == nil else {
                        print("Account Creation Failed")
                        return
                    }
                    
                    strongSelf.navigationController?.pushViewController(MainTabBarViewController(), animated: true)
                    
                    print("You have signed in")
                    let vc = MainTabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    strongSelf.present(vc, animated: true)
                    
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                
            }))
            
            present(alert, animated: true)
        }


}
