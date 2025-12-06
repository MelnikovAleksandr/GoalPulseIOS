//
//  ContentView.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI
import Swinject

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

struct CompetitonsPage: View {
    @Binding var navigationManager: NavigationManager
    var body: some View {
        VStack {
            Text("CompetitonsPage")
            Button("Go to Standlings") {
                navigationManager.toStandlings()
            }
        }
    }
}

struct StandlingsPage: View {
    @Binding var navigationManager: NavigationManager
    var body: some View {
        VStack {
            Text("StandlingsPage")
            Button("Go to Team") {
                navigationManager.toTeamDetails()
            }
            Button("Go to Player") {
                navigationManager.toPlayerDetails()
            }
            Button("Go back") {
                navigationManager.pop()
            }
        }
    }
}

struct TeamPage: View {
    @Binding var navigationManager: NavigationManager
    var body: some View {
        VStack {
            Text("TeamPage")
            Button("Go to Player") {
                navigationManager.toPlayerDetails()
            }
            Button("Go back") {
                navigationManager.pop()
            }
        }
    }
}

struct PlayerPage: View {
    @Binding var navigationManager: NavigationManager
    var body: some View {
        VStack {
            Text("PlayerPage")
            Button("Go back") {
                navigationManager.pop()
            }
        }
    }
}


