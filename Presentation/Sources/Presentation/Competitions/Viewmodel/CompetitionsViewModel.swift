//
//  CompetitionsViewModel.swift
//  Presentation
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Domain
import Combine
import Utils

@MainActor
public final class CompetitionsViewModel: ObservableObject {
    private let repository: CompetitionsRepository
    @Published private(set) var competitions: [Competition] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published var showSnackBar: Bool = false
    private var loadCompetitionsTask: Task<Void, Never>?
    private var getAllCompetitionsFromLocalTask: Task<Void, Never>?
    
    public init(repository: CompetitionsRepository) {
        self.repository = repository
        getCompetitionsFlow()
        loadCompetitions()
    }
    
    func loadCompetitions() {
        loadCompetitionsTask?.cancel()
        loadCompetitionsTask = Task {
            isLoading = true
            errorMessage = nil
            showSnackBar = false
            
            let result = await repository.getAllCompetitionsFromRemoteToLocal()
            
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
    
    private func getCompetitionsFlow() {
        getAllCompetitionsFromLocalTask = Task {
            for await competitions in repository.getAllCompetitionsFromLocal() {
                self.competitions = competitions
            }
        }
    }
    
    deinit {
        loadCompetitionsTask?.cancel()
        getAllCompetitionsFromLocalTask?.cancel()
    }
}
