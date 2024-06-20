//
//  Constants.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-16.
//

import Foundation

/// namespace for all constants
enum Constants {}

extension Constants {
    static func dateFormatter(for dateStyle: Foundation.DateFormatter.Style = .medium) -> Foundation.DateFormatter {
        let formatter = Foundation.DateFormatter()
        formatter.dateStyle = dateStyle
        return formatter
    }
}

extension Constants {
    enum EventApproachingConstraint {
        enum Key {
            static let daysConstraint = "daysConstraint"
            static let mileageConstraint = "mileageConstraint"
        }

        enum Value {
            static let daysConstraint: Int = 28
            static let mileageConstraint: Double = 500
        }
    }
}

extension Constants {
    enum Time {
        static let secondsInDay: TimeInterval = 24 * 60 * 60
    }
}

extension Constants {
    enum Symbol {
        static let notAvailable = "-"
        static let emptyString = ""
    }
}
