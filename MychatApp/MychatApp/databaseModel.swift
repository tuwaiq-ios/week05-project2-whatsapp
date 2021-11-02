//
//  databaseModel.swift
//  MychatApp
//
//  Created by alanood on 24/03/1443 AH.
//
import Foundation
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}



struct ChatAppMessage{
    let fullName: String
    let message: String
}

struct User{
    let fullName: String
    let id = UUID()
    let isOnline: String 
}
