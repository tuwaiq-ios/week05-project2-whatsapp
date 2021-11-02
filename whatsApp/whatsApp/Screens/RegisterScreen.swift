//
//  RegisterScreen.swift
//  whatsApp
//
//  Created by Maram Al shahrani on 24/03/1443 AH.
//



import UIKit
import GoogleSignIn
import Firebase
class RegisterScreen: UIViewController {
    

    let db =  Firestore.firestore()
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Whats App"
        title.textColor = .label
        title.font = UIFont.systemFont(ofSize: 49, weight: .bold)
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    let subTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "The easiest chat for thousands of people."
        title.textColor = .label
        title.font = UIFont.systemFont(ofSize: 19, weight: .thin)
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
       
        setupButton()
        setupLabels()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let currentUser = Auth.auth().currentUser else {return}
        db.collection("Users").document(currentUser.displayName!).setData([
            "isOnline": "yes",
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                
            }
        }
    }
    
    private func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
    }
    
    private func setupLabels() {
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subTitleLabel)
        
        subTitleLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -45).isActive = true
        subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -8).isActive = true
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
                ], merge: true) { err in
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

