//
//  VehicleRowView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-14.
//

import SwiftUI
import SwiftData

struct VehicleRowView: View {
    @Environment(\.locale) private var locale
    let vehicle: Vehicle

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(vehicle.brand) \(vehicle.model)")
                .font(.title3.bold())
            if !vehicle.unwrappedComment.isEmpty {
                Text(vehicle.unwrappedComment)
                    .font(.caption2).italic()
                    .padding(.bottom, 2)
                    .foregroundStyle(.secondary)
            }
            Text(
                vehicle.millageMeasurement.formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .road
                    ).locale(locale)
                )
            )
            .font(.subheadline)

        }
        .dynamicTypeSize(...DynamicTypeSize.large)
    }
}

#Preview("VehicleRowView") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        return List {
            ForEach(0..<20, id: \.self) { number in
                let vehicle = Vehicle(
                    brand: "Subaru",
                    model: "Outback",
                    comment: number.isMultiple(of: 2) ? "Comment \(number)" : nil ,
                    millage: 14503 + 1234 * Double(number),
                    id: UUID().uuidString
                )
                VehicleRowView(vehicle: vehicle)
                    .modelContainer(container)
            }
        }
        .listStyle(.plain)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
