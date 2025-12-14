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
    
    @MainActor static let footballRepository: FootballRepository = MockFootballRepository()
    
    @MainActor static let competitionsViewModel: CompetitionsViewModel = CompetitionsViewModel(repository: footballRepository)
    
}

final class MockFootballRepository: FootballRepository {
    func getAllCompetitionsFromRemoteToLocal() async -> Resource<[Domain.Competition]> {
        return Resource.success([])
    }
}
