//
//  Model.swift
//  ChattingApp
//
//  Created by dmdm on 11/11/2021.
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
