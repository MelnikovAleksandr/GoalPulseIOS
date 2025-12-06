//
//  File.swift
//  Utils
//
//  Created by Александр Мельников on 06.12.2025.
//

import Foundation
import Swinject

public struct UtilsDependencyMap {
    public static func registerDependencies(in container: Container) {
        container.register(NavigationManager.self) { _ in
            NavigationManagerImpl()
        }
    }
    
    public static func validate(in container: Container) {
            let dependencies: [() -> Any?] = [
                { container.resolve(NavigationManager.self) }
            ]
            
            for resolve in dependencies {
                if resolve() == nil {
                    fatalError("Utils dependency not registered")
                }
            }
        }
}
