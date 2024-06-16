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
