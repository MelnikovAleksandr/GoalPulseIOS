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
    
    @MainActor static let standingsRepository: StandingsRepository = MockStandingsRepository()
    
    @MainActor static let competitionsViewModel: CompetitionsViewModel = CompetitionsViewModel(repository: footballRepository)
    
    @MainActor static let standingsViewModel: StandingsViewModel =
        StandingsViewModel(repository: standingsRepository, compCode: "")
}

final class MockFootballRepository: CompetitionsRepository {
    func getAllCompetitionsFromLocal() -> AsyncStream<[Competition]> {
        AsyncStream { continuation in
            continuation.yield([MockUIData.competition])
            continuation.finish()
        }
    }
    
    func getAllCompetitionsFromRemoteToLocal() async -> Resource<Bool> {
        return .success(true)
    }
}

final class MockStandingsRepository: StandingsRepository {
    func getStandingsFromRemoteToLocal(compCode: String) async -> Utils.Resource<Bool> {
        return .success(true)
    }
    
    func getStandingsByIdFromLocal(compCode: String) -> AsyncStream<Domain.Standings> {
        AsyncStream { continuation in
            continuation.yield(MockUIData.standings)
            continuation.finish()
        }
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
            winner: Team(
                address: "",
                clubColors: "",
                crest: nil,
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
        type: .LEAGUE,
        seasons: []
    )
    
    static let standings: Standings = Standings(
            id: UUID().uuidString,
            area: Area(
                code: "NLD",
                flag: URL(string: "https://crests.football-data.org/8601.svg"),
                id: 2163,
                name: "Netherlands"
            ),
            competition: Competition(
                area: Area(
                    code: "NLD",
                    flag: URL(string: "https://crests.football-data.org/8601.svg"),
                    id: 2163,
                    name: "Netherlands"
                ),
                code: "DED",
                currentSeason: CurrentSeason(
                    currentMatchDay: 18,
                    startDateEndDate: "2025-08-08 - 2026-05-17",
                    endDate: "2026-05-17",
                    id: 2400,
                    startDate: "2025-08-08",
                    winner: nil
                ),
                emblem: URL(string: "https://crests.football-data.org/ec.png"),
                id: 2003,
                lastUpdated: "",
                name: "Eredivisie",
                numberOfAvailableSeasons: 0,
                plan: "",
                type: .LEAGUE,
                seasons: []
            ),
            season: CurrentSeason(
                currentMatchDay: 18,
                startDateEndDate: "2025-08-08 - 2026-05-17",
                endDate: "2026-05-17",
                id: 2400,
                startDate: "2025-08-08",
                winner: nil
            ),
            standings: [
                Standing(
                    stage: "REGULAR_SEASON",
                    type: "TOTAL",
                    group: "",
                    table: [
                        Table(
                            position: 1,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/674.png"),
                                founded: 0,
                                id: 674,
                                lastUpdated: "",
                                name: "PSV",
                                shortName: "PSV",
                                tla: "PSV",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 15,
                            draw: 1,
                            lost: 1,
                            points: 46,
                            goalsFor: 52,
                            goalsAgainst: 21,
                            goalDifference: 31
                        ),
                        Table(
                            position: 2,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/675.png"),
                                founded: 0,
                                id: 675,
                                lastUpdated: "",
                                name: "Feyenoord Rotterdam",
                                shortName: "Feyenoord",
                                tla: "FEY",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 11,
                            draw: 2,
                            lost: 4,
                            points: 35,
                            goalsFor: 42,
                            goalsAgainst: 21,
                            goalDifference: 21
                        ),
                        Table(
                            position: 3,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/678.png"),
                                founded: 0,
                                id: 678,
                                lastUpdated: "",
                                name: "AFC Ajax",
                                shortName: "Ajax",
                                tla: "AJA",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 8,
                            draw: 6,
                            lost: 3,
                            points: 30,
                            goalsFor: 32,
                            goalsAgainst: 22,
                            goalDifference: 10
                        ),
                        Table(
                            position: 4,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/1915.png"),
                                founded: 0,
                                id: 1915,
                                lastUpdated: "",
                                name: "NEC",
                                shortName: "NEC",
                                tla: "NEC",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 8,
                            draw: 5,
                            lost: 4,
                            points: 29,
                            goalsFor: 43,
                            goalsAgainst: 29,
                            goalDifference: 14
                        ),
                        Table(
                            position: 5,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/677.png"),
                                founded: 0,
                                id: 677,
                                lastUpdated: "",
                                name: "FC Groningen",
                                shortName: "Groningen",
                                tla: "GRO",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 8,
                            draw: 3,
                            lost: 6,
                            points: 27,
                            goalsFor: 25,
                            goalsAgainst: 22,
                            goalDifference: 3
                        ),
                        Table(
                            position: 6,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/666.png"),
                                founded: 0,
                                id: 666,
                                lastUpdated: "",
                                name: "FC Twente '65",
                                shortName: "Twente",
                                tla: "TWE",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 6,
                            draw: 7,
                            lost: 4,
                            points: 25,
                            goalsFor: 26,
                            goalsAgainst: 21,
                            goalDifference: 5
                        ),
                        Table(
                            position: 7,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/682.png"),
                                founded: 0,
                                id: 682,
                                lastUpdated: "",
                                name: "AZ",
                                shortName: "AZ",
                                tla: "AZ",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 16,
                            form: "",
                            won: 7,
                            draw: 4,
                            lost: 5,
                            points: 25,
                            goalsFor: 31,
                            goalsAgainst: 28,
                            goalDifference: 3
                        ),
                        Table(
                            position: 8,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/676.png"),
                                founded: 0,
                                id: 676,
                                lastUpdated: "",
                                name: "FC Utrecht",
                                shortName: "Utrecht",
                                tla: "UTR",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 6,
                            draw: 5,
                            lost: 6,
                            points: 23,
                            goalsFor: 28,
                            goalsAgainst: 23,
                            goalDifference: 5
                        ),
                        Table(
                            position: 9,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/673.png"),
                                founded: 0,
                                id: 673,
                                lastUpdated: "",
                                name: "SC Heerenveen",
                                shortName: "Heerenveen",
                                tla: "HEE",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 6,
                            draw: 5,
                            lost: 6,
                            points: 23,
                            goalsFor: 29,
                            goalsAgainst: 26,
                            goalDifference: 3
                        ),
                        Table(
                            position: 10,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/6806.png"),
                                founded: 0,
                                id: 6806,
                                lastUpdated: "",
                                name: "Sparta Rotterdam",
                                shortName: "Sparta",
                                tla: "SPA",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 7,
                            draw: 2,
                            lost: 8,
                            points: 23,
                            goalsFor: 18,
                            goalsAgainst: 31,
                            goalDifference: -13
                        ),
                        Table(
                            position: 11,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/1920.png"),
                                founded: 0,
                                id: 1920,
                                lastUpdated: "",
                                name: "Fortuna Sittard",
                                shortName: "Sittard",
                                tla: "SIT",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 6,
                            draw: 3,
                            lost: 8,
                            points: 21,
                            goalsFor: 25,
                            goalsAgainst: 29,
                            goalDifference: -4
                        ),
                        Table(
                            position: 12,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/718.png"),
                                founded: 0,
                                id: 718,
                                lastUpdated: "",
                                name: "Go Ahead Eagles",
                                shortName: "Go Ahead",
                                tla: "GOA",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 4,
                            draw: 7,
                            lost: 6,
                            points: 19,
                            goalsFor: 26,
                            goalsAgainst: 29,
                            goalDifference: -3
                        ),
                        Table(
                            position: 13,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/670.png"),
                                founded: 0,
                                id: 670,
                                lastUpdated: "",
                                name: "SBV Excelsior",
                                shortName: "Excelsior",
                                tla: "EXC",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 16,
                            form: "",
                            won: 6,
                            draw: 1,
                            lost: 9,
                            points: 19,
                            goalsFor: 16,
                            goalsAgainst: 27,
                            goalDifference: -11
                        ),
                        Table(
                            position: 14,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/684.png"),
                                founded: 0,
                                id: 684,
                                lastUpdated: "",
                                name: "PEC Zwolle",
                                shortName: "Zwolle",
                                tla: "ZWO",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 5,
                            draw: 4,
                            lost: 8,
                            points: 19,
                            goalsFor: 21,
                            goalsAgainst: 38,
                            goalDifference: -17
                        ),
                        Table(
                            position: 15,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/1912.png"),
                                founded: 0,
                                id: 1912,
                                lastUpdated: "",
                                name: "Telstar 1963",
                                shortName: "Telstar",
                                tla: "TEL",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 3,
                            draw: 6,
                            lost: 8,
                            points: 15,
                            goalsFor: 20,
                            goalsAgainst: 27,
                            goalDifference: -7
                        ),
                        Table(
                            position: 16,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/1919.png"),
                                founded: 0,
                                id: 1919,
                                lastUpdated: "",
                                name: "FC Volendam",
                                shortName: "Volendam",
                                tla: "VOL",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 3,
                            draw: 5,
                            lost: 9,
                            points: 14,
                            goalsFor: 19,
                            goalsAgainst: 31,
                            goalDifference: -12
                        ),
                        Table(
                            position: 17,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/671.png"),
                                founded: 0,
                                id: 671,
                                lastUpdated: "",
                                name: "Heracles Almelo",
                                shortName: "Heracles",
                                tla: "HER",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 4,
                            draw: 2,
                            lost: 11,
                            points: 14,
                            goalsFor: 26,
                            goalsAgainst: 44,
                            goalDifference: -18
                        ),
                        Table(
                            position: 18,
                            team: Team(
                                address: "",
                                clubColors: "",
                                crest: URL(string: "https://crests.football-data.org/681.png"),
                                founded: 0,
                                id: 681,
                                lastUpdated: "",
                                name: "NAC Breda",
                                shortName: "NAC",
                                tla: "NAC",
                                website: "",
                                venue: ""
                            ),
                            playedGames: 17,
                            form: "",
                            won: 3,
                            draw: 4,
                            lost: 10,
                            points: 13,
                            goalsFor: 16,
                            goalsAgainst: 26,
                            goalDifference: -10
                        )
                    ]
                )
            ]
        )
    
}
