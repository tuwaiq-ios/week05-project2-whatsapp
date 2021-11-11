//
//  File2.swift
//  Whatsapp
//
//  Created by Fawaz on 01/11/2021.
//

import UIKit
//===============================================================================
class TabVC: UITabBarController, UITabBarControllerDelegate  {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
  }
  //=============================================================================
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let item1 = ContactVC()
    let item2 = ProfileVC()
    let item3 = ContactVC()
    
    let icon1 = UITabBarItem(title: "Contact", image: UIImage(systemName: "message.fill"), selectedImage: UIImage(systemName: "message.fill"))
    let icon2 = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))
    let icon3 = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.fill"), selectedImage: UIImage(systemName: "star.fill"))
    
    item1.tabBarItem = icon1
    item2.tabBarItem = icon2
    item3.tabBarItem = icon3
    
    let controllers = [item1,item2,item3]
    self.viewControllers = controllers
  }
  //=============================================================================
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    print("Should select viewController: \(viewController.title ?? "") ?")
    return true;
  }
}
