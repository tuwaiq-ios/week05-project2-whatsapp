//
//  ContactsVC.swift
//  ChatProject1
//
//  Created by Sara M on 25/03/1443 AH.
//


import UIKit
import Firebase


class ContacstVC : UITableViewController {
    
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
        vc.contacts = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getUsers() {
        Firestore.firestore().collection("Users").addSnapshotListener { snapshot, error in
            if error == nil {
                guard let userID = Auth.auth().currentUser?.uid else {return}
                for document in snapshot!.documents{
                    let data = document.data()
                    
                    if data["userID"] as? String != userID {
                        self.users.append(User(
                            userID: data["userID"] as? String,
                            name:data ["name"] as? String ,
                            email:data ["email"] as? String )
                        )}
                }
                
                self.tableView.reloadData()
                
            } else {
                print("ERROR : ", error?.localizedDescription)
            }
        }
    }
    
}
