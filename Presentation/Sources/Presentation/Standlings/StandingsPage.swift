//
//  StandingsPage.swift
//  Presentation
//
//  Created by Александр Мельников on 30.01.2026.
//

import SwiftUI
import Utils
import Domain

public struct StandingsPage: View {
    @Binding var navigationManager: NavigationManager
    @StateObject private var viewModel: StandingsViewModel
    @State private var currentTab: Tab? = Tab.standings
    @State var tabProgress: CGFloat = 0
    
    private var tabs: [Tab] {
        viewModel.aheadMatches?.isEmpty == false ? Tab.allCases : [Tab.standings, Tab.players, Tab.matches]
    }
    
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
        GeometryReader {
            let size = $0.size
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 0) {
                    StandingsList()
                        .id(Tab.standings)
                        .containerRelativeFrame(.horizontal)
                    
                    ScorersList()
                        .id(Tab.players)
                        .containerRelativeFrame(.horizontal)
                    
                    CompMatches()
                        .id(Tab.matches)
                        .containerRelativeFrame(.horizontal)
                    
                    if viewModel.aheadMatches?.isEmpty == false {
                        AheadMatches()
                            .id(Tab.ahead)
                            .containerRelativeFrame(.horizontal)
                    }
                    
                    
                }
                .scrollTargetLayout()
                .offsetX { value in
                    let progress = -value / (size.width * CGFloat(tabs.count - 1))
                    tabProgress = max(min(progress, 1), 0)
                }
            }
        }
        .ignoresSafeArea(.container, edges: .horizontal)
        .background(Color.theme.background)
        .scrollPosition(id: $currentTab)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    navigationManager.pop()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.theme.primary)
                }
            }
            ToolbarItem(placement: .principal) {
                PinnedHeaderView()
            }
            ToolbarItem(placement: .topBarTrailing) {
                AsyncMultiImage(url: viewModel.standings?.competition.emblem).frame(height: 34)
            }
        }
        .snackbar(show: $viewModel.showSnackBar, bgColor: Color.theme.error, txtColor: Color.theme.surface, icon: "xmark", iconColor: Color.theme.surface, message: viewModel.errorMessage ?? "")
    }
    
    
    @ViewBuilder
    func PinnedHeaderView() -> some View {
        
        HStack(spacing: 0) {
            ForEach(tabs, id: \.rawValue) { tab in
                VStack(spacing: 0) {
                    Image(systemName: tab.systemImageName)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentTab = tab
                    }
                }
            }
        }
        .tabMask(tabProgress, tabs)
        .background {
            GeometryReader {
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(tabs.count)
                Capsule()
                    .fill(Color.theme.primaryContainer)
                    .frame(width: capsuleWidth)
                    .offset(x: tabProgress * (size.width - capsuleWidth))
            }
            
        }
        .background(.gray.opacity(0.1), in: .capsule)
        .animation(.easeInOut(duration: 0.3), value: tabs)
        .modifier(ConditionalGlassModifier())
    }
    
    @ViewBuilder
    func CompMatches() -> some View {
        if viewModel.isMatchesLoading && viewModel.completedMatches == nil {
            ZStack {
                BallProgressView().padding(.vertical, 80)
            }.frame(width: UIScreen.main.bounds.width)
        } else {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    let matches = viewModel.completedMatches ?? []
                    ForEach(matches, id: \.self) { groupMatches in
                        Section {
                            ForEach(groupMatches.matches, id: \.id) { match in
                                MatchItem(match: match, isAhead: false)
                            }
                        } header: {
                            MatchGroupHeader(matchesByTour: groupMatches)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func AheadMatches() -> some View {
        if viewModel.isMatchesLoading && viewModel.aheadMatches == nil {
            ZStack {
                BallProgressView().padding(.vertical, 80)
            }.frame(width: UIScreen.main.bounds.width)
        } else {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    let matches = viewModel.aheadMatches ?? []
                    ForEach(matches, id: \.self) { groupMatches in
                        Section {
                            ForEach(groupMatches.matches, id: \.id) { match in
                                MatchItem(match: match, isAhead: true)
                            }
                        } header: {
                            MatchGroupHeader(matchesByTour: groupMatches)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func StandingsList() -> some View {
        if viewModel.isStandingsLoading && viewModel.standings == nil {
            ZStack {
                BallProgressView().padding(.vertical, 80)
            }.frame(width: UIScreen.main.bounds.width)
        } else {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
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
                    StandingsBottomItem()
                        .padding(.horizontal, 4)
                        .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }
    
    @ViewBuilder
    func ScorersList() -> some View {
        if viewModel.isScorersLoading && viewModel.scorers == nil {
            ZStack {
                BallProgressView().padding(.vertical, 80)
            }.frame(width: UIScreen.main.bounds.width)
        } else {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    Section {
                        let lastId = viewModel.scorers?.scorers.last?.id
                        ForEach(Array((viewModel.scorers?.scorers ?? []).enumerated()), id: \.element.id) { index, scorer in
                            ScorerItem(scorer: scorer, scorersLastId: lastId, scorerIndex: index + 1)
                                .background(Color.theme.background)
                        }
                    } header: {
                        ScorersTopBar()
                    }
                    ScorersBottomItem()
                        .padding(.horizontal, 4)
                        .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        StandingsPage(navigationManager: .constant(MockData.navManager), viewModel: MockData.standingsViewModel)
            .loadCustomFonts()
    }
}
