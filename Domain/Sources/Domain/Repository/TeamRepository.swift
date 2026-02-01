//
//  TeamRepository.swift
//  Domain
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation
import Utils

public protocol TeamRepository: Sendable {
    
    func getTeamFromRemoteToLocal(teamId: Int) async -> Resource<Bool>
    
    @MainActor
    func getTeamInfoFromLocalFlow(teamId: Int) -> AsyncStream<TeamInfo>
    
}
