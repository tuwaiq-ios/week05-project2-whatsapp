///
//  SignUpViewController.swift
//  ChatApp4
//
//  Created by Tsnim Alqahtani on 26/03/1443 AH.
//


import UIKit
import Firebase

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    let nameTextField : UITextField = {
        $0.placeholder = "Name"
        $0.textAlignment = .center
        $0.backgroundColor = .init(white: 0.90, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    let emailTextField : UITextField = {
        $0.placeholder = "E-mail"
        $0.textAlignment = .center
        $0.backgroundColor = .init(white: 0.90, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    
    let passwordTextField : UITextField = {
        $0.placeholder = "Password"
        $0.isSecureTextEntry = true
        $0.textAlignment = .center
        $0.backgroundColor = .init(white: 0.90, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    
    let signUpButton : UIButton = {
        $0.setTitle("Sign Up", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 22.5
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    
    let stackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    
    @objc func signupAction() {
        
        if let email = nameTextField.text, email.isEmpty == false, let password = passwordTextField.text, password.isEmpty == false, let name = nameTextField.text, name.isEmpty == false {
           
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    // successfully added
                    guard let userID = result?.user.uid else {return}
                   
                    Firestore.firestore().document("Users/\(userID)").setData([
                        "name" : name,
                        "email" : email,
                        "userID" : userID
                    ]) { error in
                        if error == nil {
                            // go to main vc
                            let vc = UsersViewController()
                            vc.modalTransitionStyle = .crossDissolve
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                    
                    
                } else {
                    // show error message
                    
                }
            }
        }
        
        
    }

}



extension SignUpViewController {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signUpButton)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.heightAnchor.constraint(equalToConstant: 210)
        ])
    }
}
