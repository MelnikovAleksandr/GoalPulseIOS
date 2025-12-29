//
//  StandingsPage.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import SwiftUI
import Utils

public struct StandingsPage: View {
    @Binding var navigationManager: NavigationManager
    @StateObject private var viewModel: StandingsViewModel
    
    public init(
        navigationManager: Binding<NavigationManager>,
        viewModel: @escaping () -> StandingsViewModel
    ) {
        self._navigationManager = navigationManager
        self._viewModel = .init(wrappedValue: viewModel())
    }
    
    public var body: some View {
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

#Preview {
    StandingsPage(navigationManager: .constant(MockData.navManager), viewModel: { MockData.standingsViewModel })
}
