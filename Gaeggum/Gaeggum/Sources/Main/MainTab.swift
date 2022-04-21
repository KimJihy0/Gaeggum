//
//  MainTab.swift
//  Gaeggum
//
//  Created by zeroStone ⠀ on 2022/04/21.
//

import Foundation

enum MainTab {
    case home
    case findCareer
    case myStack
    
    var segueIdentifier: String {
        switch self {
        case .home:
            return "HomeSegue"
        case .findCareer:
            return "FindCareerSegue"
        case .myStack:
            return "MyStackSegue"
        }
    }
    
    var index: Int {
        switch self {
        case .home:
            return 0
        case .findCareer:
            return 1
        case .myStack:
            return 2
        }
    }
}
