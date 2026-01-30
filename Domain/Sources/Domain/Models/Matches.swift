//
//  Matches.swift
//  Domain
//
//  Created by Александр Мельников on 26.01.2026.
//

import Foundation

public struct MatchesByTour: Sendable, Hashable {
    public let matchday: Int
    public let stage: String
    public let seasonType: String
    public let matches: [Match]
    
    public init(matchday: Int, stage: String, seasonType: String, matches: [Match]) {
        self.matchday = matchday
        self.stage = stage
        self.seasonType = seasonType
        self.matches = matches
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(matchday)
        hasher.combine(stage)
        hasher.combine(seasonType)
    }
    
    public static func == (lhs: MatchesByTour, rhs: MatchesByTour) -> Bool {
        return lhs.matchday == rhs.matchday &&
               lhs.stage == rhs.stage &&
               lhs.seasonType == rhs.seasonType
    }
}

public struct Match: Identifiable, Sendable {
    public let id: Int
    public let status: String
    public let homeTeam: Team
    public let awayTeam: Team
    public let score: Score
    public let dateTime: Date
    
    public init(id: Int, status: String, homeTeam: Team, awayTeam: Team, score: Score, dateTime: Date) {
        self.id = id
        self.status = status
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.score = score
        self.dateTime = dateTime
    }
}

public struct Score: Sendable {
    public let winner: Winner
    public let time: Time
    
    public init(winner: Winner, time: Time) {
        self.winner = winner
        self.time = time
    }
}

public struct Time: Sendable {
    public let home: Int
    public let away: Int
    
    public init(home: Int, away: Int) {
        self.home = home
        self.away = away
    }
}

public enum Winner: Sendable {
    case away, draw, home, none
}
