//
//  Models.swift
//  ChatProject1
//
//  Created by Sara M on 25/03/1443 AH.
//

import UIKit
import FirebaseFirestore

struct User {
    let id: String?
    let name: String?
    let email: String?
    let image: String?
    let status: String?
}


struct Message {
    let content : String?
    let sender : String?
    let reciever : String?
    let id : String?
    let timestamp : Timestamp
}


