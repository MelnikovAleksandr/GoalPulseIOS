//
//  EndPoints.swift
//  Data
//
//  Created by Александр Мельников on 27.12.2025.
//

enum EndPoints {
    case competitions, standings(String), scorers(String), matches(String)
    
    var rawValue: String {
        switch self {
        case .competitions: "competitions/"
        case .standings(let id): "competitions/\(id)/standings/"
        case .scorers(let id): "competitions/\(id)/scorers/"
        case .matches(let id): "competitions/\(id)/matches"
        }
    }
}
