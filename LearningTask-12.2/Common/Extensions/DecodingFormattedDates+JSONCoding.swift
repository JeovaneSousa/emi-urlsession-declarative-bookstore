//
//  DecodingFormattedDates+JSONCoding.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 16/12/2022.
//

import Foundation

extension JSONDecoder {
    convenience init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
    
    static func decodingFormattedDates(with pattern: DateFormatter.CustomPattern) -> JSONDecoder {
        return .init(dateDecodingStrategy: .formatted(pattern.formatter))
    }
}

extension JSONEncoder {
    convenience init(dateEncodingStrategy: JSONEncoder.DateEncodingStrategy) {
        self.init()
        self.dateEncodingStrategy = dateEncodingStrategy
    }
    
    static func encodingFormattedDates(with pattern: DateFormatter.CustomPattern) -> JSONEncoder {
        return .init(dateEncodingStrategy: .formatted(pattern.formatter))
    }
}
