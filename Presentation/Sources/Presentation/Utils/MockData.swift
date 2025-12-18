//
//  File.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import Foundation
import Utils
import Domain

class MockData {
    
    @MainActor static let navManager: NavigationManager = NavigationManagerImpl()
    
    @MainActor static let footballRepository: CompetitionsRepository = MockFootballRepository()
    
    @MainActor static let competitionsViewModel: CompetitionsViewModel = CompetitionsViewModel(repository: footballRepository)
    
}

final class MockFootballRepository: CompetitionsRepository {
    func getAllCompetitionsFromLocal() -> AsyncStream<[Competition]> {
        AsyncStream { continuation in
            continuation.yield([])
            continuation.finish()
        }
    }
    
    func getAllCompetitionsFromRemoteToLocal() async -> Resource<[Competition]> {
        return .success([])
    }
}
