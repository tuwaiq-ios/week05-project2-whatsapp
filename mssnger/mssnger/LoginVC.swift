//
//  LoginVC.swift
//  chatchat
//
//  Created by sally asiri on 05/04/1443 AH.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    
    
    var name = UITextField()
    var conf = UITextField()
    let segmentedControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        name.placeholder = "Name"
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18)
        name.backgroundColor = .systemGray5
        name.layer.cornerRadius = 22.5
        
        
        conf.placeholder = "Conf Password"
        conf.textAlignment = .center
        conf.translatesAutoresizingMaskIntoConstraints = false
        conf.textColor = .black
        conf.font = UIFont.systemFont(ofSize: 18)
        conf.backgroundColor = .systemGray5
        conf.layer.cornerRadius = 22.5
        
        
        
    }
    
    
    
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "40")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let email : UITextField = {
        $0.placeholder = "email"
        //$0.text = "mssomf@hotmail.com"
        $0.textAlignment = .center
        $0.backgroundColor = .init(white: 0.90, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    
    
    let password : UITextField = {
        $0.placeholder = "password"
       // $0.text = "123456"
        $0.isSecureTextEntry = true
        $0.textAlignment = .center
        $0.backgroundColor = .init(white: 0.90, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    
    let logInButton : UIButton = {
        $0.setTitle("LogIn", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 22.5
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(login), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    let signUp : UIButton = {
        $0.setTitle("Sign Up", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 22.5
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(SignupVC), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    
    let stackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    
    @objc func login() {
        if let email = email.text, email.isEmpty == false,
           let password = password.text, password.isEmpty == false {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    // go to main vc
                    let vc = UINavigationController(rootViewController: TabVC())
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
        
    }
    
    
    @objc func SignupVC(_ sender: Any) {
       
        
        
        if let email = email.text, email.isEmpty == false,
           let password = password.text, password.isEmpty == false {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    // go to main vc
                    let vc = UINavigationController(rootViewController: TabVC())
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print(error?.localizedDescription)
                }
                guard let currentUserID = Auth.auth().currentUser?.uid else {return}
                Firestore.firestore().document("users/\(currentUserID)").setData([
                    "name" : self.name.text,
                    "id" : currentUserID,
                    "email" : self.email.text,
                    "status" : "online"
                ], merge : true)
            }
        }
        
    }
    
}

extension LoginVC {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(conf)
        stackView.addArrangedSubview(logInButton)
        stackView.addArrangedSubview(signUp)
        
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 90),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        
        segmentedControl.insertSegment(withTitle: "Rigester", at: 0, animated: true)
        segmentedControl.setTitle("Rigester", forSegmentAt: 0)
        segmentedControl.insertSegment(withTitle: "Login", at: 1, animated: true)
        segmentedControl.setTitle("Login", forSegmentAt: 1)
        
        segmentedControl.addTarget(self, action: #selector(Segment), for: .valueChanged)
        
        
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 250),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.heightAnchor.constraint(equalToConstant: 270)
        ])
        
        
    }
    @objc func Segment(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            name.isHidden = false
            conf.isHidden = false
            signUp.isHidden = false
            logInButton.isHidden = true
        case 1:
            name.isHidden = true
            conf.isHidden = true
            signUp.isHidden = true
            logInButton.isHidden = false
        default:
            break;
        }
    }
}

