//
//  ChatScreenTableViewCell.swift
//  chatapp
//
//  Created by Kholod Sultan on 24/03/1443 AH.
//
import UIKit

class ChatScreenTableViewCell: UITableViewCell {
    
    static let cellId = "12345"
    
    let userNameLabel: UILabel = {
        let name = UILabel()
        
        name.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        name.textAlignment = .left
        name.textColor = .label
        
        return name
    }()
    
    let isOnlineImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    func setupViews() {

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
         addSubview(userNameLabel)
         userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
         userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
         
         isOnlineImage.translatesAutoresizingMaskIntoConstraints = false
         addSubview(isOnlineImage)
         isOnlineImage.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 5).isActive = true
         isOnlineImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
         isOnlineImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
         isOnlineImage.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 3).isActive = true
    }
    
}

