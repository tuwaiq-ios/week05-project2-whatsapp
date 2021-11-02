//
//  FavoriteViewController.swift
//  ChattingApp
//
//  Created by dmdm on 01/11/2021.
//

import UIKit
class favorite:UIViewController{
    var img: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let name = UILabel()
    let status = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        view.addSubview(img)
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            img.heightAnchor.constraint(equalToConstant: 80),
            img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
        
        
        
        name.text = "Mommy"
        name.font = .boldSystemFont(ofSize: 23)
        name.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(name)
        NSLayoutConstraint.activate([
            
            name.topAnchor.constraint(equalTo: view.topAnchor,constant: 40),
            name.leftAnchor.constraint(equalTo: img.leftAnchor , constant: -130),
            name.heightAnchor.constraint(equalToConstant: 80),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
        ])
        
        
        status.text = "Favorite"
        status.textColor = .purple
        status.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(status)
        NSLayoutConstraint.activate([
            
            status.topAnchor.constraint(equalTo: view.topAnchor,constant: 70),
            status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30),
            status.heightAnchor.constraint(equalToConstant: 20),
            status.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 100)
        ])
        
        var img: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "background")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        let name = UILabel()
        let status = UILabel()
        
    
            
            view.backgroundColor = .lightGray
            
            view.addSubview(img)
            NSLayoutConstraint.activate([
                img.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
                img.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
                img.heightAnchor.constraint(equalToConstant: 80),
                img.widthAnchor.constraint(equalTo: img.heightAnchor,multiplier: 100/100)])
            
            
            
            name.text = "Sara"
            name.font = .boldSystemFont(ofSize: 23)
            name.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(name)
            NSLayoutConstraint.activate([
                
                name.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
                name.leftAnchor.constraint(equalTo: img.leftAnchor , constant: -130),
                name.heightAnchor.constraint(equalToConstant: 120),
                name.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 140)
            ])
            
            
            status.text = "Favorite"
            status.textColor = .purple
            status.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(status)
            NSLayoutConstraint.activate([
                
                status.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
                status.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 30),
                status.heightAnchor.constraint(equalToConstant: 50),
                status.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: 130)
            ])
        view.backgroundColor = .white
    
    }
    
    
    
}
