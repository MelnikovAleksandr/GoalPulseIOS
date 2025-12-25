//
//  CompetitionsRepository.swift
//  Domain
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Utils

public protocol CompetitionsRepository: Sendable {
    func getAllCompetitionsFromRemoteToLocal() async -> Resource<Bool>
    @MainActor
    func getAllCompetitionsFromLocal() -> AsyncStream<[Competition]>
}
