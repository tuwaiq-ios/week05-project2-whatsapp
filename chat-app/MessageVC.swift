//
//  DirectMessageScreen.swift
//  chat-app
//
//  Created by ibrahim asiri on 23/03/1443 AH.
//

import UIKit
import Firebase
import MessageKit
import InputBarAccessoryView

class MessageVC: MessagesViewController {
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    var currentUser: Sender!
    var recieverUser: Sender!
    var barTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = barTitle
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
    
        messageInputBar.delegate = self

        fetchMessages()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
            self.messageInputBar.inputTextView.becomeFirstResponder()
    }

    
    private func  fetchMessages() {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser?.displayName else {return}
       
        db.collection("Messages").whereField("messagesBetween", isEqualTo: [currentUserName, barTitle].sorted())
            .order(by: "messageSentDate")
            .addSnapshotListener { (querySnapshot, error) in
                self.messages = []
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            if let messageId = data["messageId"] as? String,
                                let messageSentDate = data["messageSentDate"] as? String,
                                let messageBody = data["messageBody"] as? String,
                                let senderId = data["senderId"] as? String,
                               let displayName = data["displayName"] as? String
                            {
                                
                                let messageSentDateNEW = self.stringToDate(messageSentDate)
                                let newMessage = Message(sender: Sender(senderId: senderId, displayName: displayName), messageId: messageId, sentDate: messageSentDateNEW, kind: .text(messageBody))
             
                                    self.messages.append(newMessage)
                                DispatchQueue.main.async {
                                   
                                    self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
                                    self.messagesCollectionView.reloadData()
                                }
                                
                            } else {
                                print("error converting data")
                                return
                                
                            }
                        }
                    }
                }
            }
    }
    
    private func writeData(userNewText: String) {
        guard let currentUserName = FirebaseAuth.Auth.auth().currentUser else {return}

            db.collection("Messages").addDocument(data: [
                "messageId" : UUID().uuidString,
                "messageSentDate" : "\(Date())",
                "messageBody" : userNewText,
                "messagesBetween" : [currentUserName.displayName! , barTitle].sorted(),
                "senderId" : currentUserName.displayName!,
                "displayName" : currentUserName.displayName!
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    DispatchQueue.main.async {
                        self.messageInputBar.inputTextView.text = ""
                    }
                }
            }
    }
    
    func stringToDate(_ string: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale    = .current
        
        if formatter.date(from: string) != nil {
            return formatter.date(from: string)!
        }else{
            return Date()
        }
    }
}

extension MessageVC: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
    
    func currentSender() -> SenderType {
        let currentUserName = FirebaseAuth.Auth.auth().currentUser!
        return Sender(senderId: currentUserName.displayName!, displayName: currentUserName.displayName!)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
  
  
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
            return isFromCurrentSender(message: message) ? UIColor.systemMint : UIColor.systemPink
    }
  
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let date = message.sentDate
        
        print(date)
        return NSAttributedString(
          string: formateDate(date),
          attributes: [
            .font: UIFont.preferredFont(forTextStyle: .caption1),
            .foregroundColor: UIColor(white: 0.3, alpha: 1)
          ]
        )
      }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 50
    }
    
    func formateDate(_ date: Date) -> String {
        
        let formatter           = DateFormatter()
        formatter.timeZone      = .current
        formatter.locale        = .current
        formatter.dateFormat    = "MMM d, h:mm a"

        return formatter.string(from: date)
    }

}

extension MessageVC: InputBarAccessoryViewDelegate  {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        if !text.isEmpty {
            writeData(userNewText: text)
            messageInputBar.inputTextView.resignFirstResponder()
        }
    }
}

