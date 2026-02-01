//
//  MatchesDTO.swift
//  Data
//
//  Created by Александр Мельников on 26.01.2026.
//

import Foundation

struct MatchesDTO: Codable {
    let competition: CompetitionDTO?
    let matches: [MatchDTO]?
    
    enum CodingKeys: String, CodingKey {
        case competition = "competition"
        case matches = "matches"
    }
}

struct MatchDTO: Codable {
    let area: AreaDTO?
    let competition: CompetitionDTO?
    let season: CurrentSeasonDTO?
    let id: Int?
    let utcDate: Date?
    let status: String?
    let matchday: Int?
    let stage: String?
    let lastUpdated: Date?
    let homeTeam: TeamDTO?
    let awayTeam: TeamDTO?
    let score: ScoreDTO?
    let referees: [RefereeDTO]?
    
    enum CodingKeys: String, CodingKey {
        case area = "area"
        case competition = "competition"
        case season = "season"
        case id = "id"
        case utcDate = "utcDate"
        case status = "status"
        case matchday = "matchday"
        case stage = "stage"
        case lastUpdated = "lastUpdated"
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
        case score = "score"
        case referees = "referees"
    }
}

struct RefereeDTO: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let nationality: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case nationality = "nationality"
    }
}

struct ScoreDTO: Codable {
    let winner: String? // AWAY_TEAM DRAW HOME_TEAM
    let duration: String?
    let fullTime: TimeDTO?
    let halfTime: TimeDTO?
    
    enum CodingKeys: String, CodingKey {
        case winner = "winner"
        case duration = "duration"
        case fullTime = "fullTime"
        case halfTime = "halfTime"
    }
}

struct TimeDTO: Codable {
    let home: Int?
    let away: Int?
    
    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }
}
