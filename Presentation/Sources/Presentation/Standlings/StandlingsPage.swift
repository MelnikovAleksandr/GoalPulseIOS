//
//  StandingsPage.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import SwiftUI
import Utils
import Domain

public struct StandingsPage: View {
    @Binding var navigationManager: NavigationManager
    @StateObject private var viewModel: StandingsViewModel
    @State private var isRefreshing = false
    @State var screenHeight: CGFloat = 0
    @State var scrollOffset: CGFloat = 0
    public init(
        navigationManager: Binding<NavigationManager>,
        compCode: String
    ) {
        self._navigationManager = navigationManager
        self._viewModel = StateObject(wrappedValue: ResolverApp.shared.resolve(StandingsViewModel.self, argument: compCode))
    }
    // Preview init
    public init(
        navigationManager: Binding<NavigationManager>,
        viewModel: StandingsViewModel
    ) {
        self._navigationManager = navigationManager
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        if viewModel.isLoading && viewModel.standings == nil {
            BallProgressView()
        } else {
            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
                        Color.theme.primaryContainer
                        AsyncMultiImage(url: viewModel.standings?.competition.emblem)
                            .scaledToFit()
                            .padding(50)
                            .frame(height: screenHeight / 4 + (scrollOffset < 0 ? abs(scrollOffset / 2) : 0))
                        Color.clear.background(.thinMaterial.opacity(scrollOffset / 100))
                    }
                    .clipped()
                    .offset(y: scrollOffset > 0 ? scrollOffset * 0.4 : 0)
                    .scaleEffect(scrollOffset < 0 ? 1 + abs(scrollOffset / 500) : 1)
                    
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(viewModel.standings?.standings ?? [], id: \.self) { standing in
                            Section {
                                ForEach(standing.table, id: \.self) { table in
                                    StandingItem(table: table, standingLastId: standing.table.last?.id)
                                        .background(Color.theme.background)
                                }
                            } header: {
                                TableLeagueTopBar(standing: standing, type: viewModel.standings?.competition.type ?? Type.LEAGUE)
                            }
                        }
                    }
                    BottomItem().padding(.horizontal, 4)
                }
                .offset(y: scrollOffset > 0 ? 0 : scrollOffset)
                
            }
            .background(Color.theme.background.edgesIgnoringSafeArea(.bottom))
            .onScrollGeometryChange(for: CGFloat.self, of: { geometry in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                    screenHeight = geometry.bounds.height
                }
                return geometry.contentOffset.y
            }, action: { _, newValue in
                scrollOffset = newValue
            })
            .snackbar(show: $viewModel.showSnackBar, bgColor: Color.theme.error, txtColor: Color.theme.surface, icon: "xmark", iconColor: Color.theme.surface, message: viewModel.errorMessage ?? "")
        }
    }
}

#Preview {
    StandingsPage(navigationManager: .constant(MockData.navManager), viewModel: MockData.standingsViewModel).loadCustomFonts()
}
