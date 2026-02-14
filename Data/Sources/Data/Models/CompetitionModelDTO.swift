//
//  CompetitionModelDTO.swift
//  Data
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation

struct CompetitionModelDTO: Codable {
    let count: Int?
    let competitions: [CompetitionDTO]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case competitions = "competitions"
    }
}

public struct CompetitionDTO: Codable, Sendable {
    let id: Int?
    let area: AreaDTO?
    let name: String?
    let code: String?
    let type: String?
    let emblem: String?
    let currentSeason: CurrentSeasonDTO?
    let numberOfAvailableSeasons: Int?
    let lastUpdated: Date?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case area = "area"
        case name = "name"
        case code = "code"
        case type = "type"
        case emblem = "emblem"
        case currentSeason = "currentSeason"
        case numberOfAvailableSeasons = "numberOfAvailableSeasons"
        case lastUpdated = "lastUpdated"
    }
}

struct AreaDTO: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let flag: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case code = "code"
        case flag = "flag"
    }
}

struct CurrentSeasonDTO: Codable {
    let id: Int?
    let startDate: String?
    let endDate: String?
    let currentMatchday: Int?
    let winner: TeamDTO?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case startDate = "startDate"
        case endDate = "endDate"
        case currentMatchday = "currentMatchday"
        case winner = "winner"
    }
}
