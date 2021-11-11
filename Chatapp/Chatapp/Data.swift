//
//  Data.swift
//  Whats
//
//  Created by Ahmed Assiri on 28/03/1443 AH.
//

import Foundation
import Firebase

struct User {
    let name : String?
    let email : String?
    let id : String?
    let status : String
}


struct Message {
    let content : String?
    let sender : String?
    let reciever : String?
    let id : String
    let timestamp : Timestamp?
}
