//
//  ScorersEntity.swift
//  Data
//
//  Created by Александр Мельников on 16.01.2026.
//

import Foundation
import RealmSwift

public class ScorersEntity: Object, Identifiable {
    @Persisted(primaryKey: true) public var id: String
    @Persisted var competition: CompetitionEntity?
    @Persisted var season: CurrentSeasonEntity?
    @Persisted var scorers: List<ScorerEntity>
}

class ScorerEntity: EmbeddedObject {
    @Persisted var id: Int?
    @Persisted var player: PlayerEntity?
    @Persisted var team: TeamEntity?
    @Persisted var playedMatches: Int?
    @Persisted var goals: Int?
    @Persisted var assists: Int?
    @Persisted var penalties: Int?
}

class PlayerEntity: EmbeddedObject {
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var dateOfBirth: String?
    @Persisted var nationality: String?
    @Persisted var section: String?
    @Persisted var shirtNumber: Int?
    @Persisted var lastUpdated: Date?
}
