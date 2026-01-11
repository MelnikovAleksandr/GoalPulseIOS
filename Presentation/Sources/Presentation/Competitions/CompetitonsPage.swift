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
    @StateObject private var viewModel: CompetitionsViewModel
    @State private var isRefreshing = false
    @State var scrollOffset: CGFloat = 0.0
    
    public init(navigationManager: Binding<NavigationManager>) {
        self._navigationManager = navigationManager
        self._viewModel = StateObject(wrappedValue: ResolverApp.shared.resolve(CompetitionsViewModel.self))
    }

    // Preview init
    public init(navigationManager: Binding<NavigationManager>, viewModel: CompetitionsViewModel) {
        self._navigationManager = navigationManager
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            LoadingPlayerView().ignoresSafeArea(.all)
            if viewModel.isLoading && viewModel.competitions.isEmpty {
                BallProgressView()
            } else {
                ScrollView {
                    LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
                        Section {
                            ForEach(viewModel.competitions) { competition in
                                CompetitionItem(competition: competition)
                                    .onTapGesture {
                                        navigationManager.toStandlings(compCode: competition.code)
                                    }
                            }
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.9)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                            }
                        } header: {
                            if #available(iOS 26.1, *) {
                                HeaderGlass(scrollOffset: scrollOffset)
                                    .padding(.horizontal, 16)
                            } else {
                                Header(scrollOffset: scrollOffset)
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                }
                .refreshable(isRefreshing: .init(get: { isRefreshing || viewModel.isLoading }, set: { isRefreshing = $0 }), action: {
                    await viewModel.loadCompetitions()
                }, indicatorView: {
                    BallProgressView(width: 50, height: 50)
                })
                .animation(.spring(), value: viewModel.competitions)
                .onScrollGeometryChange(for: CGFloat.self, of: { geometry in
                    geometry.contentOffset.y
                }, action: { _, newValue in
                    scrollOffset = newValue
                })
                .onAppear {
                    UIRefreshControl.appearance().tintColor = UIColor(Color.theme.primary)
                }
            }
        }
        .snackbar(show: $viewModel.showSnackBar, bgColor: Color.theme.error, txtColor: Color.theme.surface, icon: "xmark", iconColor: Color.theme.surface, message: viewModel.errorMessage ?? "")
    }
}

#Preview {
    CompetitonsPage(navigationManager: .constant(MockData.navManager), viewModel: MockData.competitionsViewModel)
}
