//
//  CompetitionModelDTO.swift
//  Data
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation

struct CompetitionModelDTO: Codable {
    let count: Int?
    let filters: FiltersDTO?
    let competitions: [CompetitionDTO]?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case filters = "filters"
        case competitions = "competitions"
    }
}

public struct CompetitionDTO: Codable, Sendable {
    let id: Int?
    let area: AreaDTO?
    let name: String?
    let code: String?
    let type: TypeEnum?
    let emblem: String?
    let plan: PlanDTO?
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
        case plan = "plan"
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
    let winner: WinnerDTO?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case startDate = "startDate"
        case endDate = "endDate"
        case currentMatchday = "currentMatchday"
        case winner = "winner"
    }
}

struct WinnerDTO: Codable {
    let id: Int?
    let name: String?
    let shortName: String?
    let tla: String?
    let crest: String?
    let address: String?
    let website: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let lastUpdated: Date?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case shortName = "shortName"
        case tla = "tla"
        case crest = "crest"
        case address = "address"
        case website = "website"
        case founded = "founded"
        case clubColors = "clubColors"
        case venue = "venue"
        case lastUpdated = "lastUpdated"
    }
}

enum PlanDTO: String, Codable {
    case tierFour = "TIER_FOUR"
    case tierOne = "TIER_ONE"
}

enum TypeEnum: String, Codable {
    case cup = "CUP"
    case league = "LEAGUE"
}

struct FiltersDTO: Codable {
    let client: String?

    enum CodingKeys: String, CodingKey {
        case client = "client"
    }
}
