//
//  StandingsEntity.swift
//  Data
//
//  Created by Александр Мельников on 25.12.2025.
//

import Foundation
import RealmSwift

public class StandingsEntity: Object, Identifiable {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted var area: AreaEntity?
    @Persisted var currentSeason: CurrentSeasonEntity?
    @Persisted var competition: CompetitionEntity?
    @Persisted var standing: List<StandingEntity>
}

class StandingEntity: EmbeddedObject {
    @Persisted var stage: String?
    @Persisted var type: String?
    @Persisted var group: String?
    @Persisted var table: List<TableEntity>
}

class TableEntity: EmbeddedObject {
    @Persisted var position: Int?
    @Persisted var team: TeamEntity?
    @Persisted var playedGames: Int?
    @Persisted var form: String?
    @Persisted var won: Int?
    @Persisted var draw: Int?
    @Persisted var lost: Int?
    @Persisted var points: Int?
    @Persisted var goalsFor: Int?
    @Persisted var goalsAgainst: Int?
    @Persisted var goalDifference: Int?
}
