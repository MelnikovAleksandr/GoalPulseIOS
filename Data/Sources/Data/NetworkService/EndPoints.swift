//
//  EndPoints.swift
//  Data
//
//  Created by Александр Мельников on 27.12.2025.
//

enum EndPoints {
    case competitions,
         standings(String),
         scorers(String),
         matches(String),
         head2head(String),
         teams(String),
         teamsMatches(String),
         persons(String),
         news
    
    var rawValue: String {
        switch self {
        case .competitions: "competitions/"
        case .standings(let id): "competitions/\(id)/standings/"
        case .scorers(let id): "competitions/\(id)/scorers/"
        case .matches(let id): "competitions/\(id)/matches"
        case .head2head(let id): "matches/\(id)/head2head"
        case .teams(let id): "teams/\(id)"
        case .teamsMatches(let id): "teams/\(id)/matches"
        case .persons(let id): "persons/\(id)"
        case .news: "everything"
        }
    }
}
