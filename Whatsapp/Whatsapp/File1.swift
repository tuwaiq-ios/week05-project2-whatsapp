//
//  File1.swift
//  Whatsapp
//
//  Created by Fawaz on 01/11/2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
  //=============================================================================
  var profileImage = UIImageView()
  var name = UITextField()
  var email = UITextField()
  var password = UITextField()
  var conf = UITextField()
  
  var segment = UISegmentedControl()
  var remLabel = UILabel()
  var rememberlogo = UIButton()
  var rem: Bool! = false
  var openimage = UIButton()
  var registerSingUp = UIButton()
  var registerLogin = UIButton()
  //=============================================================================
  @objc func Segment(_ sender: Any) {
    
    switch segment.selectedSegmentIndex {
    
    case 0:
      name.isHidden = true
      conf.isHidden = true
      registerSingUp.isHidden = true
      registerLogin.isHidden = false
      
    case 1:
      name.isHidden = false
      conf.isHidden = false
      registerSingUp.isHidden = false
      registerLogin.isHidden = true
      
    default:
      break;
    }
  }
  //=============================================================================
  @objc func OpenImage(_ sender: Any) {
    let pick = UIImagePickerController()
    pick.allowsEditing = true
    pick.delegate = self
    present(pick, animated: true)
  }
  //=============================================================================
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage;
    
    profileImage.image = image
    dismiss(animated: false)
  }
  //=============================================================================
  @objc func Remember(_ sender: Any) {
    
    if (rem == false){
      rememberlogo.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
      rem = true
    }
    else if (rem == true){
      rememberlogo.setImage(UIImage(systemName: "circle.dashed"), for: .normal)
      rem = false
    }
  }
  //=============================================================================
  @objc func SingUp(_ sender: Any) {
    let namee = name.text ?? ""
    let emaill = email.text ?? ""
    let passwordd = password.text ?? ""
    let conff = conf.text ?? ""
    
    UserDefaults.standard.set(namee, forKey: "na")
    UserDefaults.standard.set(emaill, forKey: "em")
    UserDefaults.standard.set(passwordd, forKey: "pa")
    UserDefaults.standard.set(conff, forKey: "co")
    
    if (rem == true){
      UserDefaults.standard.set("0", forKey: "t")
    }
    else{
      UserDefaults.standard.set("1", forKey: "f")
    }
    
    if
      let name = name.text, name.isEmpty == false,
      let email = email.text, email.isEmpty == false,
      let password = password.text, password.isEmpty == false,
      let conf = conf.text, conf.isEmpty == false {
      
      Auth.auth().createUser(withEmail: email, password: password) { result, error in
          if error == nil {
            let vc = UINavigationController(rootViewController: TabVC())
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
          
        } else {
            print(error?.localizedDescription)
            }
        }
    }
  }
  //=============================================================================
  @objc func Login(_ sender: Any) {
    
    let emaill = email.text ?? ""
    let passwordd = password.text ?? ""
    
    UserDefaults.standard.set(emaill, forKey: "em")
    UserDefaults.standard.set(passwordd, forKey: "pa")
    
    if (rem == true){
      UserDefaults.standard.set("0", forKey: "t")
    }
    else{
      UserDefaults.standard.set("1", forKey: "f")
    }
    
    if
      let email = email.text, email.isEmpty == false,
      let password = password.text, password.isEmpty == false {
        
      Auth.auth().signIn(withEmail: email, password: password) { result, error in
        if error == nil {
          let vc = UINavigationController(rootViewController: TabVC())
          vc.modalTransitionStyle = .crossDissolve
          vc.modalPresentationStyle = .fullScreen
          self.present(vc, animated: true, completion: nil)
      } else {
          print(error?.localizedDescription)
      }
      }
    }
  }
  //=============================================================================
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    name.delegate = self
    email.delegate = self
    password.delegate = self
    conf.delegate = self
    
    name.text = UserDefaults.standard.value(forKey: "na") as? String
    email.text = UserDefaults.standard.value(forKey: "em") as? String
    password.text = UserDefaults.standard.value(forKey: "pa") as? String
    conf.text = UserDefaults.standard.value(forKey: "co") as? String
    
    if UserDefaults.standard.string(forKey: "rem") == "1" {
      
      if (rem == false){
        rememberlogo.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        rem = true
      }
      else if (rem == true){
        rememberlogo.setImage(UIImage(systemName: "circle.dashed"), for: .normal)
        rem = false
      }
    }
    //------------------------------------------------------------------------
    segment.insertSegment(withTitle: "Login", at: 0, animated: true)
    segment.setTitle("Login", forSegmentAt: 0)
    
    segment.insertSegment(withTitle: "Rigester", at: 1, animated: true)
    segment.setTitle("Sinup", forSegmentAt: 1)
    
    segment.addTarget(self, action: #selector(Segment), for: .valueChanged)
    
    segment.translatesAutoresizingMaskIntoConstraints = false
    segment.selectedSegmentIndex = 0
    Segment(1)
    
    view.addSubview(segment)
    
    NSLayoutConstraint.activate([
      segment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      segment.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
    ])
    //------------------------------------------------------------------------
    profileImage.image = .init(systemName: "person.circle")
    profileImage.tintColor = UIColor(ciColor: .black)
    profileImage.layer.masksToBounds = true
    profileImage.layer.cornerRadius = 100
    profileImage.contentMode = .scaleAspectFit
    
    profileImage.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(profileImage)
    
    NSLayoutConstraint.activate([
      profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      profileImage.topAnchor.constraint(equalTo: segment.topAnchor, constant: 50),
      profileImage.heightAnchor.constraint(equalToConstant: 200),
      profileImage.widthAnchor.constraint(equalToConstant: 200)
    ])
    //------------------------------------------------------------------------
    name.placeholder = "Name"
    name.textAlignment = .center
    name.translatesAutoresizingMaskIntoConstraints = false
    name.textColor = .black
    name.font = UIFont.systemFont(ofSize: 18)
    name.backgroundColor = .systemGray5
    
    view.addSubview(name)
    
    NSLayoutConstraint.activate([
      name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
      name.widthAnchor.constraint(equalToConstant: 300)
    ])
    //------------------------------------------------------------------------
    email.placeholder = "Email"
    email.textAlignment = .center
    email.translatesAutoresizingMaskIntoConstraints = false
    email.textColor = .black
    email.font = UIFont.systemFont(ofSize: 18)
    email.backgroundColor = .systemGray5
    
    view.addSubview(email)
    
    NSLayoutConstraint.activate([
      email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16),
      email.widthAnchor.constraint(equalToConstant: 300)
    ])
    //------------------------------------------------------------------------
    password.placeholder = "Password"
    password.textAlignment = .center
    password.translatesAutoresizingMaskIntoConstraints = false
    password.textColor = .black
    password.font = UIFont.systemFont(ofSize: 18)
    password.backgroundColor = .systemGray5
    
    view.addSubview(password)
    
    NSLayoutConstraint.activate([
      password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 16),
      password.widthAnchor.constraint(equalToConstant: 300)
    ])
    //------------------------------------------------------------------------
    conf.placeholder = "Conf Password"
    conf.textAlignment = .center
    conf.translatesAutoresizingMaskIntoConstraints = false
    conf.textColor = .black
    conf.font = UIFont.systemFont(ofSize: 18)
    conf.backgroundColor = .systemGray5
    
    view.addSubview(conf)
    
    NSLayoutConstraint.activate([
      conf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      conf.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 16),
      conf.widthAnchor.constraint(equalToConstant: 300)
    ])
    //------------------------------------------------------------------------
    remLabel.text = "Remeberme"
    remLabel.translatesAutoresizingMaskIntoConstraints = false
    remLabel.textColor = .black
    remLabel.font = UIFont.systemFont(ofSize: 20)
    
    view.addSubview(remLabel)
    
    NSLayoutConstraint.activate([
      remLabel.rightAnchor.constraint(equalTo: conf.rightAnchor, constant: 0),
      remLabel.topAnchor.constraint(equalTo: conf.bottomAnchor, constant: 16),
      remLabel.widthAnchor.constraint(equalToConstant: 250)
    ])
    //------------------------------------------------------------------------
    let imagex = UIImage(systemName: "circle.dashed")
    
    rememberlogo.setImage(imagex, for: .normal)
    
    rememberlogo.translatesAutoresizingMaskIntoConstraints = false
    rememberlogo.contentMode = .scaleAspectFit
    
    rememberlogo.addTarget(self, action: #selector(Remember), for: .touchUpInside)
    
    view.addSubview(rememberlogo)
    
    NSLayoutConstraint.activate([
      rememberlogo.rightAnchor.constraint(equalTo: remLabel.leftAnchor, constant: -20),
      rememberlogo.topAnchor.constraint(equalTo: conf.bottomAnchor, constant: 16),
      rememberlogo.heightAnchor.constraint(equalToConstant: 30),
      rememberlogo.widthAnchor.constraint(equalToConstant: 30),
    ])
    //------------------------------------------------------------------------

    openimage.setTitle("Add Image", for: .normal)
    openimage.backgroundColor = .systemBlue
    openimage.setTitleColor(UIColor.white, for: .normal)
    openimage.translatesAutoresizingMaskIntoConstraints = false
    
    openimage.addTarget(self, action: #selector(OpenImage), for: .touchUpInside)
    
    openimage.layer.masksToBounds = true
    openimage.layer.cornerRadius = 20
    view.addSubview(openimage)
    
    NSLayoutConstraint.activate([
      openimage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      openimage.topAnchor.constraint(equalTo: rememberlogo.bottomAnchor, constant: 16),
      openimage.heightAnchor.constraint(equalToConstant: 50),
      openimage.widthAnchor.constraint(equalToConstant: 300),
    ])
    //------------------------------------------------------------------------
    registerSingUp.setTitle("SingUp", for: .normal)
    registerSingUp.backgroundColor = .red
    registerSingUp.setTitleColor(UIColor.white, for: .normal)
    registerSingUp.translatesAutoresizingMaskIntoConstraints = false
    
    registerSingUp.addTarget(self, action: #selector(SingUp), for: .touchUpInside)
    
    registerSingUp.layer.masksToBounds = true
    registerSingUp.layer.cornerRadius = 20
    view.addSubview(registerSingUp)
    
    NSLayoutConstraint.activate([
      registerSingUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      registerSingUp.topAnchor.constraint(equalTo: openimage.bottomAnchor, constant: 16),
      registerSingUp.heightAnchor.constraint(equalToConstant: 50),
      registerSingUp.widthAnchor.constraint(equalToConstant: 300),
    ])
    //----------------------------------------------------------------
    registerLogin.setTitle("Login", for: .normal)
    registerLogin.backgroundColor = .orange
    registerLogin.setTitleColor(UIColor.white, for: .normal)
    registerLogin.translatesAutoresizingMaskIntoConstraints = false
    
    registerLogin.addTarget(self, action: #selector(Login), for: .touchUpInside)
    
    registerLogin.layer.masksToBounds = true
    registerLogin.layer.cornerRadius = 20
    view.addSubview(registerLogin)
    
    NSLayoutConstraint.activate([
      registerLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      registerLogin.topAnchor.constraint(equalTo: openimage.bottomAnchor, constant: 16),
      registerLogin.heightAnchor.constraint(equalToConstant: 50),
      registerLogin.widthAnchor.constraint(equalToConstant: 300),
    ])
  }
  //=============================================================================
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    name.resignFirstResponder()
    email.resignFirstResponder()
    password.resignFirstResponder()
    conf.resignFirstResponder()
    
    return true
  }
}
