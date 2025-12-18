//
//  File.swift
//  Utils
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation

public enum Resource<T> {
    case success(T)
    case error(ErrorsTypesHttp?, T? = nil)
}
