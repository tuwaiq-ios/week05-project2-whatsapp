//
//  RegisterScreen.swift
//  chat-app
//
//  Created by M.alqahtani on 23/03/1443 AH.
//

import UIKit
import GoogleSignIn
import Firebase

class RegisterVC: UIViewController {
    
    let db =  Firestore.firestore()
    
    let subTitLbl: UILabel = {
        let title = UILabel()
        title.text = "Abha Swift"
        title.textColor = .label
        title.font = UIFont.systemFont(ofSize: 15, weight: .light)
        title.backgroundColor = .lightGray
        title.layer.cornerRadius = 12
        title.layer.masksToBounds = true
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("continue with google account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        setupBtn()
        setupLbl()
    }
    
    private func setupBtn() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
    }
    
    private func setupLbl() {
        
        subTitLbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subTitLbl)
        subTitLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 750).isActive = true
        subTitLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitLbl.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    @objc private func signInButtonPressed() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { results, error in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                guard let res = results else {return}

                guard let userFullName = res.user.displayName else {return}
                self.db.collection("Users").document(userFullName).setData([
                    "full name": userFullName,
                    "uuid": UUID().uuidString,
                    "isOnline": "yes"
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
