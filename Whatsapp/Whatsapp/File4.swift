//
//  File4.swift
//  Whatsapp
//
//  Created by Fawaz on 01/11/2021.
//

import UIKit
import Firebase

class ProfileVC : UIViewController{
  //=============================================================================
  var img: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "person.fill")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  //=============================================================================
  let name1 : UITextField = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.placeholder = "your name"
    $0.backgroundColor = .init(.systemGray5)
    $0.layer.cornerRadius = 22
    return $0
  }(UITextField())
  //=============================================================================
  let status : UITextField = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.placeholder = " your status"
    $0.backgroundColor = .init(.systemGray5)
    $0.layer.cornerRadius = 22
    return $0
  }(UITextField())
  //=============================================================================
  let Button : UIButton = {
    $0.backgroundColor = .darkGray
    $0.setTitle("Save", for: .normal)
    $0.tintColor = .black
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.addTarget(self, action: #selector(B), for: .touchUpInside)
    return $0
  }(UIButton())
  //=============================================================================
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    //---------------------------------------------------------------------------
    view.addSubview(img)
    NSLayoutConstraint.activate([
      
      img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      img.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    //---------------------------------------------------------------------------
    name1.font = .systemFont(ofSize: 20)
    name1.translatesAutoresizingMaskIntoConstraints = false
    name1.textAlignment = .center
    
    view.addSubview(name1)
    NSLayoutConstraint.activate([
      name1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      name1.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
      
      name1.heightAnchor.constraint(equalToConstant: 50),
      name1.widthAnchor.constraint(equalToConstant: 250),
    ])
    //---------------------------------------------------------------------------
    status.font = .systemFont(ofSize: 20)
    status.textColor = .green
    status.translatesAutoresizingMaskIntoConstraints = false
    status.textAlignment = .center
    
    view.addSubview(status)
    NSLayoutConstraint.activate([
      
      status.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      status.topAnchor.constraint(equalTo: name1.bottomAnchor,constant: 50),
      
      status.heightAnchor.constraint(equalToConstant: 50),
      status.widthAnchor.constraint(equalToConstant: 250),
    ])
    //---------------------------------------------------------------------------
    view.addSubview(Button)
    
    NSLayoutConstraint.activate([
      Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      Button.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 80),
      Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
      Button.heightAnchor.constraint(equalToConstant: 70)
    ])
    //---------------------------------------------------------------------------
    guard let currentUserID = Auth.auth().currentUser?.uid else {return}
    
    Firestore.firestore()
      .document("users/\(currentUserID)")
      .addSnapshotListener {
        
        doucument, error in if error != nil {
          print (error)
          return
        }
        self.name1.text = doucument?.data()?["name"] as? String
        self.status.text = doucument?.data()?["status"] as? String
      }
  }
  //=============================================================================
  @objc func B() {
    
    guard let currentUserID = Auth.auth().currentUser?.uid else {return}
    
    Firestore.firestore()
      .document("users/\(currentUserID)")
      .updateData ([
        
        "name" : name1.text as Any,
        "uID" : currentUserID,
        "status" :status.text as Any,
      ])
  }
  //=============================================================================
}
