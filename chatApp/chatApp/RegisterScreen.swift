//
//  RegisterScreen.swift
//  chatApp
//
//  Created by Sana Alshahrani on 24/03/1443 AH.
//

import UIKit
import GoogleSignIn
import Firebase

class RegisterScreen: UIViewController {
    

    let db =  Firestore.firestore()
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "ChatApp"
        title.textColor = .label
        title.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    let subTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "By Twuaiq"
        title.textColor = .label
        title.font = UIFont.systemFont(ofSize: 15, weight: .light)
        title.backgroundColor = .systemGray4
        title.layer.cornerRadius = 12
        title.layer.masksToBounds = true
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Sign in with Google", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
       
        setupButton()
        setupLabels()
        
    }
    
    
    private func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
    }
    
    private func setupLabels() {
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 750).isActive = true
        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        subTitleLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -45).isActive = true
//        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
    }
    

    
    
    @objc private func signInButtonPressed() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
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
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { results, error in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                }
                //result may return nil
                
                guard let res = results else {return}
                //make new user

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
