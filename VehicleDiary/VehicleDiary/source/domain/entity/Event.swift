//
//  Event.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-13.
//

import Foundation
import SwiftData

@Model
class Event {
    var name: String = "Unknown event"
    var comment: String = "Unknown description"
    var date: Date = Date.now
    var nextDate: Date = Date.now
    var millage: Double = 0
    var nextMillage: Double = 0
    var vehicle: Vehicle?

    init(
        name: String,
        comment: String,
        date: Date,
        nextDate: Date,
        millage: Double,
        nextMillage: Double,
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

extension Event {
    var millageMeasurement: Measurement<UnitLength> {
        Measurement(value: millage, unit: UnitLength.kilometers)
    }

    var nextMillageMeasurement: Measurement<UnitLength> {
        Measurement(value: nextMillage, unit: UnitLength.kilometers)
    }
}
