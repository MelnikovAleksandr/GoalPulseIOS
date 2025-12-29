//
//  EndPoints.swift
//  Data
//
//  Created by Александр Мельников on 27.12.2025.
//

enum EndPoints {
    case competitions, standings(String)
    
    var rawValue: String {
        switch self {
        case .competitions: "competitions/"
        case .standings(let id): "competitions/\(id)/standings/"
        }
    }
}
