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
    var id: String = UUID().uuidString
    var vehicle: Vehicle?

    init(
        name: String,
        comment: String? = nil,
        recordedDate: Date,
        nextDate: Date? = nil,
        recordedMillage: Double? = nil,
        nextMillage: Double? = nil,
        id: String = UUID().uuidString,
        vehicle: Vehicle? = nil
    ) {
        self.name = name
        self.comment = comment
        self.recordedDate = recordedDate
        self.nextDate = nextDate
        self.recordedMillage = recordedMillage
        self.nextMillage = nextMillage
        self.id = id
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
}

// MARK: - Utils
extension VEvent {
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

// MARK: - Next event calculations
extension VEvent {

    func nextEventInDays() -> Int? {
        guard let nextDate = nextDate else {
            return nil
        }
        let days = days(to: nextDate)
        return days
    }

    private func days(from startDate: Date = Date.now, to futureDate: Date) -> Int {
        let seconds = startDate.distance(to: futureDate)
        let days = ceil(seconds / (Constants.Time.secondsInDay))
        return Int(days)
    }

    func nextEventInMillage() -> Measurement<UnitLength>? {
        guard let vehicleMillage = vehicle?.millage else {
            return nil
        }
        guard let nextMillage = nextMillage else {
            return nil
        }
        let diff = nextMillage - vehicleMillage
        let measurement = Measurement(value: diff, unit: UnitLength.kilometers)
        return measurement
    }
}
