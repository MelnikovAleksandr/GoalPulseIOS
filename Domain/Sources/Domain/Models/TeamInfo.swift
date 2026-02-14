//
//  TeamInfo.swift
//  Domain
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation

public struct TeamInfo: Identifiable, Sendable, Equatable {
    public let id: Int
    public let address: String
    public let clubColors: String
    public let crest: URL?
    public let founded: Int
    public let name: String
    public let shortName: String
    public let tla: String
    public let website: URL?
    public let venue: String
    public let area: Area
    public let coach: Person
    public let squad: [SquadByPosition]
    
    public init(id: Int, address: String, clubColors: String, crest: URL?, founded: Int, name: String, shortName: String, tla: String, website: URL?, venue: String, area: Area, coach: Person, squad: [SquadByPosition]) {
        self.id = id
        self.address = address
        self.clubColors = clubColors
        self.crest = crest
        self.founded = founded
        self.name = name
        self.shortName = shortName
        self.tla = tla
        self.website = website
        self.venue = venue
        self.area = area
        self.coach = coach
        self.squad = squad
    }
}

public struct SquadByPosition: Identifiable, Sendable, Equatable {
    public var id: PlayerPosition { position }
    public let position: PlayerPosition
    public let squad: [Person]
    
    public init(position: PlayerPosition, squad: [Person]) {
        self.position = position
        self.squad = squad
    }
}

public struct Person: Identifiable, Sendable, Equatable {
    public let id: Int
    public let name: String
    public let firstName: String
    public let lastName: String
    public let dateOfBirth: Date
    public let nationality: String
    public let position: PlayerPosition
    public let shirtNumber: Int
    public let contract: Contract
    
    public init(id: Int, name: String, firstName: String, lastName: String, dateOfBirth: Date, nationality: String, position: PlayerPosition, shirtNumber: Int, contract: Contract) {
        self.id = id
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.position = position
        self.shirtNumber = shirtNumber
        self.contract = contract
    }
    
    public var age: Int {
        Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
    }
    
    public var contractUntilYear: String {
        return String(Calendar.current.component(.year, from: contract.until))
    }
}

public struct Contract: Sendable, Equatable {
    public let start: Date
    public let until: Date
    
    public init(start: Date, until: Date) {
        self.start = start
        self.until = until
    }
}
