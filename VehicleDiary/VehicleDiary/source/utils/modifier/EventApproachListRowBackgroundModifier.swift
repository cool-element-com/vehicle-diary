//
//  EventApproachListRowBackgroundModifier.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-18.
//

import Foundation
import SwiftUI

struct EventApproachListRowBackgroundModifier: ViewModifier {
    let approach: VEvent.Approach
    let measurement: VEvent.Approach.Measurement

    init(
        approach: VEvent.Approach,
        measurement: VEvent.Approach.Measurement
    ) {
        self.approach = approach
        self.measurement = measurement
    }

    func body(content: Content) -> some View {
        switch (approach, measurement) {
        case (.inDays, .time),
            (.afterMileage, .millage):
            content
                .listRowBackground(Color.red.opacity(0.5))
        default:
            content
        }
    }
}

extension View {
    func eventApproachListRowBackground(
        approach: VEvent.Approach,
        measurement: VEvent.Approach.Measurement
    ) -> some View {
        modifier(EventApproachListRowBackgroundModifier(approach: approach, measurement: measurement))
    }
}
