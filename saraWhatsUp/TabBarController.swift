//
//  TabBarController.swift
//  saraWhatsUp
//
//  Created by sara al zhrani on 26/03/1443 AH.
//

import UIKit

class TabBarController: UITabBarController {
    fileprivate func createNavController(for rootViewController: LoginController,
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
         createNavController(for: LoginController(), title: NSLocalizedString("Chat", comment: ""), image: UIImage(systemName: "message")!),
       ]
     }
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
//        setupVCs()
      // Do any additional setup after loading the view.
    }
  

 
}
