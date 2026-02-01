//
//  TeamPage.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import SwiftUI
import Utils

public struct TeamPage: View {
    @Binding var navigationManager: NavigationManager
    @StateObject private var viewModel: TeamViewModel
    
    public init(
        navigationManager: Binding<NavigationManager>,
        teamId: Int
    ) {
        self._navigationManager = navigationManager
        self._viewModel = StateObject(wrappedValue: ResolverApp.shared.resolve(TeamViewModel.self, argument: teamId))
    }
    // Preview init
    public init(
        navigationManager: Binding<NavigationManager>,
        viewModel: TeamViewModel
    ) {
        self._navigationManager = navigationManager
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            Text("TeamPage")
            Text(viewModel.team?.name ?? "empty")
            Text("squad - \(viewModel.team?.squad.count ?? 0)")
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
    NavigationStack {
        TeamPage(navigationManager: .constant(MockData.navManager), viewModel: MockData.teamViewModel)
            .loadCustomFonts()
    }
}
