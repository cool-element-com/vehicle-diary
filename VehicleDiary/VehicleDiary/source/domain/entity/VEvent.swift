//
//  VEvent.swift
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
    var recordedDate: Date = Date.now
    var nextDate: Date?
    var recordedMillage: Double?
    var nextMillage: Double?
    var vehicle: Vehicle?

    init(
        name: String,
        comment: String? = nil,
        recordedDate: Date,
        nextDate: Date? = nil,
        recordedMillage: Double? = nil,
        nextMillage: Double? = nil,
        vehicle: Vehicle? = nil
    ) {
        self.name = name
        self.comment = comment
        self.recordedDate = recordedDate
        self.nextDate = nextDate
        self.recordedMillage = recordedMillage
        self.nextMillage = nextMillage
        self.vehicle = vehicle
    }
}

// MARK: - Property utils
extension VEvent {
    var unwrappedComment: String {
        comment ?? ""
    }

    var unwrappedRecordedMillage: Double {
        recordedMillage ?? 0
    }

    var unwrappedNextMillage: Double {
        nextMillage ?? 0
    }

    var unwrappedNextDate: Date {
        nextDate ?? Date.now
    }

    var recordedMillageMeasurement: Measurement<UnitLength> {
        Measurement(value: unwrappedRecordedMillage, unit: UnitLength.kilometers)
    }

    var nextMillageMeasurement: Measurement<UnitLength> {
        Measurement(value: unwrappedNextMillage, unit: UnitLength.kilometers)
    }

    func recordedDateString(using formatter: DateFormatter = Constants.dateFormatter()) -> String {
        formatter.string(from: recordedDate)
    }

    func nextDateString(using formatter: DateFormatter = Constants.dateFormatter()) -> String {
        formatter.string(from: unwrappedNextDate)
    }
}
