//
//  MockData.swift
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

class MockUIData {
    
    static let competition: Competition = Competition(
        area: Area(
            code: "BRA",
            flag: URL(string: "https://crests.football-data.org/764.svg"),
            id: 2032,
            name: "Brazil"
        ),
        code: "BSA",
        currentSeason: CurrentSeason(
            currentMatchDay: 38,
            startDateEndDate: "2025-03-29 - 2025-12-21",
            endDate: "2025-12-21",
            id: 2371,
            startDate: "2025-03-29",
            winner: Winner(
                address: "",
                clubColors: "",
                crest: "",
                founded: 0,
                id: 0,
                lastUpdated: "",
                name: "",
                shortName: "",
                tla: "",
                website: "",
                venue: ""
            )
        ),
        emblem: URL(string: "https://crests.football-data.org/bsa.png"),
        id: 2013,
        lastUpdated: "2024-09-13T16:55:53Z",
        name: "Campeonato Brasileiro Série A",
        numberOfAvailableSeasons: 9,
        plan: "TIER_ONE",
        type: "LEAGUE",
        seasons: []
    )
    
}
