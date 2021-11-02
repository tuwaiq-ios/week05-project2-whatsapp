//
//  Profile.swift
//  WhatsChatApp
//
//  Created by Ahmed Assiri on 27/03/1443 AH.
//

import UIKit
import Firebase

class Profile : UIViewController{
    
    
    
    
    var img: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "41")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let name1 : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "name here"
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    let status : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = " status here "
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    let Button : UIButton = {
        $0.backgroundColor = .darkGray
        $0.setTitle("Save", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(B), for: .touchUpInside)
        return $0
    }(UIButton())
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(img)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            img.heightAnchor.constraint(equalToConstant: 80),
            img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
        
        
        
        name1.font = .boldSystemFont(ofSize: 23)
        name1.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(name1)
        NSLayoutConstraint.activate([
            
            name1.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
            name1.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 20),
            name1.heightAnchor.constraint(equalToConstant: 40),
            name1.widthAnchor.constraint(equalToConstant: 290),
            //name1.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
        ])
        
        
        
        
        status.textColor = .green
        status.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(status)
        NSLayoutConstraint.activate([
            
            status.topAnchor.constraint(equalTo: view.topAnchor,constant: 140),
            status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 20),
            status.heightAnchor.constraint(equalToConstant: 40),
            status.widthAnchor.constraint(equalToConstant: 290),
        ])
        
        
        
        view.addSubview(Button)
        
        NSLayoutConstraint.activate([
            Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            Button.heightAnchor.constraint(equalToConstant: 70)
            
        ])
        
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore()
            .document("users/\(currentUserID)")
            .addSnapshotListener{ doucument, error in
                if error != nil {
                    print (error)
                    return
                }
                
                self.name1.text = doucument?.data()?["name"] as? String
                self.status.text = doucument?.data()?["status"] as? String
                
                
            }
        
    }
    @objc func B() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().document("users/\(currentUserID)").updateData([
            "name" : name1.text,
            "uID" : currentUserID,
            "status" :status.text,
            
        ])
        
        
    }
}

