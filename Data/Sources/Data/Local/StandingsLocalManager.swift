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
    
    func saveScorers(_ scorers: ScorersEntity) async throws
    func getScorercByCompCodeFlow(compCode: String) -> AsyncStream<Scorers>
}

public final class StandingsLocalManagerImpl: StandingsLocalManager {
    
    private var realm: Realm?
    private var standingsToken: NotificationToken?
    private var scorersToken: NotificationToken?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    deinit {
        standingsToken?.invalidate()
        scorersToken?.invalidate()
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
            
            self?.standingsToken = standings.observe { changes in
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
    
    public func saveScorers(_ scorers: ScorersEntity) async throws {
        guard let realm = realm else { throw NSError(domain: "Realm not initialized", code: 0) }
        
        try realm.write {
            realm.delete(realm.objects(ScorersEntity.self))
            
            realm.add(scorers, update: .modified)
        }
    }
    
    public func getScorercByCompCodeFlow(compCode: String) -> AsyncStream<Scorers> {
        return AsyncStream { [weak self] continuation in
            guard let realm = self?.realm else {
                continuation.finish()
                return
            }
            
            let scorers = realm.objects(ScorersEntity.self)
                .filter("id == %d", compCode)
            
            if let initialScorers = scorers.first {
                continuation.yield(initialScorers.toDomain())
            }
            
            self?.scorersToken = scorers.observe { changes in
                switch changes {
                case .initial(let results), .update(let results, _, _, _):
                    if let scorers = results.first {
                        continuation.yield(scorers.toDomain())
                    }
                case .error(let error):
                    print("Realm observation error: \(error)")
                    continuation.finish()
                }
            }
        }
    }
    
}
