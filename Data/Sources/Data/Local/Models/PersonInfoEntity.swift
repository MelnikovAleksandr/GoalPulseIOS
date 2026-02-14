//
//  PersonInfoEntity.swift
//  Data
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation
import RealmSwift

public class PersonInfoEntity: Object, Identifiable {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted var firstName: String?
    @Persisted var lastName: String?
    @Persisted var name: String?
    @Persisted var dateOfBirth: String?
    @Persisted var nationality: String?
    @Persisted var section: String?
    @Persisted var position: String?
    @Persisted var shirtNumber: Int?
    @Persisted var currentTeam: TeamEntity?
}
