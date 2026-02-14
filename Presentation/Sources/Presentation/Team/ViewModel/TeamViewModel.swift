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
    @Published private(set) var aheadMatches: [MatchesByTour]? = nil
    @Published private(set) var completedMatches: [MatchesByTour]? = nil
    
    @Published private(set) var isTeamLoading = false
    @Published private(set) var isNewsLoading = false
    @Published private(set) var isMatchesLoading = false
    
    @Published private(set) var errorMessage: String?
    @Published var showSnackBar: Bool = false
    
    private var loadTeamTask: Task<Void, Never>?
    private var getTeamFromLocalTask: Task<Void, Never>?
    private var loadNewsTask: Task<Void, Never>?
    private var loadMatchesTask: Task<Void, Never>?
    private var getAheadMatchesFromLocalTask: Task<Void, Never>?
    private var getCompletedMatchesFromLocalTask: Task<Void, Never>?
    
    private(set) var teamId: Int
    
    public init(repository: TeamRepository, newsRepository: NewsRepository, teamId: Int) {
        self.newsRepository = newsRepository
        self.repository = repository
        self.teamId = teamId
        
        getTeamFlow()
        getAheadMatchesFlow()
        getCompletedMatchesFlow()
        
        loadTeam()
        loadMatches()
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
    
    private func loadMatches() {
        loadMatchesTask?.cancel()
        loadMatchesTask = Task {
            isMatchesLoading = true
            errorMessage = nil
            showSnackBar = false
            
            let result = await repository.getMatchesFromRemoteToLocal(teamId: teamId)
            
            switch result {
            case .success(_):
                isMatchesLoading = false
            case .error(let errorType, _):
                let message = errorType?.errorMessage ?? Locale.get("UnknownError")
                self.errorMessage = message
                isMatchesLoading = false
                showSnackBar = true
                print("❌ Fetch error: \(message)")
            }
        }
    }
    
    private func getAheadMatchesFlow() {
        getAheadMatchesFromLocalTask?.cancel()
        getAheadMatchesFromLocalTask = Task {
            for await matches in repository.getAheadMatchesFromLocalFlow(teamId: teamId) {
                self.aheadMatches = matches
            }
        }
    }
    
    private func getCompletedMatchesFlow() {
        getCompletedMatchesFromLocalTask?.cancel()
        getCompletedMatchesFromLocalTask = Task {
            for await matches in repository.getCompletedMatchesFromLocalFlow(teamId: teamId) {
                self.completedMatches = matches
            }
        }
    }
    
    deinit {
        loadTeamTask?.cancel()
        getTeamFromLocalTask?.cancel()
        loadNewsTask?.cancel()
        loadMatchesTask?.cancel()
        getAheadMatchesFromLocalTask?.cancel()
        getCompletedMatchesFromLocalTask?.cancel()
    }
    
}
