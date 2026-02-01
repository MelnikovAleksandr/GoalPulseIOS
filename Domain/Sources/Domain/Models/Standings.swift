//
//  Standings.swift
//  Domain
//
//  Created by Александр Мельников on 26.12.2025.
//

import Foundation

public struct Standings: Identifiable, Sendable {
    public let id: String
    public let area: Area
    public let competition: Competition
    public let season: CurrentSeason
    public let standings: [Standing]
    
    public init(id: String, area: Area, competition: Competition, season: CurrentSeason, standings: [Standing]) {
        self.id = id
        self.area = area
        self.competition = competition
        self.season = season
        self.standings = standings
    }
}


public struct Standing: Sendable, Hashable {
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
    
    public static func == (lhs: Standing, rhs: Standing) -> Bool {
        return lhs.stage == rhs.stage &&
        lhs.type == rhs.type &&
        lhs.group == rhs.group
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(stage)
        hasher.combine(type)
        hasher.combine(group)
    }
}

public struct Table: Sendable, Identifiable, Hashable {
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
    
    public var id: Int {
        return team?.id ?? abs(UUID().hashValue)
    }
    
    public static func == (lhs: Table, rhs: Table) -> Bool {
        return lhs.team?.id == rhs.team?.id &&
        lhs.position == rhs.position
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(team?.id)
        hasher.combine(position)
    }
}
