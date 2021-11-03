//
//  Chat.swift
//  Whats
//
//  Created by Ahmed Assiri on 28/03/1443 AH.
//

import UIKit
import Firebase
class Chat: UIViewController {
    
    
    var user : User?
    var messages = [Message]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        getAllMessages()
        
        chatTV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    let chatTV : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    let messageTextField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Write message"
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    let sendButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
        $0.tintColor = .blue
        $0.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        navigationItem.title = user?.name
        
        chatTV.delegate = self
        chatTV.dataSource = self
        
        
        view.addSubview(chatTV)
        view.addSubview(messageTextField)
        view.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            chatTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            chatTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            chatTV.bottomAnchor.constraint(equalTo: messageTextField.topAnchor),
            
            messageTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            messageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -5),
            messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 45),
            
            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            sendButton.heightAnchor.constraint(equalTo: messageTextField.heightAnchor),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor)
            
        ])
        
    }
    
    
}


extension Chat : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTV.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentUserID = Auth.auth().currentUser?.uid
        
        cell.textLabel?.text = messages[indexPath.row].message
        
        if messages[indexPath.row].from1 == currentUserID {
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.textColor = .blue
        } else {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .red
        }
        
        
        return cell
    }

}


extension Chat {
    @objc func sendMessage() {
        
        let messageId = String(Date().timeIntervalSince1970)
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        guard let message = messageTextField.text else {return}
        guard let user = user else {return}
        
        Firestore.firestore()
            .document("Messages/\(messageId)")
            .setData(["from" : currentUserID,
                      "to" : user.uID!,
                      "message" : message
                     ])
        messageTextField.text = ""
    }
  
    func getAllMessages() {
        
        Firestore.firestore()
            .collection("Messages")
            .addSnapshotListener { (snapshot, error) in
                self.messages = []
                if let e = error {
                    print(e)
                }else {
                    if let snapshotDocuments = snapshot?.documents{
                        
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            self.messages.append(Message(
                                
                                message: data["message"] as? String,
                                from1: data["from"] as? String,
                                to: data["to"]  as? String))
                        }
                        
                        DispatchQueue.main.async {
                            self.chatTV.reloadData()
                            
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.chatTV.scrollToRow(at: indexPath, at: .top, animated: true)
                        }
                    }
                }
            }
    }
}



