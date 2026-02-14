//
//  PlayerRepository.swift
//  Domain
//
//  Created by Александр Мельников on 14.02.2026.
//

import Foundation
import Utils

public protocol PlayerRepository: Sendable {
    
    func getPlayerInfo(playerId: Int) async -> Resource<PersonInfo>
    
}
