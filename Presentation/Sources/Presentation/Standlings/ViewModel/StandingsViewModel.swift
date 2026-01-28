//
//  StandingsViewModel.swift
//  Presentation
//
//  Created by Александр Мельников on 29.12.2025.
//

import Foundation
import Domain
import Utils

@MainActor
public final class StandingsViewModel: ObservableObject {
    
    private let repository: StandingsRepository
    
    @Published private(set) var standings: Standings? = nil
    @Published private(set) var scorers: Scorers? = nil
    @Published private(set) var aheadMatches: [MatchesByTour]? = nil
    @Published private(set) var completedMatches: [MatchesByTour]? = nil
    
    @Published private(set) var isStandingsLoading = false
    @Published private(set) var isScorersLoading = false
    @Published private(set) var isMatchesLoading = false
    
    @Published private(set) var errorMessage: String?
    @Published var showSnackBar: Bool = false
    
    private var loadStandingsTask: Task<Void, Never>?
    private var getStandingsFromLocalTask: Task<Void, Never>?
    
    private var loadScorersTask: Task<Void, Never>?
    private var getScorersFromLocalTask: Task<Void, Never>?
    
    private var loadMatchesTask: Task<Void, Never>?
    private var getAheadMatchesFromLocalTask: Task<Void, Never>?
    private var getCompletedMatchesFromLocalTask: Task<Void, Never>?
    
    private let compCode: String
    
    public init(repository: StandingsRepository, compCode: String) {
        self.repository = repository
        self.compCode = compCode
        
        
        getStandingsFlow()
        getScorersFlow()
        getAheadMatchesFlow()
        getCompletedMatchesFlow()
        
        loadStandings()
        loadScorers()
        loadMatches()
    }
    
    private func loadStandings() {
        loadStandingsTask?.cancel()
        loadStandingsTask = Task {
            isStandingsLoading = true
            errorMessage = nil
            showSnackBar = false
            
            let result = await repository.getStandingsFromRemoteToLocal(compCode: compCode)
            
            switch result {
            case .success(_):
                isStandingsLoading = false
            case .error(let errorType, _):
                let message = errorType?.errorMessage ?? Locale.get("UnknownError")
                self.errorMessage = message
                isStandingsLoading = false
                showSnackBar = true
                print("❌ Fetch error: \(message)")
            }
        }
    }
    
    private func loadScorers() {
        loadScorersTask?.cancel()
        loadScorersTask = Task {
            isScorersLoading = true
            errorMessage = nil
            showSnackBar = false
            
            let result = await repository.getScorersFromRemoteToLocal(compCode: compCode)
            
            switch result {
            case .success(_):
                isScorersLoading = false
            case .error(let errorType, _):
                let message = errorType?.errorMessage ?? Locale.get("UnknownError")
                self.errorMessage = message
                isScorersLoading = false
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
            
            let result = await repository.getMatchesFromRemoteToLocal(compCode: compCode)
            
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
    
    private func getStandingsFlow() {
        getStandingsFromLocalTask?.cancel()
        getStandingsFromLocalTask = Task {
            for await standings in repository.getStandingsByIdFromLocal(compCode: compCode) {
                self.standings = standings
            }
        }
    }
    
    private func getScorersFlow() {
        getScorersFromLocalTask?.cancel()
        getScorersFromLocalTask = Task {
            for await scorers in repository.getScorersByCompCodeFromLocalFlow(compCode: compCode) {
                self.scorers = scorers
            }
        }
    }
    
    private func getAheadMatchesFlow() {
        getAheadMatchesFromLocalTask?.cancel()
        getAheadMatchesFromLocalTask = Task {
            for await matches in repository.getAheadMatchesFromLocalFlow(compCode: compCode) {
                print("TEST_TEST Ahead - \(matches.count)")
                self.aheadMatches = matches
            }
        }
    }
    
    private func getCompletedMatchesFlow() {
        getCompletedMatchesFromLocalTask?.cancel()
        getCompletedMatchesFromLocalTask = Task {
            for await matches in repository.getCompletedMatchesFromLocalFlow(compCode: compCode) {
                print("TEST_TEST Completed - \(matches.count)")
                self.completedMatches = matches
            }
        }
    }
    
    deinit {
        loadStandingsTask?.cancel()
        getStandingsFromLocalTask?.cancel()
        loadScorersTask?.cancel()
        getScorersFromLocalTask?.cancel()
        loadMatchesTask?.cancel()
        getAheadMatchesFromLocalTask?.cancel()
        getCompletedMatchesFromLocalTask?.cancel()
    }
}
