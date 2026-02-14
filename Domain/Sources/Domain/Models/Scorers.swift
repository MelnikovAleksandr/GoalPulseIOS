//
//  Scorers.swift
//  Domain
//
//  Created by Александр Мельников on 16.01.2026.
//
import Foundation

public struct Scorers: Identifiable, Sendable {
    public let id: String
    public let competition: Competition
    public let season: CurrentSeason
    public let scorers: [Scorer]
    
    public init(id: String, competition: Competition, season: CurrentSeason, scorers: [Scorer]) {
        self.id = id
        self.competition = competition
        self.season = season
        self.scorers = scorers
    }
}

public struct Scorer: Identifiable, Sendable {
    public let id: Int
    public let player: Player
    public let team: Team
    public let playedMatches: Int
    public let goals: Int
    public let assists: Int
    public let penalties: Int
    
    public init(id: Int, player: Player, team: Team, playedMatches: Int, goals: Int, assists: Int, penalties: Int) {
        self.id = id
        self.player = player
        self.team = team
        self.playedMatches = playedMatches
        self.goals = goals
        self.assists = assists
        self.penalties = penalties
    }
}

public struct Player: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let firstName: String
    public let lastName: String
    public let dateOfBirth: String
    public let nationality: String
    public let section: String
    public let shirtNumber: Int
    
    public init(id: Int, name: String, firstName: String, lastName: String, dateOfBirth: String, nationality: String, section: String, shirtNumber: Int) {
        self.id = id
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.section = section
        self.shirtNumber = shirtNumber
    }
}
