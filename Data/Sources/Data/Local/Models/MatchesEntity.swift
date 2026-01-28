//
//  MatchesEntity.swift
//  Data
//
//  Created by Александр Мельников on 26.01.2026.
//

import Foundation
import RealmSwift

public class MatchesEntity: Object, Identifiable {
    @Persisted(primaryKey: true) public var id: String
    @Persisted var competition: CompetitionEntity?
    @Persisted var matches: List<MatchEntity>
}

class MatchEntity: EmbeddedObject {
    @Persisted var area: AreaEntity?
    @Persisted var competition: CompetitionEntity?
    @Persisted var season: CurrentSeasonEntity?
    @Persisted var id: Int?
    @Persisted var utcDate: Date?
    @Persisted var status: String?
    @Persisted var matchday: Int?
    @Persisted var stage: String?
    @Persisted var lastUpdated: Date?
    @Persisted var homeTeam: TeamEntity?
    @Persisted var awayTeam: TeamEntity?
    @Persisted var score: ScoreEntity?
    @Persisted var referees: List<RefereeEntity>
}

class ScoreEntity: EmbeddedObject {
    @Persisted var winner: String?
    @Persisted var duration: String?
    @Persisted var fullTime: TimeEntity?
    @Persisted var halfTime: TimeEntity?
}

class TimeEntity: EmbeddedObject {
    @Persisted var home: Int?
    @Persisted var away: Int?
}

class RefereeEntity: EmbeddedObject {
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var type: String?
    @Persisted var nationality: String?
}
