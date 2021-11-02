//
//  ChatScreen.swift
//  whatsApp
//
//  Created by Maram Al shahrani on 24/03/1443 AH.
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
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chat"
        
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        self.navigationController?.navigationBar.prefersLargeTitles = true

        //fetch convos
        fetchAllUsers()
        setupTableView()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkIfUserDidntSignout()
        userIsOnline()
        
    }
    private func userIsOnline() {
        guard let userFullName = Auth.auth().currentUser else {return}
        self.db.collection("Users").document(userFullName.displayName!).setData([
            "isOnline": "yes"
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("State Changed successfully")
            }
        }
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
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
        cell.accessoryType = .disclosureIndicator
        cell.isOnlineImage.image = users[indexPath.row].isOnline == "yes" ? UIImage(systemName: "circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal) : UIImage(systemName: "circle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
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
