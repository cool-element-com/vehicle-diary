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
    var millage: Double?
    var id: String = UUID().uuidString

    @Relationship(deleteRule: .cascade) var events: [VEvent]? = [VEvent]()

    init(
        brand: String,
        model: String,
        comment: String? = nil,
        millage: Double? = nil,
        id: String = UUID().uuidString,
        events: [VEvent]? = nil
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
    var unwrappedEvents: [VEvent] {
        events ?? []
    }

    var unwrappedComment: String {
        comment ?? ""
    }

    var unwrappedMillage: Double {
        millage ?? 0
    }

    var millageMeasurement: Measurement<UnitLength> {
        Measurement(value: unwrappedMillage, unit: UnitLength.kilometers)
    }
}
