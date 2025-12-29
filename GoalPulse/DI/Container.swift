//
//  Container.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import Foundation
import Swinject
import Utils
import Data
import Domain
import Presentation
import RealmSwift

class Resolver {
    
    static let shared = Resolver()
    
    private var container = Container()
    
    func injectModules() {
        SVGHelper.setUpDependencies()
        FontsHelper.resigterFonts()
        injectUtils()
        injectDataSources()
        injectViewModels()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

extension Resolver {
    private func injectUtils() {
        container.register(NavigationManager.self) { _ in
            NavigationManagerImpl()
        }.inObjectScope(.container)
    }
}

extension Resolver {
    private func injectDataSources() {
        
        container.register(Realm.self) { _ in
            do {
                let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
                return try Realm(configuration: config)
            } catch {
                fatalError("Realm init error: \(error)")
            }
        }.inObjectScope(.container)
        
        container.register(FootballNetworkService.self) { _ in
            FootballNetworkServiceImpl()
        }.inObjectScope(.container)
        
        container.register(ErrorsHandler.self) { _ in
            ErrorsHandlerImpl()
        }.inObjectScope(.container)
        
        container.register(CompetitionsLocalManager.self) { resolver in
            let realm = resolver.resolve(Realm.self)!
            return CompetitionsLocalManagerImpl(realm: realm)
        }.inObjectScope(.container)
        
        container.register(StandingsLocalManager.self) { resolver in
            let realm = resolver.resolve(Realm.self)!
            return StandingsLocalManagerImpl(realm: realm)
        }.inObjectScope(.container)
        
        container.register(CompetitionsRepository.self) { resolver in
            let networkService = resolver.resolve(FootballNetworkService.self)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let competitionsLocalManager = resolver.resolve(CompetitionsLocalManager.self)!
            return CompetitionsRepositoryImpl(
                networkService: networkService,
                errorHandler: errorHandler,
                competitionsLocalManager: competitionsLocalManager
            )
        }.inObjectScope(.container)
        
        container.register(StandingsRepository.self) { resolver in
            let networkService = resolver.resolve(FootballNetworkService.self)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let standingsLocalManager = resolver.resolve(StandingsLocalManager.self)!
            return StandingsRepositoryImpl(
                networkService: networkService, errorHandler: errorHandler, standingsLocalManager: standingsLocalManager
            )
        }.inObjectScope(.container)
    }
}

extension Resolver {
    
    private func injectViewModels() {
        container.register(CompetitionsViewModel.self) { resolver in
            let repository = resolver.resolve(CompetitionsRepository.self)!
            return CompetitionsViewModel(repository: repository)
        }
        
        container.register(StandingsViewModel.self) { resolver in
            let standingsRepository = resolver.resolve(StandingsRepository.self)!
            return StandingsViewModel(repository: standingsRepository)
        }
    }
}

