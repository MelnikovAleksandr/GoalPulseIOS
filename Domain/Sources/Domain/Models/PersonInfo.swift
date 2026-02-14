//
//  PersonInfo.swift
//  Domain
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation
import Utils

public struct PersonInfo: Identifiable, Sendable, Equatable {
    public let id: Int
    public let name: String
    public let firstName: String
    public let lastName: String
    public let dateOfBirth: Date
    public let nationality: String
    public let position: PlayerPosition
    public let shirtNumber: Int
    public let currentTeam: Team
    
    public init(id: Int, name: String, firstName: String, lastName: String, dateOfBirth: Date, nationality: String, position: PlayerPosition, shirtNumber: Int, currentTeam: Team) {
        self.id = id
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.nationality = nationality
        self.position = position
        self.shirtNumber = shirtNumber
        self.currentTeam = currentTeam
    }
    
    public var age: Int {
        Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
    }
}

public enum PlayerPosition: String, CaseIterable, Codable, Sendable {
    case goalkeeper = "Goalkeeper"
    case defence = "Defence"
    case centerBack = "Centre-Back"
    case leftBack = "Left-Back"
    case rightBack = "Right-Back"
    case defensiveMidfield = "Defensive Midfield"
    case centralMidfield = "Central Midfield"
    case attackingMidfield = "Attacking Midfield"
    case rightMidfield = "Right Midfield"
    case leftMidfield = "Left Midfield"
    case midfield = "Midfield"
    case leftWinger = "Left Winger"
    case rightWinger = "Right Winger"
    case offence = "Offence"
    case centreForward = "Centre-Forward"
    case non = "Non"
    
    public var localizedTitle: String {
        Locale.get(rawValue)
    }
    
    public var imageName: String {
        switch self {
        case .goalkeeper:
            return "keeper"
        case .defence, .centerBack, .leftBack, .rightBack,
                .defensiveMidfield, .centralMidfield, .attackingMidfield,
                .rightMidfield, .leftMidfield, .midfield:
            return "midfield"
        default:
            return "offence"
        }
    }
}

public extension PlayerPosition {
    private static func valueOf(_ string: String?) -> PlayerPosition? {
        return allCases.first { $0.rawValue == string }
    }
    
    static func valueOf(_ string: String?) -> PlayerPosition {
        valueOf(string) ?? .non
    }
}
