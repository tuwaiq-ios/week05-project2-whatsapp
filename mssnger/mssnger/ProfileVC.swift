//
//  ProfileVC.swift
//  mssnger
//
//  Created by Macbook on 25/03/1443 AH.
//

import UIKit
import Firebase

class ProfileVC : UIViewController{
    
    
    
    
    var img: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "41")
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
        $0.backgroundColor = .darkGray
        $0.setTitle("Save", for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(B), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let name2 = UILabel()
    let status2 = UILabel()
    
    
    
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
        
        name2.font = .boldSystemFont(ofSize: 23)
        name2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name2)
        NSLayoutConstraint.activate([
            
            name2.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
            name2.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 20),
            name2.heightAnchor.constraint(equalToConstant: 40),
            name2.widthAnchor.constraint(equalToConstant: 290),
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
        
        status2.textColor = .green
        status2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(status2)
        NSLayoutConstraint.activate([
            
            status2.topAnchor.constraint(equalTo: view.topAnchor,constant: 140),
            status2.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 20),
            status2.heightAnchor.constraint(equalToConstant: 40),
            status2.widthAnchor.constraint(equalToConstant: 290),
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
            .addSnapshotListener{Snapshot, error in
                if error != nil {
                    print (error)
                    return
                }
//               // let sh = Snapshot?.document[0].data()
//                var Value = (sh!["name"] ?? "nothing")
//                var Value1 = (sh!["uID"] ?? "\(currentUserID)")
//                var Value2 = (sh!["status"] ?? "nothing")
        
    }
    }
    

    @objc func B() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().document("users/\(currentUserID)").setData([
            "name" : name1.text,
            "uID" : currentUserID,
            "status" :status.text,
            
        ])
       
                
               // UserDefaults.standard.set("name", forKey: name1.text?)
               // UserDefaults.standard.set("status", forKey:status.text? )

    }
    }

