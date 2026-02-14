//
//  PlayerViewModel.swift
//  Presentation
//
//  Created by Александр Мельников on 14.02.2026.
//

import Foundation
import Domain
import Utils

@MainActor
public final class PlayerViewModel: ObservableObject {
    
    private let repository: PlayerRepository
    @Published private(set) var player: PersonInfo? = nil
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published var showSnackBar: Bool = false
    private var loadPlayerTask: Task<Void, Never>?
    private(set) var playerId: Int
    
    public init(repository: PlayerRepository, playerId: Int) {
        self.repository = repository
        self.playerId = playerId
        
        loadPlayer()
    }
    
    private func loadPlayer() {
        loadPlayerTask?.cancel()
        loadPlayerTask = Task {
            isLoading = true
            errorMessage = nil
            showSnackBar = false
            
            let result = await repository.getPlayerInfo(playerId: playerId)
            
            switch result {
            case .success(let player):
                isLoading = false
                self.player = player
            case .error(let errorType, _):
                let message = errorType?.errorMessage ?? Locale.get("UnknownError")
                self.errorMessage = message
                isLoading = false
                showSnackBar = true
                print("❌ Fetch error: \(message)")
            }
        }
    }
    
    deinit {
        loadPlayerTask?.cancel()
    }
}
