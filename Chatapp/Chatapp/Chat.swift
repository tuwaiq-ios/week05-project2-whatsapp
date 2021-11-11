//
//  Chat.swift
//  Whats
//
//  Created by Ahmed Assiri on 28/03/1443 AH.
//


import UIKit
import Firebase
import FirebaseFirestore

class ChatVC: UIViewController {
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
        $0.tintColor = .brown
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
extension ChatVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentUserID = Auth.auth().currentUser?.uid
        cell.textLabel?.text = messages[indexPath.row].content
        print(messages[indexPath.row].content)
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
extension ChatVC {
    @objc func sendMessage() {
        let messageId = UUID().uuidString
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        guard let message = messageTextField.text else {return}
        guard let user = user else {return}
        Firestore.firestore().document("messages/\(messageId)").setData([
            "sender" : currentUserID,
            "receiver" : user.id!,
            "content" : message,
            "id": messageId,
        ])
        messageTextField.text = ""
    }
    func getAllMessages() {
        guard let chatID = user?.id else {return}
        guard let userID = Auth.auth().currentUser?.uid else {return}
        self.messages.removeAll()
        //self.chatTableView.reloadData()
        // self.messages = []
        Firestore.firestore()
            .collection("messages")
            .whereField("receiver", isEqualTo: userID)
            .whereField("sender", isEqualTo: chatID)
            .addSnapshotListener { snapshot, error in
                //guard let userID = Auth.auth().currentUser?.uid else {return}
                if error == nil {
                    for document in snapshot!.documents{
                        let data = document.data()
                        let newMsg = Message(
                            content: data["content"] as? String,
                            sender: data["sender"] as? String,
                            reciever: data["receiver"] as? String,
                            id: (data["id"] as? String) ?? "",
                            timestamp: (data["timestamp"] as? Timestamp) ?? Timestamp()
                        )
                        let isMsgAdded = self.messages.contains { msg in
                            return msg.id == newMsg.id
                        }
                        if !isMsgAdded {
                            self.messages.append(newMsg)
                        }
                    }
                    self.chatTableView.reloadData()
                }
                //self.chatTableView.reloadData()
            }
        Firestore.firestore()
            .collection("messages")
            .whereField("sender", isEqualTo: userID)
            .whereField("receiver", isEqualTo: chatID)
            .addSnapshotListener { snapshot, error in
                if error == nil {
                    for document in snapshot!.documents{
                        let data = document.data()
                        let newMsg = Message(
                            content: data["content"] as? String,
                            sender: data["sender"] as? String,
                            reciever: data["receiver"] as? String,
                            id: (data["id"] as? String) ?? "",
                            timestamp: (data["timestamp"] as? Timestamp) ?? Timestamp()
                        )
                        let isMsgAdded = self.messages.contains { msg in
                            return msg.id == newMsg.id
                        }
                        if !isMsgAdded {
                            self.messages.append(newMsg)
                        }
                        self.chatTableView.reloadData()
                    }
                }
                // self.chatTableView.reloadData()
            }
    }
}

