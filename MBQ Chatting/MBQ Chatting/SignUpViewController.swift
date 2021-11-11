//
//  ViewController.swift
//  whatsApp
//
//  Created by m.alqahtani on 25/03/1443 AH.

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
		$0.backgroundColor = .systemPink
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
		print("123")

		if let email = emailTextField.text,
		   let password = passwordTextField.text,
		   let name = nameTextField.text {
			Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
				if let e = error {
					print(e)
				} else {
					print("123")
					
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

