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
    @Namespace var animation
    @Binding var navigationManager: NavigationManager
    @StateObject private var viewModel: StandingsViewModel
    @State private var currentTab: Tab? = Tab.standings
    @State var headerOffsets: (CGFloat, CGFloat) = (0,0)
    @State var tabProgress: CGFloat = 0
    
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
            if #available(iOS 26.1, *) {
                ScrollViewStandings()
                    .scrollEdgeEffectHidden()
            } else {
                ScrollViewStandings()
            }
        }
    }
    
    
    @ViewBuilder
    func ScrollViewStandings() -> some View {
        
        GeometryReader {
            let size = $0.size
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HeaderView()
                    
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                            Section {
                                ScrollView(.horizontal) {
                                    LazyHStack(spacing: 0) {
                                        StandingsList()
                                            .id(Tab.standings)
                                        
                                        StandingsList()
                                            .id(Tab.players)
                                        
                                        StandingsList()
                                            .id(Tab.matches)
                                        
                                    }
                                    .scrollTargetLayout()
                                    .offsetX { value in
                                        let progress = -value / (size.width * CGFloat(Tab.allCases.count - 1))
                                        tabProgress = max(min(progress, 1), 0)
                                    }
                                }
                                .scrollPosition(id: $currentTab)
                                .scrollIndicators(.hidden)
                                .scrollTargetBehavior(.paging)
                            } header: {
                                PinnedHeaderView()
                                    .background(Color.theme.background)
                                    .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 6)
                                    .modifier(OffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                                    .modifier(OffsetModifier(offset: $headerOffsets.1))
                            }
       
                    }
                }
            }
            .background(Color.theme.background)
            .overlay(content: {
                Rectangle()
                    .fill(Color.theme.background)
                    .frame(height: 50)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .opacity(headerOffsets.0 < 20 ? 1 : 0)
            })
            .coordinateSpace(name: "SCROLL")
            .ignoresSafeArea(.container, edges: .all)
            .toolbar(headerOffsets.0 < 20 ? .hidden : .visible, for: .navigationBar)
            .animation(.easeInOut(duration: 0.1), value: headerOffsets.0 < 20)
        }
        
    }
    
    @ViewBuilder
    func StandingsList() -> some View {
        VStack(spacing: 0) {
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
            BottomItem()
                .padding(.horizontal, 4)
                .frame(width: UIScreen.main.bounds.width)
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = (size.height + minY)
            let progress = max(0, min(1, (height / size.height)))
            ZStack {
                Color.theme.primaryContainer
                AsyncMultiImage(url: viewModel.standings?.competition.emblem)
                    .frame(width: size.width * 0.75, height: (height * 0.75) > 0 ? (height * 0.75) : 0, alignment: .top)
                    .aspectRatio(contentMode: .fill)
                    .padding(20)
            }
            .frame(width: size.width, height: height > 0 ? height : 0, alignment: .top)
            .overlay(content: {
                ZStack(alignment: .bottom) {
                    LinearGradient(colors: [
                        .clear,
                        Color.theme.primary.opacity(0.8)
                    ], startPoint: .top, endPoint: .bottom)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.standings?.competition.name ?? "")
                            .font(.theme.bold(32))
                            .foregroundColor(Color.theme.onPrimary.opacity(progress))
                            .lineLimit(1)
                            .padding(10)
                    }
                    .scaleEffect(progress)
                }
            })
            .cornerRadius(15)
            .offset(y: -minY)
        }
        .frame(height: 250)
    }
    
    @ViewBuilder
    func PinnedHeaderView() -> some View {
        ZStack(alignment: .bottom) {
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { type in
                    Text(type.localizedTitle.capitalized)
                        .foregroundColor(currentTab == type ? Color.theme.primary : .gray)
                        .font(.theme.medium(18))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                currentTab = type
                            }
                        }
                }
            }
            GeometryReader { geometry in
                let size = geometry.size
                let width = size.width / CGFloat(Tab.allCases.count)
                
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(Color.theme.primary)
                    .matchedGeometryEffect(id: "TAB", in: animation)
                    .frame(width: width, height: 4)
                    .offset(x: tabProgress * (size.width - width))
            }
            .frame(height: 4)
        }
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom, 5)
    }
}

#Preview {
    StandingsPage(navigationManager: .constant(MockData.navManager), viewModel: MockData.standingsViewModel)
        .loadCustomFonts()
}
