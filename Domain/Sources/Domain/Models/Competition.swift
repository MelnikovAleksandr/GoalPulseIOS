//
//  Competition.swift
//  Domain
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation

public struct Competition: Identifiable, Sendable, Equatable {
    public let area: Area
    public let code: String
    public let currentSeason: CurrentSeason
    public let emblem: URL?
    public let id: Int
    public let lastUpdated: String
    public let name: String
    public let numberOfAvailableSeasons: Int
    public let plan: String
    public let type: String
    public let seasons: [Season]
    
    public init(area: Area, code: String, currentSeason: CurrentSeason, emblem: URL?, id: Int, lastUpdated: String, name: String, numberOfAvailableSeasons: Int, plan: String, type: String, seasons: [Season]) {
        self.area = area
        self.code = code
        self.currentSeason = currentSeason
        self.emblem = emblem
        self.id = id
        self.lastUpdated = lastUpdated
        self.name = name
        self.numberOfAvailableSeasons = numberOfAvailableSeasons
        self.plan = plan
        self.type = type
        self.seasons = seasons
    }
}

public struct Area: Sendable, Equatable {
    public let code: String
    public let flag: URL?
    public let id: Int
    public let name: String
    
    public init(code: String, flag: URL?, id: Int, name: String) {
        self.code = code
        self.flag = flag
        self.id = id
        self.name = name
    }
}

public struct CurrentSeason: Sendable, Equatable {
    public let currentMatchDay: Int
    public let startDateEndDate: String
    public let endDate: String
    public let id: Int
    public let startDate: String
    public let winner: Team?
    
    public init(currentMatchDay: Int, startDateEndDate: String, endDate: String, id: Int, startDate: String, winner: Team?) {
        self.currentMatchDay = currentMatchDay
        self.startDateEndDate = startDateEndDate
        self.endDate = endDate
        self.id = id
        self.startDate = startDate
        self.winner = winner
    }
}

public struct Team: Sendable, Equatable {
    public let address: String
    public let clubColors: String
    public let crest: String
    public let founded: Int
    public let id: Int
    public let lastUpdated: String
    public let name: String
    public let shortName: String
    public let tla: String
    public let website: String
    public let venue: String
    
    public init(address: String, clubColors: String, crest: String, founded: Int, id: Int, lastUpdated: String, name: String, shortName: String, tla: String, website: String, venue: String) {
        self.address = address
        self.clubColors = clubColors
        self.crest = crest
        self.founded = founded
        self.id = id
        self.lastUpdated = lastUpdated
        self.name = name
        self.shortName = shortName
        self.tla = tla
        self.website = website
        self.venue = venue
    }
}

public struct Season: Sendable, Equatable {
    public let id: Int
    public let startDate: String
    public let endDate: String
    
    public init(id: Int, startDate: String, endDate: String) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
    }
}
