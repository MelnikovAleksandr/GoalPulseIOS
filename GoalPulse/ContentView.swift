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
    
    @State private var navigationManager: NavigationManager = ResolverApp.shared.resolve(NavigationManager.self)
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            CompetitonsPage(navigationManager: $navigationManager)
                .navigationDestination(for: Routes.self) { page in
                    switch page {
                    case .standlings(let compCode): StandingsPage(navigationManager: $navigationManager, compCode: compCode)
                    case .team(let teamId): TeamPage(navigationManager: $navigationManager, teamId: teamId)
                    case .player(let playerId): PlayerPage(navigationManager: $navigationManager, playerId: playerId)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
