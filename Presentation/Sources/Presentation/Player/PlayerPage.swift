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
                    ScrollView {
                        
                        Image(viewModel.player?.position.imageName ?? "offence")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Capsule())
                            .modifier(ConditionalGlassModifier())
                        
                        RowItem(rowTitile: Locale.get("Name"), rowData: viewModel.player?.name ?? "")
                        RowItem(rowTitile: Locale.get("Age"), rowData: "\(viewModel.player?.age ?? 0)")
                        RowItem(rowTitile: Locale.get("Nation"), rowData: viewModel.player?.nationality ?? "")
                        RowItem(rowTitile: Locale.get("Position"), rowData: viewModel.player?.position.localizedTitle ?? "")
                        RowItem(rowTitile: Locale.get("Shirt"), rowData: "\(viewModel.player?.shirtNumber ?? 0)")
                    }
                }
            }
        }
        .animation(.spring(), value: viewModel.player)
        .animation(.spring(), value: viewModel.isLoading)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.player?.name ?? "")
                    .foregroundColor(Color.theme.primary)
                    .font(.theme.medium(22))
                    .padding(.horizontal, 24)
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                AsyncMultiImage(
                    url: viewModel.player?.currentTeam.crest
                ).frame(width: 34, height: 34)
            }
            
        }
        .snackbar(show: $viewModel.showSnackBar, bgColor: Color.theme.error, txtColor: Color.theme.surface, icon: "xmark", iconColor: Color.theme.surface, message: viewModel.errorMessage ?? "")
    }
}

#Preview {
    NavigationStack {
        PlayerPage(navigationManager: .constant(MockData.navManager), viewModel: MockData.playerViewModel)
            .loadCustomFonts()
    }
}
