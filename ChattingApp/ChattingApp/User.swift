//
//  User.swift
//  ChattingApp
//
//  Created by dmdm on 11/11/2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class UsersViewController : UITableViewController {
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Users"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        getUsers()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatVC()
        vc.user = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getUsers() {
        Firestore.firestore().collection("users").addSnapshotListener { snapshot, error in
            if error == nil {
                self.users.removeAll()
                guard let userID = Auth.auth().currentUser?.uid else {return}
                for document in snapshot!.documents{
                    let data = document.data()
                    
                    if data["id"] as? String != userID {
                        self.users.append(User(
                            name: data["name"] as? String,
                            email: data["email"] as? String,
                            id: data["id"] as? String,
                            status: data["status"] as? String ?? ""))
                    }
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("ERROR : ", error?.localizedDescription)
            }
        }
    }
    
}
