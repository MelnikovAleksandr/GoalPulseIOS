//
//  StandingsLocalManager.swift
//  Data
//
//  Created by Александр Мельников on 27.12.2025.
//

import Foundation
import RealmSwift
import Domain

@MainActor
public protocol StandingsLocalManager: Sendable {
    func saveStandings(_ standings: StandingsEntity) async throws
    func getStandingsByIdFlow(compCode: String) -> AsyncStream<Standings>
}

public final class StandingsLocalManagerImpl: StandingsLocalManager {
    
    private var realm: Realm?
    private var token: NotificationToken?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    deinit {
        token?.invalidate()
    }
    
    public func saveStandings(_ standings: StandingsEntity) async throws {
        guard let realm = realm else { throw NSError(domain: "Realm not initialized", code: 0) }
        
        try realm.write {
            realm.delete(realm.objects(StandingsEntity.self))
            
            realm.add(standings, update: .modified)
        }
    }
    
    public func getStandingsByIdFlow(compCode: String) -> AsyncStream<Standings> {
        return AsyncStream { [weak self] continuation in
            guard let realm = self?.realm else {
                continuation.finish()
                return
            }
            
            let standings = realm.objects(StandingsEntity.self)
                .filter("id == %d", compCode)
            
            if let initialStanding = standings.first {
                continuation.yield(initialStanding.toDomain())
            }
            
            self?.token = standings.observe { changes in
                switch changes {
                case .initial(let results), .update(let results, _, _, _):
                    if let standing = results.first {
                        continuation.yield(standing.toDomain())
                    }
                case .error(let error):
                    print("Realm observation error: \(error)")
                    continuation.finish()
                }
            }
        }
    }
    
}
