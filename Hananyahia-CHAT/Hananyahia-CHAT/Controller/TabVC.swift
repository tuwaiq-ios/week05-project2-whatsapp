//
//  TabVC.swift
//  Hananyahia-CHAT
//
//  Created by  HANAN ASIRI on 06/04/1443 AH.
//

import UIKit
import FirebaseAuth


class TabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        UsersService.shared.updateUserInfo(
            user: User(
                id: currentUserId,
                name: "Hanan",
                status: "Online"
            )
        )
        
        viewControllers = [
            PeopleVC(),
            ProfileVC()
        ]
    }
    
}

