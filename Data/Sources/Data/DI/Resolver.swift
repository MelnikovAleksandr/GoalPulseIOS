//
//  Resolver.swift
//  Data
//
//  Created by Александр Мельников on 04.01.2026.
//
import Foundation
import Swinject
import Utils
import RealmSwift
import Domain

extension ResolverApp {
    public static func injectDataSources() {
        
        shared.container.register(Realm.self) { _ in
            do {
                let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
                return try Realm(configuration: config)
            } catch {
                fatalError("Realm init error: \(error)")
            }
        }.inObjectScope(.container)
        
        shared.container.register(NetworkService.self, name: NetworkType.football.rawValue) { _ in
            NetworkServiceImpl(type: NetworkType.football)
        }.inObjectScope(.container)
        
        shared.container.register(NetworkService.self, name: NetworkType.news.rawValue) { _ in
            NetworkServiceImpl(type: NetworkType.news)
        }.inObjectScope(.container)
        
        shared.container.register(ErrorsHandler.self) { _ in
            ErrorsHandlerImpl()
        }.inObjectScope(.container)
        
        shared.container.register(CompetitionsLocalManager.self) { resolver in
            let realm = resolver.resolve(Realm.self)!
            return CompetitionsLocalManagerImpl(realm: realm)
        }.inObjectScope(.container)
        
        shared.container.register(StandingsLocalManager.self) { resolver in
            let realm = resolver.resolve(Realm.self)!
            return StandingsLocalManagerImpl(realm: realm)
        }.inObjectScope(.container)
        
        shared.container.register(TeamsLocalManager.self) { resolver in
            let realm = resolver.resolve(Realm.self)!
            return TeamsLocalManagerImpl(realm: realm)
        }.inObjectScope(.container)
        
        shared.container.register(CompetitionsRepository.self) { resolver in
            let networkService = resolver.resolve(NetworkService.self, name: NetworkType.football.rawValue)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let competitionsLocalManager = resolver.resolve(CompetitionsLocalManager.self)!
            return CompetitionsRepositoryImpl(
                networkService: networkService,
                errorHandler: errorHandler,
                competitionsLocalManager: competitionsLocalManager
            )
        }.inObjectScope(.container)
        
        shared.container.register(StandingsRepository.self) { resolver in
            let networkService = resolver.resolve(NetworkService.self, name: NetworkType.football.rawValue)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let standingsLocalManager = resolver.resolve(StandingsLocalManager.self)!
            return StandingsRepositoryImpl(
                networkService: networkService, errorHandler: errorHandler, standingsLocalManager: standingsLocalManager
            )
        }.inObjectScope(.container)
        
        shared.container.register(TeamRepository.self) { resolver in
            let networkService = resolver.resolve(NetworkService.self, name: NetworkType.football.rawValue)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let teamsLocalManager = resolver.resolve(TeamsLocalManager.self)!
            let standingsLocalManager = resolver.resolve(StandingsLocalManager.self)!
            return TeamRepositoryImpl(
                networkService: networkService, errorHandler: errorHandler, teamsLocalManager: teamsLocalManager, standingsLocalManager: standingsLocalManager
            )
        }.inObjectScope(.container)
        
        shared.container.register(NewsRepository.self) { resolver in
            let networkService = resolver.resolve(NetworkService.self, name: NetworkType.news.rawValue)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let teamsLocalManager = resolver.resolve(TeamsLocalManager.self)!
            return NewsRepositoryImpl(
                networkService: networkService, errorHandler: errorHandler, teamsLocalManager: teamsLocalManager
            )
        }.inObjectScope(.container)
        
        shared.container.register(PlayerRepository.self) { resolver in
            let networkService = resolver.resolve(NetworkService.self, name: NetworkType.football.rawValue)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            return PlayerRepositoryImpl(networkService: networkService, errorHandler: errorHandler)
        }.inObjectScope(.container)
    }
}
