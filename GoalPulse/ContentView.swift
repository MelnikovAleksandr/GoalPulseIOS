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
    
    @State private var navigationManager: NavigationManager = Resolver.shared.resolve(NavigationManager.self)
    @State private var competitionsViewModel: CompetitionsViewModel = Resolver.shared.resolve(CompetitionsViewModel.self)
    @State private var standingsViewModel: StandingsViewModel = Resolver.shared.resolve(StandingsViewModel.self)

    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            CompetitonsPage(navigationManager: $navigationManager, viewModel: $competitionsViewModel)
                .navigationDestination(for: Routes.self) { page in
                    switch page {
                    case .standlings(let compCode): StandingsPage(navigationManager: $navigationManager, viewModel: $standingsViewModel, compCode: compCode)
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
