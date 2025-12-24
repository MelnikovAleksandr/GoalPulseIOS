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
    @State var scrollOffset: CGFloat = 0.0
    
    public init(navigationManager: Binding<NavigationManager>, viewModel: Binding<CompetitionsViewModel>) {
        self._navigationManager = navigationManager
        self._viewModel = ObservedObject(wrappedValue: viewModel.wrappedValue)
    }
    
    public var body: some View {
        ZStack {
            LoadingPlayerView().ignoresSafeArea(.all)
            if viewModel.isLoading && viewModel.competitions.isEmpty {
                ProgressView()
                    .scaleEffect(2)
                    .tint(Color.theme.primary)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
                        Section {
                            ForEach(viewModel.competitions) { competition in
                                CompetitionItem(competition: competition)
                                    .onTapGesture {
                                        navigationManager.toStandlings()
                                    }
                            }
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.9)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                            }
                        } header: {
                            Header(scrollOffset: scrollOffset)
                        }
                    }
                }
                .onScrollGeometryChange(for: CGFloat.self, of: { geometry in
                    geometry.contentOffset.y
                }, action: { _, newValue in
                    scrollOffset = newValue
                })
                .onAppear {
                    UIRefreshControl.appearance().tintColor = UIColor(Color.theme.primary)
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
        .snackbar(show: $viewModel.showSnackBar, bgColor: Color.theme.error, txtColor: Color.theme.surface, icon: "xmark", iconColor: Color.theme.surface, message: viewModel.errorMessage ?? "")
    }
}

#Preview {
    CompetitonsPage(navigationManager: .constant(MockData.navManager), viewModel: .constant(MockData.competitionsViewModel))
}
