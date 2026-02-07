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
    
    private let newsRepository: NewsRepository
    
    @Published private(set) var team: TeamInfo? = nil
    
    @Published private(set) var articles: [Article] = []
    
    @Published private(set) var isTeamLoading = false
    
    @Published private(set) var isNewsLoading = false
    
    @Published private(set) var errorMessage: String?
    
    @Published var showSnackBar: Bool = false
    
    private var loadTeamTask: Task<Void, Never>?
    private var getTeamFromLocalTask: Task<Void, Never>?
    
    private var loadNewsTask: Task<Void, Never>?
    
    private let teamId: Int
    
    public init(repository: TeamRepository, newsRepository: NewsRepository, teamId: Int) {
        self.newsRepository = newsRepository
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
                if !team.name.isEmpty && loadNewsTask == nil {
                    loadNews(teamName: team.name)
                }
            }
        }
    }
    
    private func loadNews(teamName: String) {
        loadNewsTask?.cancel()
        loadNewsTask = Task {
            isNewsLoading = true
            errorMessage = nil
            showSnackBar = false
            
            let result = await newsRepository.getNews(teamName: teamName)
            
            switch result {
            case .success(let articles):
                self.articles = articles
                isNewsLoading = false
            case .error(let errorType, _):
                let message = errorType?.errorMessage ?? Locale.get("UnknownError")
                self.errorMessage = message
                isNewsLoading = false
                showSnackBar = true
                print("❌ Fetch error: \(message)")
            }
        }
    }
    
    deinit {
        loadTeamTask?.cancel()
        getTeamFromLocalTask?.cancel()
        loadNewsTask?.cancel()
    }
    
}
