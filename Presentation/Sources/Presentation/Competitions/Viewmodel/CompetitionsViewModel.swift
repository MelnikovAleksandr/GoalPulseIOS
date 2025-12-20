//
//  CompetitionsViewModel.swift
//  Presentation
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Domain
import Combine

@MainActor
public final class CompetitionsViewModel: ObservableObject {
    private let repository: CompetitionsRepository
    @Published private(set) var competitions: [Competition] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
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
            
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            
            errorMessage = nil
            
            let result = await repository.getAllCompetitionsFromRemoteToLocal()
            
            switch result {
            case .success(let competitions):
                isLoading = false
                print("✅ Успешно загружено лиг: \(competitions.count)")
                
            case .error(let errorType, _):
                let message = errorType?.errorMessage ?? "Неизвестная ошибка"
                self.errorMessage = message
                isLoading = false
                print("❌ Ошибка загрузки: \(message)")
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
