//
//  CustomPatterns+DateFormatter.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import Foundation

extension DateFormatter {
    
    private static var dayMonthAndYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter
    }()
    
    enum CustomPattern {
        case dayMonthAndYear
        
        var formatter: DateFormatter {
            switch self {
            case .dayMonthAndYear:
                return .dayMonthAndYearFormatter
            }
        }
    }
    
    static func format(date: Date, to customPattern: CustomPattern) -> String {
        return customPattern.formatter.string(from: date).uppercased()
    }
    
}

extension Date {
    
    static func from(_ dateString: String, using format: DateFormatter.CustomPattern) -> Date? {
        return format.formatter.date(from: dateString)!
    }
    
}
