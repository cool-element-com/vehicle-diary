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
    var millage: Int = 0
    var nextMillage: Int = 0
    var vehicle: Vehicle?

    init(
        name: String,
        comment: String,
        date: Date,
        nextDate: Date,
        millage: Int,
        nextMillage: Int,
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
