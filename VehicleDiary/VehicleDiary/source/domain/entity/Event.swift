//
//  Event.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-13.
//

import Foundation
import SwiftData

@Model
class VEvent {
    var name: String = "Unknown event"
    var comment: String?
    var date: Date = Date.now
    var nextDate: Date?
    var millage: Double?
    var nextMillage: Double?
    var vehicle: Vehicle?

    init(
        name: String,
        comment: String? = nil,
        date: Date,
        nextDate: Date? = nil,
        millage: Double? = nil,
        nextMillage: Double? = nil,
        vehicle: Vehicle? = nil
    ) {
        self.name = name
        self.comment = comment
        self.date = date
        self.nextDate = nextDate
        self.millage = millage
        self.nextMillage = nextMillage
        self.vehicle = vehicle
    }
}

// MARK: - Property utils
extension VEvent {
    var unwrappedComment: String {
        comment ?? ""
    }

    var unwrappedMilage: Double {
        millage ?? 0
    }

    var unwrappedNextMillage: Double {
        nextMillage ?? 0
    }

    var unwrappedNextDate: Date {
        nextDate ?? Date.now
    }

    var millageMeasurement: Measurement<UnitLength> {
        Measurement(value: unwrappedMilage, unit: UnitLength.kilometers)
    }

    var nextMillageMeasurement: Measurement<UnitLength> {
        Measurement(value: unwrappedNextMillage, unit: UnitLength.kilometers)
    }

    func dateString(using formatter: DateFormatter = Constants.dateFormatter()) -> String {
        formatter.string(from: date)
    }

    func nextDateString(using formatter: DateFormatter = Constants.dateFormatter()) -> String {
        formatter.string(from: unwrappedNextDate)
    }
}
