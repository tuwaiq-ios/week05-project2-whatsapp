//
//  ProfileViewController.swift
//  Swalef
//
//  Created by MacBook on 28/03/1443 AH.
//

import Foundation
import Firebase

class ProfileViewController : UIViewController {
    
    override func viewDidLoad() {
        
        if let currentUser = Auth.auth().currentUser?.uid {
            print(currentUser)
            Firestore.firestore().collection("Users").document(currentUser).addSnapshotListener { snapshot, error in
                if error == nil {
                    
                    if let name = snapshot?["name"] as? String {
                        self.userTextField.text = name
                    }
                }
            }
        }
        
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(profileImage)
        view.addSubview(userTextField)
        view.addSubview(updateUsernameButton)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            
            userTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            userTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            userTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            userTextField.heightAnchor.constraint(equalToConstant: 45),
            
            updateUsernameButton.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 20),
            updateUsernameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            updateUsernameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            updateUsernameButton.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
    }
    
    var profileImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.tintColor = .lightGray
        return $0
    }(UIImageView())
    
    
    
    let userTextField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Username"
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.layer.cornerRadius = 22.5
        $0.backgroundColor = .init(white: 0.90, alpha: 1)
        return $0
    }(UITextField())
    
    
    let updateUsernameButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .blue
        $0.tintColor = .white
        $0.setTitle("Update", for: .normal)
        $0.layer.cornerRadius = 22.5
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        $0.addTarget(self, action: #selector(upserUsernameAction), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    
    @objc func upserUsernameAction() {
        if let currentUser = Auth.auth().currentUser?.uid {
            Firestore.firestore().collection("Users").document(currentUser).updateData(["name" : userTextField.text!]) { error in
                if error == nil {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
    }
    
    
}
