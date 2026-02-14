//
//  MockData.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import Foundation
import Utils
import Domain
import SwiftUI

class MockData {
    
    @MainActor static let navManager: NavigationManager = MockNavManager()
    
    @MainActor static let footballRepository: CompetitionsRepository = MockFootballRepository()
    
    @MainActor static let standingsRepository: StandingsRepository = MockStandingsRepository()
    
    @MainActor static let competitionsViewModel: CompetitionsViewModel = CompetitionsViewModel(repository: footballRepository)
    
    @MainActor static let standingsViewModel: StandingsViewModel =
    StandingsViewModel(repository: standingsRepository, compCode: "")
    
    @MainActor static let teamRepository: TeamRepository = MockTeamRepository()
    
    @MainActor static let newsRepository: NewsRepository = MockNewsRepository()
    
    @MainActor static let teamViewModel: TeamViewModel =
    TeamViewModel(repository: teamRepository, newsRepository: newsRepository, teamId: 11)
    
    @MainActor static let playerRepository: PlayerRepository = MockPlayerRepository()
    
    @MainActor static let playerViewModel: PlayerViewModel = PlayerViewModel(repository: playerRepository, playerId: 11)
}

@Observable
final class MockNavManager: NavigationManager {
    
    public init() {}
    
    public var path = NavigationPath()
    
    public func toStandlings(compCode: String) {
        path.append(Routes.standlings(compCode: compCode))
    }
    
    public func toTeamDetails(teamId: Int) {
        path.append(Routes.team(teamId: teamId))
    }
    
    public func toPlayerDetails(playerId: Int) {
        path.append(Routes.player(playerId: playerId))
    }
    
    public func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    public func popToRoot() {
        path = NavigationPath()
    }
}

final class MockPlayerRepository: PlayerRepository {
    func getPlayerInfo(playerId: Int) async -> Resource<PersonInfo> {
        return .success(MockUIData.personInfo())
    }
}

final class MockNewsRepository: NewsRepository {
    func getNews(teamName: String) async -> Resource<[Article]> {
        return .success(MockUIData.articles)
    }
}

final class MockTeamRepository: TeamRepository {
    func getTeamFromRemoteToLocal(teamId: Int) async -> Utils.Resource<Bool> {
        return .success(true)
    }
    
    func getTeamInfoFromLocalFlow(teamId: Int) -> AsyncStream<Domain.TeamInfo> {
        AsyncStream { continuation in
            continuation.yield(MockUIData.getTeamInfo())
            continuation.finish()
        }
    }
    
    func getMatchesFromRemoteToLocal(teamId: Int) async -> Resource<Bool> {
        return .success(true)
    }
    
    func getAheadMatchesFromLocalFlow(teamId: Int) -> AsyncStream<[MatchesByTour]> {
        AsyncStream { continuation in
            continuation.yield(MockUIData.getMatchesByTour())
            continuation.finish()
        }
    }
    
    func getCompletedMatchesFromLocalFlow(teamId: Int) -> AsyncStream<[MatchesByTour]> {
        AsyncStream { continuation in
            continuation.yield(MockUIData.getMatchesByTour())
            continuation.finish()
        }
    }
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
    
    func getScorersFromRemoteToLocal(compCode: String) async -> Resource<Bool> {
        return .success(true)
    }
    
    func getMatchesFromRemoteToLocal(compCode: String) async -> Resource<Bool> {
        return .success(true)
    }
    
    func getStandingsByIdFromLocal(compCode: String) -> AsyncStream<Domain.Standings> {
        AsyncStream { continuation in
            continuation.yield(MockUIData.standings)
            continuation.finish()
        }
    }
    
    func getScorersByCompCodeFromLocalFlow(compCode: String) -> AsyncStream<Scorers> {
        AsyncStream { continuation in
            continuation.yield(MockUIData.scorers())
            continuation.finish()
        }
    }
    
    func getAheadMatchesFromLocalFlow(compCode: String) -> AsyncStream<[MatchesByTour]> {
        AsyncStream { continuation in
            continuation.yield(MockUIData.getMatchesByTour())
            continuation.finish()
        }
    }
    
    func getCompletedMatchesFromLocalFlow(compCode: String) -> AsyncStream<[MatchesByTour]> {
        AsyncStream { continuation in
            continuation.yield(MockUIData.getMatchesByTour())
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
    
    static func scorers() -> Scorers {
        let competition = Competition(
            area: Area(
                code: "NED",
                flag: nil,
                id: 0,
                name: "Netherlands"
            ),
            code: "DED",
            currentSeason: CurrentSeason(
                currentMatchDay: 19,
                startDateEndDate: "2025-08-08 - 2026-05-17",
                endDate: "2026-05-17",
                id: 2400,
                startDate: "2025-08-08",
                winner: nil
            ),
            emblem: URL(string: "https://crests.football-data.org/ED.png"),
            id: 2003,
            lastUpdated: "",
            name: "Eredivisie",
            numberOfAvailableSeasons: 0,
            type: .LEAGUE,
            seasons: []
        )
        
        let season = CurrentSeason(
            currentMatchDay: 19,
            startDateEndDate: "2025-08-08 - 2026-05-17",
            endDate: "2026-05-17",
            id: 2400,
            startDate: "2025-08-08",
            winner: nil
        )
        
        let scorers = [
            Scorer(
                id: 119460,
                player: Player(
                    id: 119460,
                    name: "Ayase Ueda",
                    firstName: "Ayase",
                    lastName: "Ueda",
                    dateOfBirth: "1998-09-10",
                    nationality: "Japan",
                    section: "Centre-Forward",
                    shirtNumber: 36
                ),
                team: Team(
                    address: "Van Zandvlietplein 3 Rotterdam 3007 AP",
                    clubColors: "Red / White / Black",
                    crest: URL(string: "https://crests.football-data.org/675.png"),
                    founded: 1908,
                    id: 675,
                    lastUpdated: "2022-03-24T17:06:52Z",
                    name: "Feyenoord Rotterdam",
                    shortName: "Feyenoord",
                    tla: "FEY",
                    website: "http://www.feyenoord.nl",
                    venue: "Stadion Feijenoord"
                ),
                playedMatches: 18,
                goals: 18,
                assists: 1,
                penalties: 0
            ),
            Scorer(
                id: 7688,
                player: Player(
                    id: 7688,
                    name: "Guus Til",
                    firstName: "Guus",
                    lastName: "Til",
                    dateOfBirth: "1997-12-22",
                    nationality: "Netherlands",
                    section: "Attacking Midfield",
                    shirtNumber: 8
                ),
                team: Team(
                    address: "Fredriklaan 10a Eindhoven 5616 NH",
                    clubColors: "Red / White",
                    crest: URL(string: "https://crests.football-data.org/674.png"),
                    founded: 1913,
                    id: 674,
                    lastUpdated: "2022-03-06T09:30:40Z",
                    name: "PSV",
                    shortName: "PSV",
                    tla: "PSV",
                    website: "http://www.psv.nl",
                    venue: "Philips Stadion"
                ),
                playedMatches: 18,
                goals: 11,
                assists: 2,
                penalties: 0
            ),
            Scorer(
                id: 7432,
                player: Player(
                    id: 7432,
                    name: "Jizz Hornkamp",
                    firstName: "Jizz",
                    lastName: "Hornkamp",
                    dateOfBirth: "1998-03-07",
                    nationality: "Netherlands",
                    section: "Centre-Forward",
                    shirtNumber: 9
                ),
                team: Team(
                    address: "Stadionlaan 1 Almelo 7606 JZ",
                    clubColors: "Black / White",
                    crest: URL(string: "https://crests.football-data.org/671.png"),
                    founded: 1903,
                    id: 671,
                    lastUpdated: "2022-03-22T10:10:18Z",
                    name: "Heracles Almelo",
                    shortName: "Heracles",
                    tla: "HER",
                    website: "http://www.heracles.nl",
                    venue: "Erve Asito"
                ),
                playedMatches: 15,
                goals: 10,
                assists: 1,
                penalties: 1
            ),
            Scorer(
                id: 131041,
                player: Player(
                    id: 131041,
                    name: "Troy Parrott",
                    firstName: "Troy",
                    lastName: "Parrott",
                    dateOfBirth: "2002-02-04",
                    nationality: "Ireland",
                    section: "Centre-Forward",
                    shirtNumber: 0
                ),
                team: Team(
                    address: "Stadionweg 1 Alkmaar 1812 AZ",
                    clubColors: "Red / White",
                    crest: URL(string: "https://crests.football-data.org/682.png"),
                    founded: 1967,
                    id: 682,
                    lastUpdated: "2022-03-22T10:11:18Z",
                    name: "AZ",
                    shortName: "AZ",
                    tla: "AZ",
                    website: "http://www.az.nl",
                    venue: "AFAS Stadion"
                ),
                playedMatches: 12,
                goals: 9,
                assists: 1,
                penalties: 2
            ),
            Scorer(
                id: 38124,
                player: Player(
                    id: 38124,
                    name: "Tobias Lauritsen",
                    firstName: "Tobias",
                    lastName: "Lauritsen",
                    dateOfBirth: "1997-08-30",
                    nationality: "Norway",
                    section: "Centre-Forward",
                    shirtNumber: 20
                ),
                team: Team(
                    address: "Spartapark Noord 1 Rotterdam 3027 VW",
                    clubColors: "Red / White / Black",
                    crest: URL(string: "https://crests.football-data.org/6806.png"),
                    founded: 1888,
                    id: 6806,
                    lastUpdated: "2022-03-22T10:09:59Z",
                    name: "Sparta Rotterdam",
                    shortName: "Sparta",
                    tla: "SPA",
                    website: "http://www.sparta-rotterdam.nl",
                    venue: "Sparta-Stadion Het Kasteel"
                ),
                playedMatches: 18,
                goals: 9,
                assists: 2,
                penalties: 3
            ),
            Scorer(
                id: 130173,
                player: Player(
                    id: 130173,
                    name: "Ismael Saibari",
                    firstName: "Ismael",
                    lastName: "Saibari",
                    dateOfBirth: "2001-01-28",
                    nationality: "Morocco",
                    section: "Central Midfield",
                    shirtNumber: 9
                ),
                team: Team(
                    address: "Fredriklaan 10a Eindhoven 5616 NH",
                    clubColors: "Red / White",
                    crest: URL(string: "https://crests.football-data.org/674.png"),
                    founded: 1913,
                    id: 674,
                    lastUpdated: "2022-03-06T09:30:40Z",
                    name: "PSV",
                    shortName: "PSV",
                    tla: "PSV",
                    website: "http://www.psv.nl",
                    venue: "Philips Stadion"
                ),
                playedMatches: 16,
                goals: 9,
                assists: 2,
                penalties: 1
            ),
            Scorer(
                id: 53426,
                player: Player(
                    id: 53426,
                    name: "Joey Veerman",
                    firstName: "Joey",
                    lastName: "Veerman",
                    dateOfBirth: "1998-11-19",
                    nationality: "Netherlands",
                    section: "Central Midfield",
                    shirtNumber: 0
                ),
                team: Team(
                    address: "Fredriklaan 10a Eindhoven 5616 NH",
                    clubColors: "Red / White",
                    crest: URL(string: "https://crests.football-data.org/674.png"),
                    founded: 1913,
                    id: 674,
                    lastUpdated: "2022-03-06T09:30:40Z",
                    name: "PSV",
                    shortName: "PSV",
                    tla: "PSV",
                    website: "http://www.psv.nl",
                    venue: "Philips Stadion"
                ),
                playedMatches: 17,
                goals: 8,
                assists: 8,
                penalties: 0
            ),
            Scorer(
                id: 9701,
                player: Player(
                    id: 9701,
                    name: "Koen Kostons",
                    firstName: "Koen",
                    lastName: "Kostons",
                    dateOfBirth: "1999-09-18",
                    nationality: "Netherlands",
                    section: "Centre-Forward",
                    shirtNumber: 16
                ),
                team: Team(
                    address: "Stadionplein 1 Zwolle 8025 CP",
                    clubColors: "Blue / White",
                    crest: URL(string: "https://crests.football-data.org/684.png"),
                    founded: 1910,
                    id: 684,
                    lastUpdated: "2022-03-22T10:11:39Z",
                    name: "PEC Zwolle",
                    shortName: "Zwolle",
                    tla: "ZWO",
                    website: "http://www.peczwolle.nl",
                    venue: "MAC³PARK Stadion"
                ),
                playedMatches: 18,
                goals: 8,
                assists: 4,
                penalties: 0
            ),
            Scorer(
                id: 189574,
                player: Player(
                    id: 189574,
                    name: "Mika Godts",
                    firstName: "Mika",
                    lastName: "Godts",
                    dateOfBirth: "2005-06-07",
                    nationality: "Belgium",
                    section: "Left Winger",
                    shirtNumber: 0
                ),
                team: Team(
                    address: "ArenA Boulevard 29 Amsterdam 1101 AX",
                    clubColors: "Red / White",
                    crest: URL(string: "https://crests.football-data.org/678.png"),
                    founded: 1900,
                    id: 678,
                    lastUpdated: "2022-03-22T10:11:05Z",
                    name: "AFC Ajax",
                    shortName: "Ajax",
                    tla: "AJA",
                    website: "http://www.ajax.nl",
                    venue: "Johan Cruyff ArenA"
                ),
                playedMatches: 16,
                goals: 8,
                assists: 6,
                penalties: 0
            ),
            Scorer(
                id: 119731,
                player: Player(
                    id: 119731,
                    name: "Ricardo Pepi",
                    firstName: "Ricardo",
                    lastName: "Pepi",
                    dateOfBirth: "2003-01-09",
                    nationality: "USA",
                    section: "Centre-Forward",
                    shirtNumber: 16
                ),
                team: Team(
                    address: "Fredriklaan 10a Eindhoven 5616 NH",
                    clubColors: "Red / White",
                    crest: URL(string: "https://crests.football-data.org/674.png"),
                    founded: 1913,
                    id: 674,
                    lastUpdated: "2022-03-06T09:30:40Z",
                    name: "PSV",
                    shortName: "PSV",
                    tla: "PSV",
                    website: "http://www.psv.nl",
                    venue: "Philips Stadion"
                ),
                playedMatches: 15,
                goals: 8,
                assists: 0,
                penalties: 1
            )
        ]
        
        return Scorers(
            id: "DED",
            competition: competition,
            season: season,
            scorers: scorers
        )
    }
    
    static func getMatchesByTour() -> [MatchesByTour] {
        let dateFormatter = ISO8601DateFormatter()
        
        let tour1Matches = [
            Match(
                id: 537441,
                status: "FINISHED",
                homeTeam: Team(
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
                awayTeam: Team(
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
                score: Score(
                    winner: .draw,
                    time: Time(home: 2, away: 2)
                ),
                dateTime: dateFormatter.date(from: "2025-08-08T18:00:00Z")!
            )
        ]
        
        let tour2Matches = [
            Match(
                id: 537442,
                status: "FINISHED",
                homeTeam: Team(
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
                awayTeam: Team(
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
                score: Score(
                    winner: .home,
                    time: Time(home: 5, away: 0)
                ),
                dateTime: dateFormatter.date(from: "2025-08-09T14:30:00Z")!
            ),
            Match(
                id: 537443,
                status: "FINISHED",
                homeTeam: Team(
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
                awayTeam: Team(
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
                score: Score(
                    winner: .home,
                    time: Time(home: 2, away: 0)
                ),
                dateTime: dateFormatter.date(from: "2025-08-09T16:45:00Z")!
            ),
            Match(
                id: 537444,
                status: "FINISHED",
                homeTeam: Team(
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
                awayTeam: Team(
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
                score: Score(
                    winner: .draw,
                    time: Time(home: 1, away: 1)
                ),
                dateTime: dateFormatter.date(from: "2025-08-09T18:00:00Z")!
            ),
            Match(
                id: 537445,
                status: "FINISHED",
                homeTeam: Team(
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
                awayTeam: Team(
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
                score: Score(
                    winner: .home,
                    time: Time(home: 6, away: 1)
                ),
                dateTime: dateFormatter.date(from: "2025-08-09T19:00:00Z")!
            )
        ]
        
        let tour3Matches = [
            Match(
                id: 537450,
                status: "FINISHED",
                homeTeam: Team(
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
                awayTeam: Team(
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
                score: Score(
                    winner: .away,
                    time: Time(home: 0, away: 2)
                ),
                dateTime: dateFormatter.date(from: "2025-08-15T18:00:00Z")!
            )
        ]
        
        return [
            MatchesByTour(
                matchday: 1,
                stage: "REGULAR_SEASON",
                seasonType: "LEAGUE",
                matches: tour1Matches
            ),
            MatchesByTour(
                matchday: 2,
                stage: "REGULAR_SEASON",
                seasonType: "LEAGUE",
                matches: tour2Matches
            ),
            MatchesByTour(
                matchday: 3,
                stage: "REGULAR_SEASON",
                seasonType: "LEAGUE",
                matches: tour3Matches
            )
        ]
    }
    
    static func getTeamInfo() -> TeamInfo {
        let dateFormatter = ISO8601DateFormatter()
        
        let contract = Contract(
            start: dateFormatter.date(from: "2022-09-01T00:00:00Z")!,
            until: dateFormatter.date(from: "2026-06-30T00:00:00Z")!
        )
        
        let coach = Person(
            id: 124504,
            name: "Jacob Neestrup",
            firstName: "Jacob",
            lastName: "Neestrup",
            dateOfBirth: dateFormatter.date(from: "1988-03-08T00:00:00Z")!,
            nationality: "Denmark",
            position: .non,
            shirtNumber: 0,
            contract: contract
        )
        
        let squad = [
            Person(
                id: 3827,
                name: "Rúnar Alex Rúnarsson",
                firstName: "Rúnar Alex",
                lastName: "Rúnarsson",
                dateOfBirth: dateFormatter.date(from: "1995-02-18T00:00:00Z")!,
                nationality: "Iceland",
                position: .goalkeeper,
                shirtNumber: 1,
                contract: Contract(
                    start: dateFormatter.date(from: "2024-01-01T00:00:00Z")!,
                    until: dateFormatter.date(from: "2026-06-30T00:00:00Z")!
                )
            ),
            Person(
                id: 67883,
                name: "Dominik Kotarski",
                firstName: "Dominik",
                lastName: "Kotarski",
                dateOfBirth: dateFormatter.date(from: "2000-02-10T00:00:00Z")!,
                nationality: "Croatia",
                position: .goalkeeper,
                shirtNumber: 13,
                contract: Contract(
                    start: dateFormatter.date(from: "2023-07-01T00:00:00Z")!,
                    until: dateFormatter.date(from: "2027-06-30T00:00:00Z")!
                )
            ),
            Person(
                id: 58827,
                name: "Marcos López",
                firstName: "Marcos",
                lastName: "López",
                dateOfBirth: dateFormatter.date(from: "1999-11-20T00:00:00Z")!,
                nationality: "Peru",
                position: .defence,
                shirtNumber: 3,
                contract: Contract(
                    start: dateFormatter.date(from: "2023-08-01T00:00:00Z")!,
                    until: dateFormatter.date(from: "2026-06-30T00:00:00Z")!
                )
            ),
            Person(
                id: 3460,
                name: "Thomas Delaney",
                firstName: "Thomas",
                lastName: "Delaney",
                dateOfBirth: dateFormatter.date(from: "1991-09-03T00:00:00Z")!,
                nationality: "Denmark",
                position: .midfield,
                shirtNumber: 8,
                contract: Contract(
                    start: dateFormatter.date(from: "2022-07-01T00:00:00Z")!,
                    until: dateFormatter.date(from: "2026-06-30T00:00:00Z")!
                )
            ),
            Person(
                id: 1855,
                name: "Andreas Cornelius",
                firstName: "Andreas",
                lastName: "Cornelius",
                dateOfBirth: dateFormatter.date(from: "1993-03-16T00:00:00Z")!,
                nationality: "Denmark",
                position: .centreForward,
                shirtNumber: 9,
                contract: Contract(
                    start: dateFormatter.date(from: "2024-01-01T00:00:00Z")!,
                    until: dateFormatter.date(from: "2026-06-30T00:00:00Z")!
                )
            ),
            Person(
                id: 150817,
                name: "Youssoufa Moukoko",
                firstName: "Youssoufa",
                lastName: "Moukoko",
                dateOfBirth: dateFormatter.date(from: "2004-11-20T00:00:00Z")!,
                nationality: "Germany",
                position: .centreForward,
                shirtNumber: 10,
                contract: Contract(
                    start: dateFormatter.date(from: "2024-07-01T00:00:00Z")!,
                    until: dateFormatter.date(from: "2028-06-30T00:00:00Z")!
                )
            )
        ]
        
        let area = Area(
            code: "DNK",
            flag: URL(string: "https://crests.football-data.org/782.svg"),
            id: 2065,
            name: "Denmark"
        )
        let groupedPlayers = Dictionary(grouping: squad) { $0.position }
        let squadByPosition = groupedPlayers.map { (position, squad) in
            SquadByPosition(position: position, squad: squad)
        }
        return TeamInfo(
            id: 1876,
            address: "Per Henrik Lings Allé 2 København 2100",
            clubColors: "White / Blue",
            crest: URL(string: "https://crests.football-data.org/1876.png"),
            founded: 1992,
            name: "FC København",
            shortName: "København",
            tla: "KOB",
            website: URL(string: "http://www.fck.dk"),
            venue: "Telia Parken",
            area: area,
            coach: coach,
            squad: squadByPosition
        )
    }
    
    static let articles: [Article] = [
        Article(
            author: "BBC News",
            title: "Watch: The Women's Football Show",
            description: "Analysis and top stories from week 12 of the 2025/26 Women’s Super League season",
            url: URL(string: "https://www.bbc.co.uk/iplayer/episode/m002pwjt/the-womens-football-show-202526-11012026"),
            urlToImage: URL(string: "https://ichef.bbci.co.uk/images/ic/1200x675/p0mqjwdb.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-11T21:06:59Z")!,
            content: "Analysis and top stories from week 12 of the 2025/26 Womens Super League season, with highlights of key fixtures featuring Arsenal v Manchester United and Manchester City v Everton."
        ),
        
        Article(
            author: "Nizaar Kinsella",
            title: "Why Chelsea have turned to 'innovator' Rosenior",
            description: "After Chelsea give Liam Rosenior his first Premier League managerial job, BBC Sport looks at why they have appointed him.",
            url: URL(string: "https://www.bbc.com/sport/football/articles/c5y5gn3130lo"),
            urlToImage: URL(string: "https://ichef.bbci.co.uk/ace/branded_sport/1200/cpsprodpb/560e/live/4024ca60-eaf7-11f0-8e8e-7f477e15473f.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-06T12:11:19Z")!,
            content: "There is pressure on Chelsea to get this appointment right, with some supporters chanting the name of former owner Roman Abramovich during Sunday's draw at Manchester City."
        ),
        
        Article(
            author: "Alexis Billebault",
            title: "Amad Diallo, talent brut devenu l’atout des Ivoiriens pour la CAN 2025",
            description: "Auteur de trois buts dans la compétition, l’ailier de Manchester United s’est affirmé comme l’une des armes offensives majeures des Eléphants",
            url: URL(string: "https://www.lemonde.fr/afrique/article/2026/01/10/egypte-cote-d-ivoire-amad-diallo-talent-brut-devenu-l-atout-des-ivoiriens-pour-la-can-2025_6661307_3212.html"),
            urlToImage: URL(string: "https://img.lemde.fr/2026/01/09/0/0/3589/2392/1440/960/60/0/5563545_upload-1-ern4umkenv6v-000-89uc748.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-10T15:00:11Z")!,
            content: "L'attaquant ivoirien Amad Diallo a marqué trois buts dans la compétition et s'est affirmé comme l'une des armes offensives majeures des Eléphants."
        ),
        
        Article(
            author: "Lewis Jones",
            title: "PL Predictions: Destruction derby? City set to smash United",
            description: "Our football betting expert Jones Knows provides his insight across the Premier League weekend",
            url: URL(string: "https://www.skysports.com/football/news/11095/13494770/premier-league-predictions-and-best-bets-destruction-derby-manchester-city-set-to-smash-manchester-united"),
            urlToImage: URL(string: "https://e0.365dm.com/25/12/1600x900/skysports-premier-league-pl-predictions_7115035.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-15T21:00:00Z")!,
            content: "Our football betting expert Jones Knows provides his insight across the Premier League weekend and tips Manchester City to win a thrilling Manchester derby."
        ),
        
        Article(
            author: "BBC News",
            title: "Football Daily",
            description: "What's it like to play under Rosenior? Could Xavi fit at United? And European discussion.",
            url: URL(string: "https://www.bbc.co.uk/sounds/play/p0msggzy"),
            urlToImage: URL(string: "https://ichef.bbci.co.uk/images/ic/1024x576/p0msgh0v.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-06T23:08:00Z")!,
            content: "As Liam Rosenior agrees to become Chelsea's next manager, Euro Leagues looks at the impact on his old club, Strasbourg, and how he'll fit in at Stamford Bridge."
        ),
        
        Article(
            author: "Kevin Lynch",
            title: "Premier League Soccer 2026: Stream Leeds vs. Arsenal Live From Anywhere",
            description: "Can the Peacocks help derail the Gunners' EPL title push?",
            url: URL(string: "https://www.cnet.com/tech/services-and-software/premier-league-soccer-2026-stream-leeds-vs-arsenal/"),
            urlToImage: URL(string: "https://www.cnet.com/a/img/resize/a8110c1f1d2220058aa050e2b89dd7352a719d6b/hub/2026/01/30/8657bf94-89e1-49f7-a0d0-8e44a5421eb2/gettyimages-2258368480.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-31T12:01:09Z")!,
            content: "Leeds vs. Arsenal will air in the US on NBCSN and Peacock Premium. Arsenal travel to Leeds United in a crucial Premier League fixture."
        ),
        
        Article(
            author: "Kevin Hand",
            title: "Real Madrid remain football’s top earners but Liverpool overtake Man Utd",
            description: "Real Madrid remain the top earner in world football but Liverpool leap in ranking, while Manchester United slide.",
            url: URL(string: "https://www.aljazeera.com/sports/2026/1/22/liverpool-overtake-man-utd-but-real-madrid-remain-footballs-top-earners"),
            urlToImage: URL(string: "https://www.aljazeera.com/wp-content/uploads/2026/01/2026-01-12T214257Z_1695949828_UP1EM1C1OBKT1_RTRMADP_3_SOCCER-ENGLAND-LIV-BAR-1769095553.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-22T16:39:59Z")!,
            content: "Liverpool have overtaken Manchester United for the first time as the Premier League's biggest-financial earners, but Real Madrid remained top performers in world football."
        ),
        
        Article(
            author: "Jean-Pierre Stroobants",
            title: "Jordi Cruyff dans les pas de son père Johan à l’Ajax Amsterdam",
            description: "Le fils de l’emblématique attaquant néerlandais, mort en 2016, prend ses fonctions comme directeur sportif du club amstellodamois",
            url: URL(string: "https://www.lemonde.fr/sport/article/2026/02/01/jordi-cruyff-dans-les-pas-de-son-pere-johan-a-l-ajax-amsterdam_6664964_3242.html"),
            urlToImage: URL(string: "https://img.lemde.fr/2026/01/20/0/0/5487/3658/1440/960/60/0/ec632ca_upload-1-xbpfzjtpnlgo-000-36zr4hc.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-02-01T07:30:05Z")!,
            content: "Jordi Cruyff prend ses fonctions comme directeur sportif de l'Ajax Amsterdam, suivant les pas de son père Johan Cruyff."
        ),
        
        Article(
            author: "Kevin Hand",
            title: "Manchester United vs Manchester City: Premier League – teams, start",
            description: "Michael Carrick's first United game sees Pep Guardiola's Premier League hopefuls visit in the Manchester derby.",
            url: URL(string: "https://www.aljazeera.com/sports/2026/1/16/manchester-united-vs-manchester-city-premier-league-teams-start"),
            urlToImage: URL(string: "https://www.aljazeera.com/wp-content/uploads/2026/01/GettyImages-2255782645-1768571069.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-16T14:09:44Z")!,
            content: "Michael Carrick's first Manchester United game sees Pep Guardiola's Premier League hopefuls visit in the Manchester derby at Old Trafford."
        ),
        
        Article(
            author: "BBC News",
            title: "Football Daily",
            description: "Oasis star Noel Gallagher joins Darren Fletcher to chat Man City and their new signings.",
            url: URL(string: "https://www.bbc.co.uk/sounds/play/p0mvh0y9"),
            urlToImage: URL(string: "https://ichef.bbci.co.uk/images/ic/1024x576/p0mvh0yt.jpg"),
            publishedAt: ISO8601DateFormatter().date(from: "2026-01-16T19:48:00Z")!,
            content: "Darren Fletcher, Don Hutchison, Kevin Nolan and Glenn Murray are joined by Oasis star Noel Gallagher to discuss Manchester City and his favourite derby memories."
        )
    ]
    
    static func personInfo() -> PersonInfo {
        let dateFormatter = ISO8601DateFormatter()
        return PersonInfo(
            id: 1795,
            name: "Alisson Becker",
            firstName: "Alisson",
            lastName: "Becker",
            dateOfBirth: dateFormatter.date(from: "1991-09-03T00:00:00Z")!,
            nationality: "Brazil",
            position: PlayerPosition.valueOf("Goalkeeper"),
            shirtNumber: 1,
            currentTeam: Team(
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
            )
        )
    }
}
