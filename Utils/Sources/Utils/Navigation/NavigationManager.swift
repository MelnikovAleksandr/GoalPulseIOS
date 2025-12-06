//
//  NavigationManager.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI

public protocol NavigationManager {
    
    var path: NavigationPath { get set }
    
    func toStandlings()
    
    func toTeamDetails()
    
    func toPlayerDetails()
    
    func pop()
    
    func popToRoot()
    
}

@Observable
public class NavigationManagerImpl: NavigationManager {
    
    public init() {}
    
    public var path = NavigationPath()
    
    public func toStandlings() {
        path.append(Routes.standlings)
    }
    
    public func toTeamDetails() {
        path.append(Routes.team)
    }
    
    public func toPlayerDetails() {
        path.append(Routes.player)
    }
    
    public func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    public func popToRoot() {
        path = NavigationPath()
    }
}
