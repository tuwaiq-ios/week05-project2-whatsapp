//
//  ProfileVC.swift
//  Hananyahia-CHAT
//
//  Created by  HANAN ASIRI on 06/04/1443 AH.
//


import UIKit


class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let image = UIImage(systemName: "person")
        tabBarItem = .init(title: "Profile", image: image, selectedImage: image)
    }
    
}
