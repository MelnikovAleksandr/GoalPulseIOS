//
//  ScorersDTO.swift
//  Data
//
//  Created by Александр Мельников on 16.01.2026.
//

import Foundation

struct ScorersDTO: Codable {
    let count: Int?
    let filters: FiltersDTO?
    let competition: CompetitionDTO?
    let season: CurrentSeasonDTO?
    let scorers: [ScorerDTO]?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case filters = "filters"
        case competition = "competition"
        case season = "season"
        case scorers = "scorers"
    }
}

struct ScorerDTO: Codable {
    let player: PlayerDTO?
    let team: TeamDTO?
    let playedMatches: Int?
    let goals: Int?
    let assists: Int?
    let penalties: Int?

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case team = "team"
        case playedMatches = "playedMatches"
        case goals = "goals"
        case assists = "assists"
        case penalties = "penalties"
    }
}

struct PlayerDTO: Codable {
    let id: Int?
    let name: String?
    let firstName: String?
    let lastName: String?
    let dateOfBirth: String?
    let nationality: String?
    let section: String?
    let shirtNumber: Int?
    let lastUpdated: Date?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case firstName = "firstName"
        case lastName = "lastName"
        case dateOfBirth = "dateOfBirth"
        case nationality = "nationality"
        case section = "section"
        case shirtNumber = "shirtNumber"
        case lastUpdated = "lastUpdated"
    }
}


