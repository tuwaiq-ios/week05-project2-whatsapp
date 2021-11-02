//
//  LoginViewController.swift
//  ChatAp
//
//  Created by HANAN on 22/03/1443 AH.





import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
