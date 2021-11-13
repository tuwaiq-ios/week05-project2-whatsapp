//
//  tabVCViewController.swift
//  AtheerChat
//
//  Created by Eth Os on 06/04/1443 AH.
//

import UIKit
import FirebaseAuth

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
           UITabBar.appearance().barTintColor = .systemBackground
           tabBar.tintColor = .label
           setupVCs()
        
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return
        }
        
        UsersService.shared.updateUserInfo(
            user: User(
                id: currentUserId,
                name: "Atheer Os",
                status: "Online"
            )
        )
    }
    
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
              createNavController(for: PeopleViewController(), title: NSLocalizedString("Chat", comment: ""), image: UIImage(systemName: "message")!),
              createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!)
          ]
      }
}
