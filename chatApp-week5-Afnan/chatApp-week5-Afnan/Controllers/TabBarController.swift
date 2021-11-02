//
//  TabBarController.swift
//  chatApp-week5-Afnan
//
//  Created by Fno Khalid on 25/03/1443 AH.
//
import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                     title: String,
                                                     image: UIImage) -> UIViewController {
           let navController = UINavigationController(rootViewController: rootViewController)
           navController.tabBarItem.title = title
           navController.tabBarItem.image = image
           navController.navigationBar.prefersLargeTitles = true
           rootViewController.navigationItem.title = title
           return navController
       }

    func setupVCs() {
          viewControllers = [
              createNavController(for: ConversationsViewController(), title: NSLocalizedString("Chat", comment: ""), image: UIImage(systemName: "message")!),
              createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!),
          ]
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
           UITabBar.appearance().barTintColor = .systemBackground
           tabBar.tintColor = .label
           setupVCs()

        // Do any additional setup after loading the view.
    }
    

}
