//
//  Date+extensions.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
