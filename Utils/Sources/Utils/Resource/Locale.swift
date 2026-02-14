//
//  Locale.swift
//  Utils
//
//  Created by Александр Мельников on 24.12.2025.
//

import Foundation

public struct Locale {
    
    public static func get(_ key: String) -> String {
        return NSLocalizedString(key, bundle: .module, comment: "")
    }
    
}
