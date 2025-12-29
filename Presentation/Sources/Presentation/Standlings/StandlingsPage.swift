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
    @ObservedObject private var viewModel: StandingsViewModel
    @State var firstAppear: Bool = true
    let compCode: String
    
    public init(navigationManager: Binding<NavigationManager>, viewModel: Binding<StandingsViewModel>, compCode: String) {
        self._navigationManager = navigationManager
        self._viewModel = ObservedObject(wrappedValue: viewModel.wrappedValue)
        self.compCode = compCode
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
        }.onAppear {
            if self.firstAppear {
                viewModel.getStandingsFlow(compCode: compCode)
                viewModel.loadStandings(compCode: compCode)
                self.firstAppear = false
            }
        }
    }
}

#Preview {
    StandingsPage(navigationManager: .constant(MockData.navManager), viewModel: .constant(MockData.standingsViewModel), compCode: "")
}
