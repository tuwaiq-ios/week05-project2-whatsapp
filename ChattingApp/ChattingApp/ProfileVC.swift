//
//  ProfileVC.swift
//  ChattingApp
//
//  Created by Abdulaziz on 25/03/1443 AH.
//


import UIKit
import Firebase

class ProfileVC : UIViewController{
    
    
    

    var img: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pic")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let name1 : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Write your name"
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    let status : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Write your status"
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    let Button : UIButton = {
        $0.backgroundColor = .blue
        $0.setTitle("Save", for: .normal)
        $0.tintColor = .black
        $0.layer.cornerRadius = 22.5
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(B), for: .touchUpInside)
        return $0
    }(UIButton())
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Image11")
        self.view.insertSubview(backgroundImage, at: 0)
        
       
        //view.backgroundColor = .white

        view.addSubview(img)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -140),
            img.heightAnchor.constraint(equalToConstant: 110),
            img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 140/140),
        ])
            
        
        
        
        name1.font = .boldSystemFont(ofSize: 18)
        name1.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(name1)
        NSLayoutConstraint.activate([
            
            name1.topAnchor.constraint(equalTo: view.topAnchor,constant: 180),
            name1.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 50),
            name1.heightAnchor.constraint(equalToConstant: 40),
            name1.widthAnchor.constraint(equalToConstant: 290),
            //name1.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
        ])
        
        
        status.textColor = .green
        status.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(status)
        NSLayoutConstraint.activate([
            
            status.topAnchor.constraint(equalTo: view.topAnchor,constant: 250),
            status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 50),
            status.heightAnchor.constraint(equalToConstant: 40),
            status.widthAnchor.constraint(equalToConstant: 290),
        ])
        
        
        view.addSubview(Button)
        
        NSLayoutConstraint.activate([
            Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
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
        Firestore.firestore().document("users/waleed").setData([
            
            "name" : name1.text,
            "uID" : currentUserID,
            "status" :status.text,
            
        ])
    }
    
    }

