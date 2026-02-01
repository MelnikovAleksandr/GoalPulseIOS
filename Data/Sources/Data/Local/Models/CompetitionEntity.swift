//
//  CompetitionEntity.swift
//  Data
//
//  Created by Александр Мельников on 14.12.2025.
//

import Foundation
import RealmSwift

public class CompetitionEntity: Object, Identifiable {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted var name: String?
    @Persisted var code: String?
    @Persisted var emblem: String?
    @Persisted var type: String?
    @Persisted var numberOfAvailableSeasons: Int
    @Persisted var lastUpdated: Date?
    @Persisted var area: AreaEntity?
    @Persisted var currentSeason: CurrentSeasonEntity?
}

class AreaEntity: EmbeddedObject {
    @Persisted var id: Int
    @Persisted var name: String?
    @Persisted var code: String?
    @Persisted var flag: String?
}

class TeamEntity: EmbeddedObject {
    @Persisted var id: Int
    @Persisted var name: String?
    @Persisted var shortName: String?
    @Persisted var tla: String?
    @Persisted var crest: String?
    @Persisted var address: String?
    @Persisted var website: String?
    @Persisted var founded: Int
    @Persisted var clubColors: String?
    @Persisted var venue: String?
    @Persisted var contract: ContractEntity?
    @Persisted var lastUpdated: Date?
}

class CurrentSeasonEntity: EmbeddedObject {
    @Persisted var id: Int
    @Persisted var startDate: String?
    @Persisted var endDate: String?
    @Persisted var currentMatchday: Int
    @Persisted var winner: TeamEntity?
}

class ContractEntity: EmbeddedObject {
    @Persisted var start: Date?
    @Persisted var until: Date?
}
