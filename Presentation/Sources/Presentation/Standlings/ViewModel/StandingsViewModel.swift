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
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published var showSnackBar: Bool = false
    private var loadStandingsTask: Task<Void, Never>?
    private var getStandingsFromLocalTask: Task<Void, Never>?
    private let compCode: String
    
    public init(repository: StandingsRepository, compCode: String) {
        self.repository = repository
        self.compCode = compCode
        
        getStandingsFlow()
        loadStandings()
    }
    
    func loadStandings() {
        loadStandingsTask?.cancel()
        loadStandingsTask = Task {
            isLoading = true
            errorMessage = nil
            showSnackBar = false
            
            let result = await repository.getStandingsFromRemoteToLocal(compCode: compCode)
            
            switch result {
            case .success(_):
                isLoading = false
            case .error(let errorType, _):
                let message = errorType?.errorMessage ?? Locale.get("UnknownError")
                self.errorMessage = message
                isLoading = false
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
    
    deinit {
        loadStandingsTask?.cancel()
        getStandingsFromLocalTask?.cancel()
    }
}
