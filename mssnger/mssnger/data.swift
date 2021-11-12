//
//  data.swift
//  chatchat
//
//  Created by sally asiri on 05/04/1443 AH.


import Foundation
import Firebase
struct Message {
    let content : String?
    let sender : String?
    let reciever : String?
    let id : String?
    let timestamp : Timestamp
    
    func getNiceDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: timestamp.dateValue())
    }
}


struct User {
    let name : String?
    let status : String?
    let email : String?
    var id : String?
    let img : String?
}



