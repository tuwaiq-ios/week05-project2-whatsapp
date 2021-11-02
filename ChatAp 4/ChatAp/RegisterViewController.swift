//
//  RegisterViewController.swift
//  
//
//  Created by sally asiri on 26/03/1443 AH.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController , UITextFieldDelegate {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
      }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        return imageView
    }()
    private let firstNameField: UITextField = {
      let field = UITextField()
      field.autocapitalizationType = .none
      field.autocorrectionType = .no
      field.returnKeyType = .continue
      field.layer.cornerRadius = 12
      field.layer.borderWidth = 1
      field.layer.borderColor = UIColor.lightGray.cgColor
      field.placeholder = "First Name..."
      field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
      field.leftViewMode = .always
      field.backgroundColor = .secondarySystemBackground
      return field
    }()
    private let lastNameField: UITextField = {
      let field = UITextField()
      field.autocapitalizationType = .none
      field.autocorrectionType = .no
      field.returnKeyType = .continue
      field.layer.cornerRadius = 12
      field.layer.borderWidth = 1
      field.layer.borderColor = UIColor.lightGray.cgColor
      field.placeholder = "Last Name..."
      field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
      field.leftViewMode = .always
      field.backgroundColor = .secondarySystemBackground
      return field
    }()
    private let emailField: UITextField = {
      let field = UITextField()
      field.autocapitalizationType = .none
      field.autocorrectionType = .no
      field.returnKeyType = .continue
      field.layer.cornerRadius = 12
      field.layer.borderWidth = 1
      field.layer.borderColor = UIColor.lightGray.cgColor
      field.placeholder = "Email Address..."
      field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
      field.leftViewMode = .always
      field.backgroundColor = .secondarySystemBackground
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
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
      field.placeholder = "Password..."
      field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
      field.leftViewMode = .always
      field.backgroundColor = .secondarySystemBackground
      field.isSecureTextEntry = true
      return field
    }()
    
    private let RegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
        style: .done,target: self, action: #selector(didTapRegister))
    
        RegisterButton.addTarget(self, action: #selector(RegisterButtonTapp), for: .touchUpInside)
        
        
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(RegisterButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        let gesture = UIGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic() {
       print("change pic Called")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x:(scrollView.width-size)/2,
                                 y:20,
                                 width:size,
                                 height:size)
        imageView.layer.cornerRadius = imageView.width/3.0
        firstNameField.frame = CGRect(x:30,
                                  y:imageView.bottom+10,
                                  width:scrollView.width-60,
                                 height:52)
        lastNameField.frame = CGRect(x:30,
                                  y:firstNameField.bottom+10,
                                  width:scrollView.width-60,
                                 height:52)
        emailField.frame = CGRect(x:30,
                                  y:lastNameField.bottom+10,
                                  width:scrollView.width-60,
                                 height:52)
        passwordField.frame = CGRect(x:30,
                                  y:emailField.bottom+10,
                                  width:scrollView.width-60,
                                 height:52)
   
        RegisterButton.frame = CGRect(x:30,
                                  y:passwordField.bottom+10,
                                  width:scrollView.width-60,
                                 height:52)
    }
    @objc private func RegisterButtonTapp() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
             let email = emailField.text ,
              let password = passwordField.text ,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty, password.count >= 6
        else {
            alertuseLogginError()
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email , password: password, completion: {[weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let result = authResult, error == nil else {
            print("error")
            return
            }
            let user = result.user
            print("created user: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    func alertuseLogginError() {
        let alert = UIAlertController(title: "😊", message: "please enter all information to log in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            RegisterButtonTapp()
        }
        return true
    }
}
