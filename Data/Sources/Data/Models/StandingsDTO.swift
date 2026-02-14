//
//  StandingsDTO.swift
//  Data
//
//  Created by Александр Мельников on 25.12.2025.
//

import Foundation

struct StandingsDTO: Codable {
    let area: AreaDTO?
    let competition: CompetitionDTO?
    let season: CurrentSeasonDTO?
    let standings: [StandingDTO]?
    
    enum CodingKeys: String, CodingKey {
        case area = "area"
        case competition = "competition"
        case season = "season"
        case standings = "standings"
    }
}

struct StandingDTO: Codable {
    let stage: String?
    let type: String?
    let group: String?
    let table: [TableDTO]?
    
    enum CodingKeys: String, CodingKey {
        case stage = "stage"
        case type = "type"
        case group = "group"
        case table = "table"
    }
}

struct TableDTO: Codable {
    let position: Int?
    let team: TeamDTO?
    let playedGames: Int?
    let form: String?
    let won: Int?
    let draw: Int?
    let lost: Int?
    let points: Int?
    let goalsFor: Int?
    let goalsAgainst: Int?
    let goalDifference: Int?
    
    enum CodingKeys: String, CodingKey {
        case position = "position"
        case team = "team"
        case playedGames = "playedGames"
        case form = "form"
        case won = "won"
        case draw = "draw"
        case lost = "lost"
        case points = "points"
        case goalsFor = "goalsFor"
        case goalsAgainst = "goalsAgainst"
        case goalDifference = "goalDifference"
    }
}
