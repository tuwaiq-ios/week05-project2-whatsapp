//
//  ProfileViewController.swift
//  Project 6 WhatsApp Atheer Alzahrani
//
//  Created by Eth Os on 23/03/1443 AH.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController{
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let nameTextFeild: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.backgroundColor = .clear
        field.layer.borderColor = UIColor.white.cgColor
        field.text = "Here User Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.textColor = .white
        return field
    }()
    
    let statusTextFeild: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.backgroundColor = .clear
        field.layer.borderColor = UIColor.white.cgColor
        field.text = "Here User Status"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.textColor = .white
        return field
    }()
    
    let data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = createTableHeader()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //add table to view
       view.addSubview(tableView)
        // add constraint
       NSLayoutConstraint.activate([
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 16),
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        tableView.topAnchor.constraint(equalTo: view.topAnchor , constant: 100.0),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -16)
           ])
    }
    
    func createTableHeader() -> UIView? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return nil
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let filename = safeEmail + "_profile_picture.png"
        let path = "images/" + filename
         
        let userName = UserDefaults.standard.value(forKey: "name") as? String
        nameTextFeild.text = userName
        
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.view.width,
                                        height: 400))
        
        view.backgroundColor = UIColor(red: 92.0/255.0, green: 205.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        
        let imageView = UIImageView(frame: CGRect(x: (view.width-175) / 2 ,
                                                  y: 75,
                                                  width: 150,
                                                  height: 150))
        nameTextFeild.frame = CGRect(x: 30,
                                     y: imageView.bottom+10,
                                     width: view.width-90,
                                     height: 52)
        statusTextFeild.frame = CGRect(x: 30,
                                     y: nameTextFeild.bottom+10,
                                     width: view.width-90,
                                     height: 52)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = imageView.width / 2
        imageView.layer.masksToBounds = true
        view.addSubview(imageView)
        view.addSubview(nameTextFeild)
        view.addSubview(statusTextFeild)
        
        StorageManager.shares.downloadURL(for: path, completion: { [weak self] result in
            switch result {
            case .success(let url):
                self?.downloadImage(imageView: imageView, url: url)
            case .failure(let error):
                print("Failed to get download url: \(error)")
            }
        })
        
        return view
    }
    
    func downloadImage(imageView: UIImageView, url: URL){
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }).resume()
    }
}

extension ProfileViewController:  UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
                                    
            guard let strongSelf = self else {
                return
            }
            
            
            do{
                try FirebaseAuth.Auth.auth().signOut()
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
                
            }catch{
                print("Faild to log out")
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
}
