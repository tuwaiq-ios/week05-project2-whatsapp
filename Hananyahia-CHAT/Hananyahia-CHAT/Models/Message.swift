//
//  Message.swift
//  Hananyahia-CHAT
//
//  Created by  HANAN ASIRI on 06/04/1443 AH.
//

import UIKit
import FirebaseFirestore

struct Message {
    let id: String
    let sender: String
    let receiver: String
    let content: String
    let timestamp: Timestamp
}
