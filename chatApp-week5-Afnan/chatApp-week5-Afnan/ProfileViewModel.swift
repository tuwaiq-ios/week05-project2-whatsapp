//
//  ProfileViewModel.swift
//  chatApp-week5-Afnan
//
//  Created by Fno Khalid on 27/03/1443 AH.
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
