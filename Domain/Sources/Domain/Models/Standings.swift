//
//  Standings.swift
//  Domain
//
//  Created by Александр Мельников on 26.12.2025.
//

public struct Standings: Identifiable, Sendable {
    public let id: Int
    public let area: Area
    public let competition: Competition
    public let season: CurrentSeason
    public let standings: [Standing]
    
    public init(id: Int, area: Area, competition: Competition, season: CurrentSeason, standings: [Standing]) {
        self.id = id
        self.area = area
        self.competition = competition
        self.season = season
        self.standings = standings
    }
}


public struct Standing: Sendable {
    public let stage: String
    public let type: String
    public let group: String
    public let table: [Table]
    
    public init(stage: String, type: String, group: String, table: [Table]) {
        self.stage = stage
        self.type = type
        self.group = group
        self.table = table
    }
}

public struct Table: Sendable {
    public let position: Int
    public let team: Team?
    public let playedGames: Int
    public let form: String
    public let won: Int
    public let draw: Int
    public let lost: Int
    public let points: Int
    public let goalsFor: Int
    public let goalsAgainst: Int
    public let goalDifference: Int
    
    public init(position: Int, team: Team?, playedGames: Int, form: String, won: Int, draw: Int, lost: Int, points: Int, goalsFor: Int, goalsAgainst: Int, goalDifference: Int) {
        self.position = position
        self.team = team
        self.playedGames = playedGames
        self.form = form
        self.won = won
        self.draw = draw
        self.lost = lost
        self.points = points
        self.goalsFor = goalsFor
        self.goalsAgainst = goalsAgainst
        self.goalDifference = goalDifference
    }
}
