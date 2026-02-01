//
//  TeamDTO.swift
//  Data
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation

struct TeamDTO: Codable {
    let id: Int?
    let area: AreaDTO?
    let name: String?
    let shortName: String?
    let tla: String?
    let crest: String?
    let address: String?
    let website: String?
    let founded: Int?
    let clubColors: String?
    let venue: String?
    let coach: PersonDTO?
    let squad: [PersonDTO]?
    let contract: ContractDTO?
    let lastUpdated: Date?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case area = "area"
        case name = "name"
        case shortName = "shortName"
        case tla = "tla"
        case crest = "crest"
        case address = "address"
        case website = "website"
        case founded = "founded"
        case clubColors = "clubColors"
        case venue = "venue"
        case coach = "coach"
        case squad = "squad"
        case contract = "contract"
        case lastUpdated = "lastUpdated"
    }
}

struct PersonDTO: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let name: String?
    let dateOfBirth: String?
    let nationality: String?
    let position: String?
    let contract: ContractDTO?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case name = "name"
        case dateOfBirth = "dateOfBirth"
        case nationality = "nationality"
        case position = "position"
        case contract = "contract"
    }
}

struct ContractDTO: Codable {
    let start: String?
    let until: String?
    
    enum CodingKeys: String, CodingKey {
        case start = "start"
        case until = "until"
    }
}

