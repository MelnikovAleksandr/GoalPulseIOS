//
//  StandingsRepository.swift
//  Domain
//
//  Created by Александр Мельников on 27.12.2025.
//

import Foundation
import Utils

public protocol StandingsRepository: Sendable {
    func getStandingsFromRemoteToLocal(compCode: String) async -> Resource<Bool>
    @MainActor
    func getStandingsByIdFromLocal(compCode: String) -> AsyncStream<Standings>
    
    func getScorersFromRemoteToLocal(compCode: String) async -> Resource<Bool>
    @MainActor
    func getScorersByCompCodeFromLocalFlow(compCode: String) -> AsyncStream<Scorers>
}
