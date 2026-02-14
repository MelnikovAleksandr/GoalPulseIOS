//
//  Resolver.swift
//  Presentation
//
//  Created by Александр Мельников on 04.01.2026.
//
import Foundation
import Swinject
import Utils
import Domain

extension ResolverApp {
    
    public static func injectViewModels() {
        shared.container.register(CompetitionsViewModel.self) { resolver in
            let repository = resolver.resolve(CompetitionsRepository.self)!
            return CompetitionsViewModel(repository: repository)
        }
        
        shared.container.register(StandingsViewModel.self) { (resolver, compCode: String) in
            let standingsRepository = resolver.resolve(StandingsRepository.self)!
            return StandingsViewModel(
                repository: standingsRepository,
                compCode: compCode
            )
        }
        
        shared.container.register(TeamViewModel.self) { (resolver, teamId: Int) in
            let teamRepository = resolver.resolve(TeamRepository.self)!
            let newsRepository = resolver.resolve(NewsRepository.self)!
            return TeamViewModel(
                repository: teamRepository,
                newsRepository: newsRepository,
                teamId: teamId
            )
        }
        
        shared.container.register(PlayerViewModel.self) { (resolver, playerId: Int) in
            let playerRepository = resolver.resolve(PlayerRepository.self)!
            return PlayerViewModel(repository: playerRepository, playerId: playerId)
        }
    }
}
