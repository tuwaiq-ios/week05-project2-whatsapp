////
////  ViewController.swift
////  mssnger
////
////  Created by Macbook on 22/03/1443 AH.



import UIKit
import Firebase


class  ContactVC: UITableViewController {
    
    var users = [User]()
    let em = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "users"
        
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
        
        //em.text = Auth.auth().currentUser?.email
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
//        em.textColor = .blue
//        em.font = .boldSystemFont(ofSize: 20)
//        em.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(em)
//        NSLayoutConstraint.activate([
//            em.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
//            em.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5)
//        ])
//
        
        getUsers()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
       // cell.textLabel?.text = Auth.auth().currentUser?.email
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatVC()
        vc.user = users[indexPath.row]
        //self.present(vc, animated: true, completion: nil)
       navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getUsers() {
        Firestore.firestore().collection("users").addSnapshotListener { snapshot, error in
            if error == nil {
                guard let userID = Auth.auth().currentUser?.uid else {return}
                for document in snapshot!.documents{
                    let data = document.data()
                    
                    if data["id"] as? String != userID {
                        self.users.append(User(name: data["name"] as? String, status: data["status"] as? String,
                            email: data["email"] as? String,
                            id: data["id"] as? String,
                            img: data["img"] as? String
                                              )
                        )
                    }
                    
                }
                
                self.tableView.reloadData()
                
            } else {
                print("ERROR : ", error?.localizedDescription)
            }
        }
    }
    
}

