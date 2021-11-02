//
//  ChatScreen.swift
//  chatapp
//
//  Created by Kholod Sultan on 24/03/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase

class ChatScreen: UIViewController {
    
    var users: [User] = []
    let db = Firestore.firestore()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(ChatScreenTableViewCell.self,
                       forCellReuseIdentifier: ChatScreenTableViewCell.cellId)
        
        return table
    }()
    
    let barButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitle("profile", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chat"
        
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButton)
        barButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        
        //fetch convos
        fetchAllUsers()
        setupTableView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        barButton.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkIfUserDidntSignout()
        
    }
    @objc func addTapped() {
        print("bar button tapped")
        self.navigationController?.pushViewController(SettingsScreen(), animated: true)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.backgroundColor = .systemGray6
    }
    
    private func checkIfUserDidntSignout() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let navigationController = UINavigationController(rootViewController: RegisterScreen())
            navigationController.modalPresentationStyle = .overFullScreen
            present(navigationController, animated: true)
            
            
            print("no user is signed in")
        }
        
    }
    private func fetchAllUsers() {
        
        db.collection("Users")
            .addSnapshotListener { (querySnapshot, error) in
                
                self.users = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let userName = data["full name"] as? String,
                            let userIsOnline = data["isOnline"] as? String
                        {
                                guard let currentUserName = FirebaseAuth.Auth.auth().currentUser?.displayName else {return}
                                if userName != currentUserName {
                                    let newUser = User(fullName: userName, isOnline: userIsOnline)
                                    self.users.append(newUser)
                                    
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
    }
    
}

extension ChatScreen: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatScreenTableViewCell.cellId, for: indexPath) as! ChatScreenTableViewCell
        cell.userNameLabel.text = users[indexPath.row].fullName
        cell.isOnlineImage.image = users[indexPath.row].isOnline == "yes" ? UIImage(systemName: "circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal) : UIImage(systemName: "circle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Unhighlights what you have selected
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dmScreen = DirectMessageScreen()
        dmScreen.barTitle = users[indexPath.row].fullName
        dmScreen.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(dmScreen, animated: true)
        
    }
    
}
