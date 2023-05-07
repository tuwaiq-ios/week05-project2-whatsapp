//
//  ProfileController.swift
//  whatsApp- hanan
//
//  Created by  HANAN ASIRI on 28/03/1443 AH.
//

import UIKit
import Firebase
class ProfileController: UIViewController {
  lazy var image :UIImageView = {
    let image = UIImageView()
    image.layer.cornerRadius = 50
    image.layer.borderColor = UIColor.blue.cgColor
    image.layer.borderWidth = 1
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  lazy var text : UITextField = {
    let text = UITextField()
    text.placeholder = "Enter Your Bio"
    text.textAlignment = .center
    text.translatesAutoresizingMaskIntoConstraints = false
    return text
  }()
  lazy var name : UILabel = {
    let text = UILabel()
    text.font = .boldSystemFont(ofSize: 15)
    text.textColor = .blue
    text.translatesAutoresizingMaskIntoConstraints = false
    return text
  }()
  lazy var saveButton : UIButton = {
    let button = UIButton()
    button.tintColor = .white
    button.backgroundColor = .blue
    button.layer.cornerRadius = 25
    button.setTitle("Save", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    view.backgroundColor = .white
    checkIfUserIsLoggedIn()
  }
  func setup() {
    view.addSubview(image)
    view.addSubview(name)
    view.addSubview(text)
    view.addSubview(saveButton)
    image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    image.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    image.widthAnchor.constraint(equalToConstant: 100).isActive = true
    image.heightAnchor.constraint(equalToConstant: 100).isActive = true
    name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
    name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50).isActive = true
    name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
    text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
    text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50).isActive = true
    text.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 50).isActive = true
    saveButton.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 50).isActive = true
    saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    saveButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  }
  func checkIfUserIsLoggedIn() {
    if !(Auth.auth().currentUser?.uid == nil) {
      fetchUserAndSetupNavBarTitle()
    }
  }
  func fetchUserAndSetupNavBarTitle() {
    guard let uid = Auth.auth().currentUser?.uid else {
      //for some reason uid = nil
      return
    }
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      if let dictionary = snapshot.value as? [String: AnyObject] {
        //        self.navigationItem.title = dictionary[“name”] as? String
        let user = User(dictionary: dictionary)
        self.setupNavBarWithUser(user)
      }
    }, withCancel: nil)
  }
  func setupNavBarWithUser(_ user: User) {
    if let profileImageUrl = user.profileImageUrl {
      image.loadImageUsingCacheWithUrlString(profileImageUrl)
    }
    name.text = user.name
    let nameLabel = UILabel()
  }
}
