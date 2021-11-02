//
//  CustomTabBar.swift
//  chatapp
//
//  Created by Kholod Sultan on 24/03/1443 AH.
//

import UIKit

class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
        barItem(vc: ChatScreen(), img: UIImage(systemName: "message.fill")!, name: "Message"),
        barItem(vc: SettingsScreen(), img: UIImage(systemName: "gear")!, name: "Settings")
        ]
        
    }
    
    private func barItem(vc: UIViewController, img: UIImage, name: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = name
        nav.tabBarItem.image = img
        return nav
    }
    
    
}
