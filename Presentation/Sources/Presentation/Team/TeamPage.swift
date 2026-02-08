//
//  TeamPage.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import SwiftUI
import Utils
import Domain

public struct TeamPage: View {
    @Binding var navigationManager: NavigationManager
    @StateObject private var viewModel: TeamViewModel
    
    @State private var imageColors: [Color] = []
    @State private var currentTab: TabTeam? = TabTeam.team
    
    private var backgroundGradient: LinearGradient {
        if imageColors.count == 3 {
            return LinearGradient(
                gradient: Gradient(colors: imageColors),
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [Color.theme.background],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
    
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
        UITabBar.appearance().unselectedItemTintColor = UIColor.green
    }
    
    public var body: some View {
        
        TabView(selection: $currentTab) {
            
            SquadList().id(TabTeam.team)
                .tabItem {
                    Label(
                        TabTeam.team.localizedTitle.capitalized,
                        systemImage: TabTeam.team.systemImageName
                    )
                }
                .tag(TabTeam.team)
            
            TeamInfo()
                .id(TabTeam.info)
                .tabItem {
                    Label(
                        TabTeam.info.localizedTitle.capitalized,
                        systemImage: TabTeam.info.systemImageName
                    )
                }.tag(TabTeam.info)
            
            if viewModel.completedMatches?.isEmpty == false {
                CompMatches()
                    .id(TabTeam.matches)
                    .tabItem {
                        Label(
                            TabTeam.matches.localizedTitle.capitalized,
                            systemImage: TabTeam.matches.systemImageName
                        )
                    }.tag(TabTeam.matches)
            }
            
            
            if viewModel.aheadMatches?.isEmpty == false {
                AheadMatches()
                    .id(TabTeam.ahead)
                    .tabItem {
                        Label(
                            TabTeam.ahead.localizedTitle.capitalized,
                            systemImage: TabTeam.ahead.systemImageName
                        )
                    }.tag(TabTeam.ahead)
            }
            
            
        }
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
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
                VStack(spacing: 0) {
                    Text(viewModel.team?.name ?? "Empty Name")
                        .foregroundColor(Color.theme.primary)
                        .font(.theme.medium(22))
                        .padding(.horizontal, 24)
                    Text(currentTab?.localizedTitle.capitalized ?? "")
                        .foregroundColor(Color.theme.secondary)
                        .font(.theme.light(16))
                        .padding(.horizontal, 24)
                        .animation(.smooth, value: currentTab)
                }
                .modifier(ConditionalGlassModifier())
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                AsyncMultiImage(
                    url: viewModel.team?.crest,
                    extractColors: true,
                    onColorsExtracted: { colors in
                        imageColors = colors
                    }
                ).frame(width: 34, height: 34)
            }
            
        }
        .tint(Color.theme.primary)
        .snackbar(show: $viewModel.showSnackBar, bgColor: Color.theme.error, txtColor: Color.theme.surface, icon: "xmark", iconColor: Color.theme.surface, message: viewModel.errorMessage ?? "")
        
    }
    
    @ViewBuilder
    func TeamInfo() -> some View {
        ZStack {
            backgroundGradient
                .animation(.easeInOut(duration: 0.5), value: imageColors)
                .opacity(0.50)
                .ignoresSafeArea()
            if viewModel.isTeamLoading && viewModel.team == nil {
                ZStack {
                    BallProgressView().padding(.vertical, 80)
                }.frame(width: UIScreen.main.bounds.width)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        if let team = viewModel.team {
                            InfoItem(team: team)
                        }
                        if viewModel.isNewsLoading {
                            ZStack {
                                BallProgressView().padding(.vertical, 80)
                            }.frame(width: UIScreen.main.bounds.width)
                        } else {
                            ForEach(viewModel.articles, id: \.id) { article in
                                ArticleItem(article: article)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func SquadList() -> some View {
        ZStack {
            backgroundGradient
                .animation(.easeInOut(duration: 0.5), value: imageColors)
                .opacity(0.50)
                .ignoresSafeArea()
            if viewModel.isTeamLoading && viewModel.team == nil {
                ZStack {
                    BallProgressView().padding(.vertical, 80)
                }.frame(width: UIScreen.main.bounds.width)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                        let positionsSquad = viewModel.team?.squad ?? []
                        if let coach = viewModel.team?.coach {
                            CoachItem(player: coach)
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 0.3), value: coach.id)
                        }
                        ForEach(positionsSquad, id: \.id) { positionSquad in
                            Section {
                                ForEach(positionSquad.squad, id: \.id) { player in
                                    SquadItem(player: player)
                                }
                            } header: {
                                SquadHeader(
                                    position: positionSquad.position,
                                    color: imageColors.indices.contains(2) ? imageColors[2] : Color.theme.primaryContainer
                                )
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @ViewBuilder
    func CompMatches() -> some View {
        ZStack {
            backgroundGradient
                .animation(.easeInOut(duration: 0.5), value: imageColors)
                .opacity(0.50)
                .ignoresSafeArea()
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
                                    MatchItem(match: match, isAhead: false, teamId: viewModel.teamId)
                                }
                            } header: {
                                MatchGroupHeader(matchesByTour: groupMatches)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func AheadMatches() -> some View {
        ZStack {
            backgroundGradient
                .animation(.easeInOut(duration: 0.5), value: imageColors)
                .opacity(0.50)
                .ignoresSafeArea()
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
    }
}

#Preview {
    NavigationStack {
        TeamPage(navigationManager: .constant(MockData.navManager), viewModel: MockData.teamViewModel)
            .loadCustomFonts()
    }
}
