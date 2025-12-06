//
//  Container.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import Foundation
import Swinject

final class DIContainer {
    static let shared = DIContainer()
    let container: Container

    private init() {
        container = Container()
        DependencyMap.registerDependencies(in: container)
        validateDependencies()
    }

    private func validateDependencies() {
        let dependencies: [() -> Any?] = [
            { self.container.resolve(NavigationManager.self) }
        ]

        for resolve in dependencies {
            guard resolve() != nil else {
                fatalError("One or more dependencies are not registered in the container.")
            }
        }
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

struct DependencyMap {
    static func registerDependencies(in container: Container) {
        container.register(NavigationManager.self) { _ in
            NavigationManagerImpl()
        }
    }
}
