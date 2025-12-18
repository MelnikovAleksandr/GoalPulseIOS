//
//  File.swift
//  Data
//
//  Created by Александр Мельников on 14.12.2025.
//

import Foundation
import RealmSwift

class CompetitionEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int64
    @Persisted var name: String?
    @Persisted var code: String?
    @Persisted var emblem: String?
    @Persisted var type: String?
    @Persisted var plan: String?
    @Persisted var numberOfAvailableSeasons: Int64
    @Persisted var lastUpdated: Date?
    
    @Persisted var area: AreaEntity?
    @Persisted var currentSeason: CurrentSeasonEntity?
}

class AreaEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int64
    @Persisted var name: String?
    @Persisted var code: String?
    @Persisted var flag: String?
}

class WinnerEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int64
    @Persisted var name: String?
    @Persisted var shortName: String?
    @Persisted var tla: String?
    @Persisted var crest: String?
    @Persisted var address: String?
    @Persisted var website: String?
    @Persisted var founded: Int64
    @Persisted var clubColors: String?
    @Persisted var venue: String?
    @Persisted var lastUpdated: Date?
}

class CurrentSeasonEntity: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int64
    @Persisted var startDate: String?
    @Persisted var endDate: String?
    @Persisted var currentMatchday: Int64
    
    @Persisted var winner: WinnerEntity?
}

