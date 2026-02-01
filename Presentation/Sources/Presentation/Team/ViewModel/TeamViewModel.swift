//
//  TeamViewModel.swift
//  Presentation
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation
import Domain
import Utils

@MainActor
public final class TeamViewModel: ObservableObject {
    
    private let repository: TeamRepository
    
    @Published private(set) var team: TeamInfo? = nil
    
    @Published private(set) var isTeamLoading = false
    
    @Published private(set) var errorMessage: String?
    
    @Published var showSnackBar: Bool = false
    
    private var loadTeamTask: Task<Void, Never>?
    private var getTeamFromLocalTask: Task<Void, Never>?
    
    private let teamId: Int
    
    public init(repository: TeamRepository, teamId: Int) {
        self.repository = repository
        self.teamId = teamId
        
        getTeamFlow()
        loadTeam()
    }
    
    private func loadTeam() {
        loadTeamTask?.cancel()
        loadTeamTask = Task {
            isTeamLoading = true
            errorMessage = nil
            showSnackBar = false
            
            let result = await repository.getTeamFromRemoteToLocal(teamId: teamId)
            
            switch result {
            case .success(_):
                isTeamLoading = false
            case .error(let errorType, _):
                let message = errorType?.errorMessage ?? Locale.get("UnknownError")
                self.errorMessage = message
                isTeamLoading = false
                showSnackBar = true
                print("❌ Fetch error: \(message)")
            }
        }
    }
    
    private func getTeamFlow() {
        getTeamFromLocalTask?.cancel()
        getTeamFromLocalTask = Task {
            for await team in repository.getTeamInfoFromLocalFlow(teamId: teamId) {
                self.team = team
            }
        }
    }
    
    deinit {
        loadTeamTask?.cancel()
        getTeamFromLocalTask?.cancel()
    }
    
}
