//
//  LoginViewController.swift
//  ChatAp
//
//  Created by HANAN on 22/03/1443 AH.







import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
