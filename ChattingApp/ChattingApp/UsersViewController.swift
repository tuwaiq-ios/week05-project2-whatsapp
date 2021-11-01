//
//  UsersViewController.swift
//  ChattingApp
//
//  Created by m.alqahtani on 24/03/1443 AH.
//

import UIKit
import Firebase


class UsersViewController : UITableViewController {
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
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
        let vc = ChatViewController()
        vc.user = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getUsers() {
        Firestore.firestore().collection("Users").addSnapshotListener { snapshot, error in
            if error == nil {
                guard let userID = Auth.auth().currentUser?.uid else {return}
                for document in snapshot!.documents{
                    let data = document.data()
                    
                    if data["userID"] as? String != userID {
                        self.users.append(User(name: data["name"] as? String, email: data["email"] as? String, userID: data["userID"] as? String))
                    }
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("ERROR : ", error?.localizedDescription)
            }
        }
    }
    
}
