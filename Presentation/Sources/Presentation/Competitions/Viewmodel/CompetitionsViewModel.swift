//
//  File.swift
//  Presentation
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Domain

@MainActor
@Observable
public final class CompetitionsViewModel {
    private let repository: FootballRepository
    private(set) var competitions: [Competition] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    public init(repository: FootballRepository) {
        self.repository = repository
        Task {
            await loadCompetitions()
        }
    }
    
    func loadCompetitions() async {
        isLoading = true
        errorMessage = nil
        
        let result = await repository.getAllCompetitionsFromRemoteToLocal()
        
        switch result {
        case .success(let competitions):
            self.competitions = competitions
            print("✅ Успешно загружено лиг: \(competitions.count)")
            competitions.forEach { competition in
                print("🏆 Лига: \(competition)")
            }
            
        case .error(let errorType, _):
            let message = errorType?.errorMessage ?? "Неизвестная ошибка"
            self.errorMessage = message
            print("❌ Ошибка загрузки: \(message)")
            
        case .loading:
            break
        }
        
        isLoading = false
    }
}
