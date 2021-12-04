//
//  Login.swift
//  Whats
//
//  Created by Ahmed Assiri on 28/03/1443 AH.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    var imgUser: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PLL")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.addSubview(imgUser)
        NSLayoutConstraint.activate([
            imgUser.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            imgUser.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgUser.heightAnchor.constraint(equalToConstant: 300),
            imgUser.widthAnchor.constraint(equalTo: imgUser.heightAnchor,multiplier: 100/100)])
        
        
    }

    
    let emailTextField : UITextField = {
        $0.placeholder = "e-mail"
        $0.text = ""
        $0.textAlignment = .center
        $0.backgroundColor = .init(white: 0.90, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    
    let passwordTextField : UITextField = {
        $0.placeholder = "password"
        $0.text = ""
        $0.isSecureTextEntry = false
        $0.textAlignment = .center
        $0.backgroundColor = .init(white: 0.90, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    
    let logInButton : UIButton = {
        $0.setTitle("LogIn", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        $0.backgroundColor = .cyan
        $0.layer.cornerRadius = 22.5
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    let signUpButton : UIButton = {
        $0.setTitle("Sign Up", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        $0.backgroundColor = .systemCyan
        $0.layer.cornerRadius = 22.5
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(showSignupVC), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    
    let stackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    
    @objc func loginAction() {
        if let email = emailTextField.text, email.isEmpty == false, let password = passwordTextField.text, password.isEmpty == false {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    // go to main vc
                    let vc = UINavigationController( rootViewController:  TabVC())
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
        
    }

    
    @objc func showSignupVC() {
        
        

            if let email = emailTextField.text,
               let password = passwordTextField.text
                {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e)
                    } else {
                        print("123")
                        
                    }
                }
            }
            
            
        navigationController?.pushViewController(SignUpViewController(), animated: true)

        }

    }



extension LoginViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(logInButton)
        stackView.addArrangedSubview(signUpButton)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
}
