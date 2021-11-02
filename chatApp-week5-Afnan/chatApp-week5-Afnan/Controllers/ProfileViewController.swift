//
//  ProfileViewController.swift
//  chatApp-week5-Afnan
//
//  Created by Fno Khalid on 25/03/1443 AH.
//


import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore


class ProfileViewController: UIViewController , UITextFieldDelegate {
    let db = Firestore.firestore()
    let imagePicker = UIImagePickerController()
    let storage = Storage.storage()
    
    let profileImage: UIImageView = {
        let pI = UIImageView()
        pI.clipsToBounds = true
        
        pI.contentMode = .scaleAspectFit
        pI.image = UIImage(systemName: "person.circle")
        pI.tintColor = .purple
        pI.layer.masksToBounds = true
        pI.layer.borderWidth = 2
        pI.layer.borderColor = UIColor(red: (152/255), green: (138/255), blue: (161/255), alpha: 1).cgColor
        return pI
    }()
    
    
    
    
   
    
    
    
    let userNameLabel: UITextField = {
        let name = UITextField()
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        name.textColor = .black
        name.textAlignment = .left
        name.tintColor = .purple
        name.placeholder = "Name..."
        return name
    }()
    
    let userNameStatus: UITextField = {
        let isOnline = UITextField()
        isOnline.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        isOnline.textAlignment = .left
        isOnline.textColor = .black
        isOnline.tintColor = .purple
        isOnline.placeholder = "The Status..."
        return isOnline
    }()

    
     let signOutButton: UIButton = {
        let signOutButton = UIButton(type: .system)
    
       signOutButton.setTitle("sign out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
         signOutButton.backgroundColor = UIColor(red: (122/255), green: (100/255), blue: (125/255), alpha: 1)
        signOutButton.layer.cornerRadius = 18
        signOutButton.layer.masksToBounds = true
        return signOutButton
     
    }()
    
    let saveButton: UIButton = {
       let signOutButton = UIButton(type: .system)
       
      signOutButton.setTitle("Save", for: .normal)
       signOutButton.setTitleColor(.black, for: .normal)
       signOutButton.backgroundColor = .white
       signOutButton.layer.cornerRadius = 18
       signOutButton.layer.masksToBounds = true
       return signOutButton
    
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        createTableHeader()
        setUpImage()
        setUpLabels()
        
        let savedName = UserDefaults.standard.value(forKey: "textFieldName") as? String
        userNameLabel.text = savedName
         
         let savedstatue = UserDefaults.standard.value(forKey: "textFieldst") as? String
        userNameStatus.text = savedstatue
    }
    
    @objc func saveButtonTapped(){
        var user = userNameLabel.text ?? "amal"
        if user.isEmpty {
            user = "empty"
        }
        UserDefaults.standard.set(user, forKey:"textFieldName")
        var st = userNameStatus.text ?? "amal"
        if st.isEmpty {
            st = "empty"
        }
        UserDefaults.standard.set(st, forKey:"textFieldst")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCurrentUsers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileImage.tintColor = .systemPink
        profileImage.layer.cornerRadius = profileImage.width/2.0
        profileImage.frame = CGRect(x: (view.frame.width - 150) / 2, y: 150, width: 150, height: 150)
        
    }
    
    func setUpImage() {
        profileImage.tintColor  = .systemBlue
        profileImage.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImage.addGestureRecognizer(tapRecognizer)
        
        view.addSubview(profileImage)
    }

    func setUpLabels() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant:45).isActive = true
  
        userNameStatus.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameStatus)
        userNameStatus.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16).isActive = true
        userNameStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        userNameStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        userNameStatus.heightAnchor.constraint(equalToConstant:45).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: userNameStatus.bottomAnchor, constant: 16).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -250).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant:20).isActive = true
        saveButton.addTarget(self, action: #selector(saveButtonTapped),for:.touchUpInside)
        
        
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signOutButton)
        signOutButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 70).isActive = true
        signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant:40).isActive = true
        signOutButton.addTarget(self, action: #selector( signOutButtonTapped),for:.touchUpInside)
     
    }
    
    
    @objc func signOutButtonTapped(){
        do {
          try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
        
        
        
    }
    @objc func imageTapped() {
        print("Image tapped")
        setupImagePicker()
    }
    
    func saveImageToFirestore(url: String, userFullName: String) {
       
        db.collection("Users").document(userFullName).setData([
            "userImageURL": url,
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
  
        
        
            func createTableHeader() -> UIView? {
                guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
                    return nil
                }
        
                let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
                let filename = safeEmail + "_profile_picture.png"
                let path = "images/"+filename
        
                let headerView = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: self.view.width,
                                                height: 300))
        
                headerView.backgroundColor = .link
        
                let imageView = UIImageView(frame: CGRect(x: (headerView.width-150) / 2,
                                                          y: 75,
                                                          width: 150,
                                                          height: 150))
                imageView.contentMode = .scaleAspectFill
                imageView.backgroundColor = .white
                imageView.layer.borderColor = UIColor.white.cgColor
                imageView.layer.borderWidth = 3
                imageView.layer.masksToBounds = true
             
                imageView.layer.cornerRadius = imageView.width/2
                headerView.addSubview(imageView)
        
                StorageManager.shared.downloadURL(for: path, completion: { result in
                    switch result {
                    case .success(let url):
                        imageView.sd_setImage(with: url, completed: nil)
                    case .failure(let error):
                        print("Failed to get download url: \(error)")
                    }
                })
        
                return headerView
            }
        

     func fetchCurrentUsers() {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser?.displayName else {return}
        db.collection("Users").whereField("full name", isEqualTo: currentUserName)
            .addSnapshotListener { (querySnapshot, error) in
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let userName = data["full name"] as? String,
                               let userIsOnline = data["isOnline"] as? String
                            {
                                
                                
                                DispatchQueue.main.async {
                                    self.userNameLabel.text = userName
                                    if userIsOnline == "yes" {
                                        self.userNameStatus.text =  "Online"
                                        self.userNameStatus.textColor = .systemGreen
                                    }else{
                                        self.userNameStatus.text =  "Not Online"
                                        self.userNameStatus.textColor = .systemRed
                                    }}
                            }}
                    }}
            }}
}
 
  
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true, completion: nil)
    guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
      return
    }
    self.profileImage.image = selectedImage
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
