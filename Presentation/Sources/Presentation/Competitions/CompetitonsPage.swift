//
//  CompetitonsPage.swift
//  Presentation
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI
import Utils
import Observation

public struct CompetitonsPage: View {
    @Binding var navigationManager: NavigationManager
    @ObservedObject private var viewModel: CompetitionsViewModel
    @State private var isRefreshing = false
    
    public init(navigationManager: Binding<NavigationManager>, viewModel: Binding<CompetitionsViewModel>) {
        self._navigationManager = navigationManager
        self._viewModel = ObservedObject(wrappedValue: viewModel.wrappedValue)
    }
    
    public var body: some View {
        ZStack {
            if viewModel.isLoading && viewModel.competitions.isEmpty {
                ProgressView()
                    .scaleEffect(2)
                    .tint(Color.theme.primary)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.competitions) { competition in
                            CompetitionItem(competition: competition)
                                .onTapGesture {
                                    navigationManager.toStandlings()
                                }
                        }
                    }
                }
                .overlay {
                    if viewModel.isLoading {
                        ProgressView()
                            .scaleEffect(2)
                            .tint(Color.theme.primary)
                    }
                }
                .refreshable {
                    viewModel.loadCompetitions()
                }
            }
        }
    }
}

#Preview {
    CompetitonsPage(navigationManager: .constant(MockData.navManager), viewModel: .constant(MockData.competitionsViewModel))
}
