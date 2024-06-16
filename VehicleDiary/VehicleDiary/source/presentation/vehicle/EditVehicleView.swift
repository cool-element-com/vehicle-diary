//
//  EditVehicleView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-14.
//

import SwiftUI
import SwiftData

struct EditVehicleView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var vehicle: Vehicle

    var body: some View {
        NavigationStack {
            Form {
                TextField("Brand", text: $vehicle.brand)
                TextField("Model", text: $vehicle.model)
                TextField("Comment (optional)",
                    text: Binding(
                        get: {
                            vehicle.unwrappedComment
                        },
                        set: { value in
                            vehicle.comment = value
                        })
                )
                TextField("Millage", value: $vehicle.millage, format: .number)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Update Vehicle")
            .navigationBarTitleDisplayMode(.inline)

            Button("Update") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                vehicle.brand.isEmpty
                ||
                vehicle.model.isEmpty
                ||
                vehicle.millage == nil
                ||
                vehicle.millage == 0
            )
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        let vehicle = Vehicle(brand: "Subaru", model: "Outback", comment: "hello", millage: 12345, id: UUID().uuidString)

        return EditVehicleView(vehicle: vehicle)
                .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
