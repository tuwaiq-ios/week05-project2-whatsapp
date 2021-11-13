//
//  ChatMessageTableViewCell.swift
//  AtheerChat
//
//  Created by Eth Os on 06/04/1443 AH.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {

    
    let messageLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(messageLabel)
        messageLabel.textColor = .white
        messageLabel.backgroundColor = .red

        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
