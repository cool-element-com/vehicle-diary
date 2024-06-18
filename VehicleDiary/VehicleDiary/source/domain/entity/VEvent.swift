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
    var upcomingDate: Date?
    var recordedMileage: Double?
    var upcomingMileage: Double?
    var isCompleted: Bool = false
    var id: String = UUID().uuidString
    var vehicle: Vehicle?

    init(
        name: String,
        comment: String? = nil,
        recordedDate: Date,
        upcomingDate: Date? = nil,
        recordedMileage: Double? = nil,
        upcomingMileage: Double? = nil,
        isCompleted: Bool = false,
        id: String = UUID().uuidString,
        vehicle: Vehicle? = nil
    ) {
        self.name = name
        self.comment = comment
        self.recordedDate = recordedDate
        self.upcomingDate = upcomingDate
        self.recordedMileage = recordedMileage
        self.upcomingMileage = upcomingMileage
        self.isCompleted = isCompleted
        self.id = id
        self.vehicle = vehicle
    }
}

// MARK: - Property utils
extension VEvent {
    var unwrappedComment: String {
        comment ?? ""
    }

    var unwrappedRecordedMileage: Double {
        recordedMileage ?? 0
    }

    var unwrappedNextMileage: Double {
        upcomingMileage ?? 0
    }

    var unwrappedNextDate: Date {
        upcomingDate ?? Date.now
    }
}

// MARK: - Measurements
extension VEvent {
    var recordedMileageMeasurement: Measurement<UnitLength>? {
        guard let recordedMileage = recordedMileage else {
            return nil
        }
        let result = Measurement(value: recordedMileage, unit: UnitLength.kilometers)
        return result
    }

    var upcomingMileageMeasurement: Measurement<UnitLength>? {
        guard let upcomingMileage = upcomingMileage else {
            return nil
        }
        let result = Measurement(value: upcomingMileage, unit: UnitLength.kilometers)
        return result
    }
}

// MARK: - User facing strings
extension VEvent {
    func recordedDateString(using formatter: DateFormatter = Constants.dateFormatter()) -> String {
        formatter.string(from: recordedDate)
    }

    func upcomingDateString(using formatter: DateFormatter = Constants.dateFormatter()) -> String {
        guard let upcomingDate = upcomingDate else {
            return Constants.Symbol.notAvailable
        }
        let result = formatter.string(from: upcomingDate)
        return result
    }

    func recordedMileageMeasurementString(using locale: Locale = Locale.current) -> String {
        let result = measurementString(from: recordedMileageMeasurement, using: locale)
        return result
    }

    func upcomingMileageMeasurementString(using locale: Locale = Locale.current) -> String {
        let result = measurementString(from: upcomingMileageMeasurement, using: locale)
        return result
    }

    private func measurementString(
        from measurement: Measurement<UnitLength>?,
        using locale: Locale = Locale.current
    ) -> String {
        guard let measurement = measurement else {
            return Constants.Symbol.notAvailable
        }
        let result = measurement
            .formatted(
                .measurement(
                    width: .abbreviated,
                    usage: .road)
            .locale(locale))
        return result
    }

    func upcomingEventInDaysString() -> String {
        guard let upcomingEventInDays = upcomingEventInDays() else {
            return Constants.Symbol.notAvailable
        }
        let result = "\(upcomingEventInDays) day\(upcomingEventInDays != 1 ? "s" : "")"
        return result
    }

    func upcomingEventInMileageString(using locale: Locale = Locale.current) -> String {
        guard let measurement = upcomingEventInMileageMeasurement() else {
            return Constants.Symbol.notAvailable
        }
        let result = measurement
            .formatted(
                .measurement(
                    width: .abbreviated,
                    usage: .road)
            .locale(locale))
        return result
    }
}

// MARK: - Next event approaching calculations
extension VEvent {

    enum Approach {
        case inDays(Int)
        case afterMileage(Double)
        case notYet

        enum Measurement {
            case time
            case millage
        }
    }

    var approach: VEvent.Approach {
        let upcomingEventInDays = upcomingEventInDays()
        let upcomingEventInMileageValue = upcomingEventInMileageMeasurement()?.value

        switch (upcomingEventInDays, upcomingEventInMileageValue) {
        case (.none, .none):
            return .notYet
        case (.some(let days), .some(let distance)):
            if days < Constants.EventApproachingAfter.days {
                return .inDays(days)
            } else if distance < Constants.EventApproachingAfter.mileage {
                return .afterMileage(distance)
            } else {
                return .notYet
            }
        case (.some(let days), .none):
            if days < Constants.EventApproachingAfter.days {
                return .inDays(days)
            } else {
                return .notYet
            }
        case (.none, .some(let distance)):
            if distance < Constants.EventApproachingAfter.mileage {
                return .afterMileage(distance)
            } else {
                return .notYet
            }
        }
    }

    func upcomingEventInDays() -> Int? {
        guard let upcomingDate = upcomingDate else {
            return nil
        }
        let days = days(to: upcomingDate)
        return days
    }

    private func days(from startDate: Date = Date.now, to futureDate: Date) -> Int {
        let seconds = startDate.distance(to: futureDate)
        let days = ceil(seconds / (Constants.Time.secondsInDay))
        return Int(days)
    }

    func upcomingEventInMileageMeasurement() -> Measurement<UnitLength>? {
        guard let vehicleMileage = vehicle?.mileage else {
            return nil
        }
        guard let upcomingMileage = upcomingMileage else {
            return nil
        }
        let diff = upcomingMileage - vehicleMileage
        let measurement = Measurement(value: diff, unit: UnitLength.kilometers)
        return measurement
    }
}
