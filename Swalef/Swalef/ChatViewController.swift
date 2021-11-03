//
//  ChatViewController.swift
//  Swalef
//
//  Created by MacBook on 28/03/1443 AH.
//

import Foundation
import Firebase
import AVFoundation

class ChatViewController: UIViewController {
    
    var user : User?
    var messages = [Message]()
    
    var player: AVAudioPlayer?

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
    
    
    
   

    func playSound() {
                guard let url = Bundle.main.url(forResource: "sound", withExtension: "mp3") else { return }

                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)

                    /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                    /* iOS 10 and earlier require the following line:
                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                    guard let player = player else { return }

                    DispatchQueue.main.async {
                        player.play()
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
        }
    func getAllMessages() {
        Firestore.firestore().collection("Messages").addSnapshotListener { [self] snapshot, error in
            self.messages.removeAll()
            guard let currentUserID = Auth.auth().currentUser?.uid else {return}
            if error == nil {
                for document in snapshot!.documents{
                    let data = document.data()
                    if let sender = data["sender"] as? String, let reciever = data["reciever"] as? String {
                        if (sender == currentUserID && reciever == user?.userID) || (sender == user?.userID && reciever == currentUserID) {
                            self.messages.append(Message(message: data["message"] as? String, sender: sender , reciever: reciever))
                        }
                    }
                }
                self.chatTableView.reloadData()
                self.playSound()
            }
        }
    }
}
