//
//  TeamsLocalManager.swift
//  Data
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation
import RealmSwift
import Domain

@MainActor
public protocol TeamsLocalManager: Sendable {
    func saveTeam(_ team: TeamInfoEntity) async throws
    func getTeamFlow(teamId: Int) -> AsyncStream<TeamInfo>
}

public final class TeamsLocalManagerImpl: TeamsLocalManager {
    private var realm: Realm?
    private var teamToken: NotificationToken?
    
    public init(realm: Realm? = nil) {
        self.realm = realm
    }
    
    deinit {
        teamToken?.invalidate()
    }
    
    public func saveTeam(_ team: TeamInfoEntity) async throws {
        guard let realm = realm else { throw NSError(domain: "Realm not initialized", code: 0) }
        
        try realm.write {
            if let existingTeam = realm.object(ofType: TeamInfoEntity.self, forPrimaryKey: team.id) {
                realm.delete(existingTeam)
            }
            realm.add(team, update: .modified)
        }
    }
    
    public func getTeamFlow(teamId: Int) -> AsyncStream<TeamInfo> {
        return AsyncStream { [weak self] continuation in
            guard let realm = self?.realm else {
                continuation.finish()
                return
            }
            
            let team = realm.objects(TeamInfoEntity.self)
                .filter("id == %d", teamId)
         
            if let initialTeam = team.first {
                continuation.yield(initialTeam.toDomain())
            }
            
            self?.teamToken = team.observe { changes in
                switch changes {
                case .initial(let results), .update(let results, _, _, _):
                    if let team = results.first {
                        continuation.yield(team.toDomain())
                    }
                case .error(let error):
                    print("Realm observation error: \(error)")
                    continuation.finish()
                }
            }
        }
    }
}
