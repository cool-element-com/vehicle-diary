//
//  SettingsView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-19.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.locale) var locale
    private let daysConstraints: [Int] = [
        7,
        14,
        21,
        28
    ]
    @AppStorage(Constants.EventApproachingConstraint.Key.daysConstraint)
    private var daysConstraint: Int = 28
    private let mileageConstraints: [Double] = [
        200,
        300,
        400,
        500,
    ]
    @AppStorage(Constants.EventApproachingConstraint.Key.mileageConstraint) 
    private var mileageConstraint: Double = 500

    var body: some View {
        NavigationStack {
            Form {
                Section("Event notifications") {
                    Picker("When occurrence date is within", selection: $daysConstraint) {
                        ForEach(daysConstraints, id: \.self) { days in
                            Text("\(days) days")
                        }
                    }

                    Picker("When occurrence mileage is within", selection: $mileageConstraint) {
                        ForEach(mileageConstraints, id: \.self) { mileage in
                            Text(
                                Measurement(
                                    value: mileage,
                                    unit: UnitLength.kilometers
                                )
                                .formatted(
                                    .measurement(
                                        width: .abbreviated,
                                        usage: .road
                                    ).locale(locale)
                                )
                            )
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
