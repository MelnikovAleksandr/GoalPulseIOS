//
//  CompetitionsLocalManager.swift
//  Data
//
//  Created by Александр Мельников on 14.12.2025.
//

import Foundation
import RealmSwift
import Domain

@MainActor
public protocol CompetitionsLocalManager: Sendable {
    func saveCompetitions(_ competitions: [CompetitionEntity]) async throws
    func getAllCompetitionsFlow() -> AsyncStream<[Competition]>
}


public final class CompetitionsLocalManagerImpl: CompetitionsLocalManager {
    
    private var realm: Realm?
    private var token: NotificationToken?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    deinit {
        token?.invalidate()
    }
    
    public func saveCompetitions(_ competitions: [CompetitionEntity]) async throws {
        guard let realm = realm else { throw NSError(domain: "Realm not initialized", code: 0) }
        
        try realm.write {
            realm.delete(realm.objects(CompetitionEntity.self))
            
            for comp in competitions {
                realm.add(comp, update: .modified)
            }
        }
    }
    
    public func getAllCompetitionsFlow() -> AsyncStream<[Competition]> {
        return AsyncStream { [weak self] continuation in
            guard let realm = self?.realm else {
                continuation.yield([])
                continuation.finish()
                return
            }
            
            let initialCompetitions = realm.objects(CompetitionEntity.self)
            continuation.yield(initialCompetitions.map { $0.toDomain() })
            
            self?.token = initialCompetitions.observe { changes in
                switch changes {
                case .initial(let results), .update(let results, _, _, _):
                    continuation.yield(results.map { $0.toDomain() })
                case .error(let error):
                    print("Realm observation error: \(error)")
                    continuation.finish()
                }
            }
        }
    }

}
