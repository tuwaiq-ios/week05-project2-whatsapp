//
//  TabBarCustom.swift
//  MychatApp
//
//  Created by alanood on 26/03/1443 AH.
//

import UIKit

class TabBarCustom: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        
        viewControllers = [
        
            barItem("Chat", UIImage(systemName: "message.fill")!, ChatScreen()),
            barItem("Settings", UIImage(systemName: "gear")!, SettingsScreen()),
        
        ]
        
    }

    private func barItem(_ tabBarTitle: String, _ tabBarImage: UIImage, _ viewcontroller: UIViewController) -> UINavigationController {
        let navContent = UINavigationController(rootViewController: viewcontroller)
        navContent.tabBarItem.title = tabBarTitle
        navContent.tabBarItem.image = tabBarImage
        return navContent
    }

}
