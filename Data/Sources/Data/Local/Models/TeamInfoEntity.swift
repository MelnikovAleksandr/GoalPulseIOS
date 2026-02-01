//
//  TeamInfoEntity.swift
//  Data
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation
import RealmSwift

public class TeamInfoEntity: Object, Identifiable {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted var name: String?
    @Persisted var shortName: String?
    @Persisted var tla: String?
    @Persisted var crest: String?
    @Persisted var address: String?
    @Persisted var website: String?
    @Persisted var founded: Int?
    @Persisted var clubColors: String?
    @Persisted var venue: String?
    @Persisted var area: AreaEntity?
    @Persisted var coach: PersonEntity?
    @Persisted var squad: List<PersonEntity>
    @Persisted var lastUpdated: Date?
}

public class PersonEntity: EmbeddedObject {
    @Persisted var id: Int?
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var name: String?
    @Persisted var dateOfBirth: Date?
    @Persisted var nationality: String?
    @Persisted var position: String?
    @Persisted var shirtNumber: Int?
    @Persisted var contract: ContractEntity?
}
