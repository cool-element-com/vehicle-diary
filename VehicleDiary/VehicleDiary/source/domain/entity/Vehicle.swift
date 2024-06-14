//
//  Vehicle.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-13.
//

import Foundation
import SwiftData

@Model
class Vehicle {
    var brand: String = "Unknown brand"
    var model: String = "Unknown model"
    var comment: String?
    var millage: Double = 0
    var id: String = UUID().uuidString

    @Relationship(deleteRule: .cascade) var events: [Event]? = [Event]()

    init(
        brand: String,
        model: String,
        comment: String? = nil,
        millage: Double,
        id: String,
        events: [Event]? = nil
    ) {
        self.brand = brand
        self.model = model
        self.comment = comment
        self.millage = millage
        self.id = id
        self.events = events
    }
}

// MARK: - Property utils
extension Vehicle {
    var unwrappedEvents: [Event] {
        events ?? []
    }

    var unwrappedComment: String {
        comment ?? ""
    }

    var millageMeasurement: Measurement<UnitLength> {
        Measurement(value: millage, unit: UnitLength.kilometers)
    }
}
