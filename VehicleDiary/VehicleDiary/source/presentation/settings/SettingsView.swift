//
//  SettingsView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-19.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.locale) var locale
    private let daysConstraints = [
        7,
        14,
        21,
        28
    ]
    @State private var daysConstraint = 28
    private let mileageConstraints = [
        Measurement(value: 200, unit: UnitLength.kilometers),
        Measurement(value: 300, unit: UnitLength.kilometers),
        Measurement(value: 400, unit: UnitLength.kilometers),
        Measurement(value: 500, unit: UnitLength.kilometers),
    ]
    @State private var mileageConstraint = Measurement(value: 500, unit: UnitLength.kilometers)

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
                        ForEach(mileageConstraints, id: \.self) { measurement in
                            Text(
                                measurement
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
