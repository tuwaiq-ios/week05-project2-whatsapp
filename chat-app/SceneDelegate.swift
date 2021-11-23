//
//  SceneDelegate.swift
//  chat-app
//
//  Created by M.alqahtani  on 23/03/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
   
    let db =  Firestore.firestore()
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TabBarCustom()
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.

        guard let userFullName = Auth.auth().currentUser else {return}
        self.db.collection("Users").document(userFullName.displayName!).setData([
            "isOnline": "yes"
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("State Changed successfully")
            }
        }

    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        guard let currentUser = Auth.auth().currentUser else {return}
        db.collection("Users").document(currentUser.displayName!).setData([
            "isOnline": "no",
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("ChangedUserStatus")
            }
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
 
        guard let currentUser = Auth.auth().currentUser else {return}
        db.collection("Users").document(currentUser.displayName!).setData([
            "isOnline": "no",
        ], merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("ChangedUserStatus")
            }
        }
   
        
    }


}


