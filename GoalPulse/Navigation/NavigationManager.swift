//
//  NavigationManager.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI

protocol NavigationManager {
    
    var path: NavigationPath { get set }
    
    func toStandlings()
    
    func toTeamDetails()
    
    func toPlayerDetails()
    
    func pop()
    
    func popToRoot()
    
}

@Observable
class NavigationManagerImpl: NavigationManager {
    
    static let shared = NavigationManagerImpl()
    private init() {}
    
    var path = NavigationPath()
    
    func toStandlings() {
        path.append(Routes.standlings)
    }
    
    func toTeamDetails() {
        path.append(Routes.team)
    }
    
    func toPlayerDetails() {
        path.append(Routes.player)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
