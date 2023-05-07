//
//  MessagingVC.swift
//  Hananyahia-CHAT
//
//  Created by  HANAN ASIRI on 06/04/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class MessagingVC: UIViewController {
    
    let cellId = "MessageCell"
    var messages: [Message] = []
    var user: User!
    
    lazy var messagesTV: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    lazy var tf: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        tf.placeholder = "Write a message .."
        tf.backgroundColor = .cyan
        return tf
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let curruntUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        MessagesService.shared.listenToConversation(
            userId1: user.id,
            userId2: curruntUserId
        ) { newMessages in
            self.messages = newMessages
            self.messagesTV.reloadData()
        }
        
        view.addSubview(messagesTV)
        view.addSubview(tf)
        
        NSLayoutConstraint.activate([
            messagesTV.topAnchor.constraint(equalTo: view.topAnchor),
            messagesTV.rightAnchor.constraint(equalTo: view.rightAnchor),
            messagesTV.leftAnchor.constraint(equalTo: view.leftAnchor),
            messagesTV.bottomAnchor.constraint(equalTo: tf.topAnchor),
            
            tf.heightAnchor.constraint(equalToConstant: 40),
            tf.topAnchor.constraint(equalTo: messagesTV.bottomAnchor),
            tf.rightAnchor.constraint(equalTo: view.rightAnchor),
            tf.leftAnchor.constraint(equalTo: view.leftAnchor),
            tf.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}


extension MessagingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.content
    
        if let currentUserId = Auth.auth().currentUser?.uid {
            if currentUserId == message.sender {
                cell.textLabel?.textAlignment = .right
            } else {
                cell.textLabel?.textAlignment = .left
            }
        }
        return cell
    }
}


extension MessagingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tf.resignFirstResponder()
        
        let text = tf.text ?? ""
        if text.isEmpty {
            return true
        }
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return true
        }
        
        MessagesService.shared.sendMessage(
            message: Message(
                id: UUID().uuidString,
                sender: currentUserId,
                receiver: user.id,
                content: text,
                timestamp: Timestamp()
            )
        )
        
        tf.text = ""
        return true
    }
}

