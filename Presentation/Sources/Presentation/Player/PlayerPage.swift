//
//  SwiftUIView.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import SwiftUI
import Utils

public struct PlayerPage: View {
    @Binding var navigationManager: NavigationManager
    @StateObject private var viewModel: PlayerViewModel
    
    public init(
        navigationManager: Binding<NavigationManager>,
        playerId: Int
    ) {
        self._navigationManager = navigationManager
        self._viewModel = StateObject(wrappedValue: ResolverApp.shared.resolve(PlayerViewModel.self, argument: playerId))
    }
    
    // Preview init
    public init(
        navigationManager: Binding<NavigationManager>,
        viewModel: PlayerViewModel
    ) {
        self._navigationManager = navigationManager
        self._viewModel = StateObject(wrappedValue: viewModel)
        UITabBar.appearance().unselectedItemTintColor = UIColor.green
    }
    
    public var body: some View {
        ZStack {
            LoadingPlayerView(videoName: "player_back").ignoresSafeArea(.all)
            if viewModel.isLoading && viewModel.player == nil {
                ZStack {
                    BallProgressView().padding(.vertical, 80)
                }.frame(width: UIScreen.main.bounds.width)
            } else {
                if viewModel.player == nil {
                    EmptyData()
                } else {
                    VStack {
                        Text(viewModel.player?.name ?? "EMPTY")
                        Text(viewModel.player?.nationality ?? "EMPTY")
                    }
                }
            }
        }
        .animation(.spring(), value: viewModel.player)
        .animation(.spring(), value: viewModel.isLoading)
        .snackbar(show: $viewModel.showSnackBar, bgColor: Color.theme.error, txtColor: Color.theme.surface, icon: "xmark", iconColor: Color.theme.surface, message: viewModel.errorMessage ?? "")
    }
}

#Preview {
    PlayerPage(navigationManager: .constant(MockData.navManager), viewModel: MockData.playerViewModel)
        .loadCustomFonts()
}
