//
//  ContentView.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI
import Swinject
import Utils
import Presentation

struct ContentView: View {
    
    @State private var navigationManager: NavigationManager
    
    init() {
        _navigationManager = State(
            initialValue: DIContainer.shared.resolve(NavigationManager.self)
        )
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            CompetitonsPage(navigationManager: $navigationManager)
            .padding()
            .navigationDestination(for: Routes.self) { page in
                switch page {
                case .standlings: StandlingsPage(navigationManager: $navigationManager)
                case .team: TeamPage(navigationManager: $navigationManager)
                case .player: PlayerPage(navigationManager: $navigationManager)
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
