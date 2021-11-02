//
//  SceneDelegate.swift
//  ChatAp
//
//  Created by Amal on 22/03/1443 AH.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
