//
//  ChatViewController.swift
//  ChattingApp
//
//  Created by Abdulaziz on 25/03/1443 AH.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    var user : User?
    var messages = [Message]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        getAllMessages()
        
        chatTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    let chatTableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    let messageTextField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Message..."
        $0.backgroundColor = .init(white: 0.85, alpha: 1)
        $0.layer.cornerRadius = 22.5
        return $0
    }(UITextField())
    
    let sendButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
        $0.tintColor = .purple
        $0.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        navigationItem.title = user?.name
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        
        view.addSubview(chatTableView)
        view.addSubview(messageTextField)
        view.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            chatTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor),
            
            messageTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            messageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -5),//*****
            messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 45),
            
            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            sendButton.heightAnchor.constraint(equalTo: messageTextField.heightAnchor),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor)
            
        ])
        
    }

   
}


extension ChatViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentUserID = Auth.auth().currentUser?.uid
        
        cell.textLabel?.text = messages[indexPath.row].message
        
        if messages[indexPath.row].sender == currentUserID {
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.textColor = .blue
        } else {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .red
        }
        
        
        
        
        return cell
    }
    
    
}


extension ChatViewController {
    @objc func sendMessage() {
        let messageId = String(Date().timeIntervalSince1970)
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        guard let message = messageTextField.text else {return}
        guard let user = user else {return}
        Firestore.firestore().document("Messages/\(messageId)").setData([
            "sender" : currentUserID,
            "reciever" : user.userID!,
            "message" : message
        ])
        
        messageTextField.text = ""
    }
    
    
    func getAllMessages() {
        Firestore.firestore().collection("Messages").whereField("reciever", isEqualTo: user?.userID).addSnapshotListener { snapshot, error in
            self.messages.removeAll()
            if error == nil {
                for document in snapshot!.documents{
                    let data = document.data()
                    self.messages.append(Message(message: data["message"] as? String, sender: data["sender"] as? String, reciever: data["reciever"]  as? String))
                }
                self.chatTableView.reloadData()
            }
        }
    }
}
