//
//  UIDateTimeFormatters.swift
//  Utils
//
//  Created by Александр Мельников on 29.01.2026.
//

import Foundation

public class UIDateTimeFormatters {
    public static let dayMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        return formatter
    }()
    public static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy, HH:mm"
        return formatter
    }()
}


