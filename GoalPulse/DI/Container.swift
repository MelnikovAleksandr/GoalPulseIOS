//
//  Container.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import Foundation
import Swinject
import Utils

final class DIContainer {
    static let shared = DIContainer()
    let container: Container

    private init() {
        container = Container()
        UtilsDependencyMap.registerDependencies(in: container)
        
        validateDependencies()
    }

    private func validateDependencies() {
        UtilsDependencyMap.validate(in: container)
        
        print("All dependencies are successfully registered.")
    }
}

extension DIContainer {
    func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = container.resolve(type) else {
            fatalError("Failed to resolve dependency: \(type)")
        }
        return dependency
    }

    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T {
        guard let dependency = container.resolve(type, argument: argument) else {
            fatalError("Failed to resolve dependency: \(type) with argument: \(argument)")
        }
        return dependency
    }
}
