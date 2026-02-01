//
//  PersonInfoDTO.swift
//  Data
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation

struct PersonInfoDTO: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let name: String?
    let dateOfBirth: Date?
    let nationality: String?
    let section: String?
    let position: String?
    let shirtNumber: Int?
    let currentTeam: TeamDTO?
    let contract: ContractDTO?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case name = "name"
        case dateOfBirth = "dateOfBirth"
        case nationality = "nationality"
        case section = "section"
        case position = "position"
        case shirtNumber = "shirtNumber"
        case currentTeam = "currentTeam"
        case contract = "contract"
    }
}
