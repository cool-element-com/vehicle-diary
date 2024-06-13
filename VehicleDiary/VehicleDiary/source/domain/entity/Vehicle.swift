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
    var name: String = "Unknown Vehicle"
    var millage: Int = 0
    var id: UUID = UUID()

    @Relationship(deleteRule: .cascade) var events: [Event]? = [Event]()

    var unwrappedEvents: [Event] {
        events ?? []
    }

    init(
        name: String,
        millage: Int,
        id: UUID
    ) {
        self.name = name
        self.millage = millage
        self.id = id
    }
}
