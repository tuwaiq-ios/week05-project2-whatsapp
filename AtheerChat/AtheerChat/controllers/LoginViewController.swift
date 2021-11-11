//
//  LoginViewController.swift
//  AtheerChat
//
//  Created by Eth Os on 06/04/1443 AH.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let emailField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email ... "
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.textColor = .black
        return field
    }()
    
    private let passwordField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password ... "
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        field.textColor = .black
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(red: 92.0/255.0, green: 205.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(registerBtnPressed), for: .touchUpInside)

        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            emailField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            emailField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 24),
            passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            passwordField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 48),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func registerBtnPressed() {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error as Any)
                return
            }
            let navVC = UINavigationController(rootViewController: TabViewController())
            self.present(navVC, animated: true, completion: nil)
        }
        
    }
    @objc func loginBtnPressed() {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            let navVC = UINavigationController(rootViewController: TabViewController())
            self.present(navVC, animated: true, completion: nil)
        }
        
    }
    
    
}
